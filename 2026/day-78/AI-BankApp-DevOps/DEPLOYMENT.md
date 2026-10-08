# Deployment Playbook — AI BankApp on EKS

Step-by-step commands to deploy the full stack. Run these in order.

## Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform >= 1.5.7
- kubectl
- Helm 3 (`brew install helm`)
- Docker (for local image builds)
- GitHub repo secrets: `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`

## Step 1: Provision Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply
# Takes ~15 minutes — creates VPC, EKS cluster (3 nodes), ArgoCD
```

## Step 2: Configure kubectl

```bash
aws eks update-kubeconfig --name bankapp-eks --region us-west-2
kubectl get nodes
# Should show 3 nodes in Ready state
```

## Step 3: Verify ArgoCD

```bash
# Check all pods are Running
kubectl get pods -n argocd

# Get ArgoCD URL
kubectl get svc argocd-server -n argocd \
  -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

# Get admin password
kubectl get secret argocd-initial-admin-secret -n argocd \
  -o jsonpath='{.data.password}' | base64 -d; echo

# Login: admin / <password>
```

## Step 4: Install Gateway API + Envoy Gateway

```bash
# Install Gateway API CRDs — MUST use --server-side
# Without it, Envoy Gateway helm install fails with CRD ownership conflicts
kubectl apply --server-side \
  -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.1/standard-install.yaml

# Install Envoy Gateway — MUST use --skip-crds since Gateway API CRDs already exist
helm install eg oci://docker.io/envoyproxy/gateway-helm \
  --version v1.2.6 \
  -n envoy-gateway-system \
  --create-namespace \
  --skip-crds \
  --wait

# --skip-crds also skips Envoy Gateway's own extension CRDs, install them separately
helm pull oci://docker.io/envoyproxy/gateway-helm --version v1.2.6 --untar -d /tmp/eg-chart
kubectl apply --server-side -f /tmp/eg-chart/gateway-helm/crds/generated/
kubectl rollout restart deployment envoy-gateway -n envoy-gateway-system

# Verify
kubectl get gatewayclass
```

## Step 5: Install cert-manager (TLS/HTTPS)

```bash
helm install cert-manager oci://quay.io/jetstack/charts/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set crds.enabled=true \
  --set config.enableGatewayAPI=true \
  --wait

# Verify
kubectl get pods -n cert-manager
```

After ArgoCD syncs the ClusterIssuer and updated Gateway (with HTTPS listener), cert-manager automatically provisions a Let's Encrypt TLS certificate.

**Prerequisite:** Create a CNAME in GoDaddy:
- `bankapp.trainwithshubham.com` → `<NLB hostname from Step 4>`

```bash
# Check certificate status
kubectl get certificate -n bankapp
kubectl get secret bankapp-tls -n bankapp
```

## Step 6: Install kube-prometheus-stack

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update prometheus-community

helm install kube-prometheus prometheus-community/kube-prometheus-stack \
  -n monitoring \
  --create-namespace \
  --set grafana.service.type=LoadBalancer \
  --wait

# Get Grafana URL
kubectl get svc kube-prometheus-grafana -n monitoring \
  -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

# Get Grafana password
kubectl get secret kube-prometheus-grafana -n monitoring \
  -o jsonpath='{.data.admin-password}' | base64 -d; echo

# Login: admin / <password>
```

## Step 7: Build & Push Docker Image

> CI does this automatically on push to `feat/gitops`. This step is only needed for the **first deploy** (image doesn't exist on DockerHub yet).

```bash
# IMPORTANT: EKS runs amd64 nodes. If building on Apple Silicon (M1/M2/M3),
# you MUST specify --platform linux/amd64 or pods will fail with:
#   "no match for platform in manifest: not found"

docker buildx build --platform linux/amd64 \
  -t trainwithshubham/ai-bankapp-eks:latest \
  --push .
```

## Step 8: Deploy via ArgoCD

```bash
kubectl apply -f argocd/application.yml

# Watch sync progress
kubectl get application bankapp -n argocd -w
```

## Step 9: Verify Everything

```bash
# All pods should be Running
kubectl get pods -n bankapp

# Check PVCs are Bound
kubectl get pvc -n bankapp

# Check Gateway has an address
kubectl get gateway -n bankapp

# Get the app URL (NLB created by Envoy Gateway)
kubectl get svc -n envoy-gateway-system \
  -l gateway.envoyproxy.io/owning-gateway-name=bankapp-gateway \
  -o jsonpath='{.items[0].status.loadBalancer.ingress[0].hostname}'

# Test — should return 302 (Spring Security redirect to /login)
curl -s -o /dev/null -w "%{http_code}" http://<APP_URL>/

# Test login page — should return 200
curl -s -o /dev/null -w "%{http_code}" -L http://<APP_URL>/login
```

## Step 10: Pull Ollama Model

```bash
# Ollama starts empty — pull the AI model
kubectl exec -n bankapp deploy/ollama -- ollama pull tinyllama
```

## Cleanup

> **ORDER MATTERS.** Helm-installed resources (Envoy Gateway, Grafana) create AWS Load Balancers
> and Security Groups outside of Terraform. If you run `terraform destroy` first, the EKS cluster
> is gone but those orphaned resources block VPC deletion. Always clean up in this order:

```bash
# 1. Delete ArgoCD app (removes Gateway → deletes Envoy Gateway NLB)
kubectl delete -f argocd/application.yml

# 2. Uninstall all Helm releases that created LoadBalancers/resources
helm uninstall cert-manager -n cert-manager
helm uninstall kube-prometheus -n monitoring
helm uninstall eg -n envoy-gateway-system

# 3. Delete Gateway API CRDs
kubectl delete -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.1/standard-install.yaml

# 4. Wait for Load Balancers to fully terminate (~30-60 seconds)
echo "Waiting for LBs to terminate..."
sleep 60

# 5. Verify no Load Balancers remain in the VPC
aws elb describe-load-balancers --region us-west-2 \
  --query 'LoadBalancerDescriptions[*].LoadBalancerName' --output text
# Should be empty. If not, delete manually:
# aws elb delete-load-balancer --load-balancer-name <name> --region us-west-2

# 6. Destroy infrastructure
cd terraform
terraform destroy
```

**If `terraform destroy` gets stuck on VPC deletion**, orphaned resources remain:
```bash
# Find and delete orphaned security groups
aws ec2 describe-security-groups --region us-west-2 \
  --filters Name=vpc-id,Values=<VPC_ID> \
  --query 'SecurityGroups[?GroupName!=`default`].[GroupId,GroupName]' --output table
aws ec2 delete-security-group --group-id <SG_ID> --region us-west-2

# Then delete the VPC manually
aws ec2 delete-vpc --vpc-id <VPC_ID> --region us-west-2

# Re-run terraform destroy to clean the state
terraform destroy
```

---

## Gotchas We Hit

### 1. Gateway API CRDs + Envoy Gateway Conflict
**Symptom:** `helm install` for Envoy Gateway fails with `conflict with "kubectl-client-side-apply"`.
**Cause:** `kubectl apply` uses client-side apply for CRDs. When Envoy Gateway tries to install the same CRDs via server-side apply, ownership conflicts.
**Fix:** Use `kubectl apply --server-side` for CRDs, then `--skip-crds` on helm install.

### 2. Docker Image Platform Mismatch
**Symptom:** Pods show `ErrImagePull` with error `no match for platform in manifest: not found`.
**Cause:** Building on Apple Silicon (arm64) produces arm64 images. EKS nodes are amd64.
**Fix:** Use `docker buildx build --platform linux/amd64 --push`. This does NOT apply to GitHub Actions CI (runs on ubuntu/amd64).

### 3. Image Doesn't Exist on First Deploy
**Symptom:** Pods show `ImagePullBackOff` with `repository does not exist or may require authorization`.
**Cause:** ArgoCD deploys immediately but CI hasn't pushed the first image to DockerHub yet.
**Fix:** Build and push the image manually (Step 6) before or right after applying the ArgoCD application.

### 4. Envoy Gateway Extension CRDs Missing After `--skip-crds`
**Symptom:** `BackendTrafficPolicy` resource fails with `no matches for kind`.
**Cause:** `--skip-crds` skips ALL CRDs, including Envoy Gateway's own extension CRDs (BackendTrafficPolicy, SecurityPolicy, etc.) — not just the Gateway API CRDs.
**Fix:**
```bash
helm pull oci://docker.io/envoyproxy/gateway-helm --version v1.2.6 --untar -d /tmp/eg-chart
kubectl apply --server-side -f /tmp/eg-chart/gateway-helm/crds/generated/
kubectl rollout restart deployment envoy-gateway -n envoy-gateway-system
```

### 5. Login Redirect Loop with Multiple Replicas Behind Envoy Gateway
**Symptom:** Login page keeps redirecting back to itself. No error message shown.
**Cause:** Envoy Gateway bypasses K8s Service `sessionAffinity: ClientIP` and load-balances directly to pod endpoints. With in-memory sessions, GET /login hits pod A (creates CSRF token), POST /login hits pod B (CSRF mismatch → silent redirect to /login).
**Fix:** Add `BackendTrafficPolicy` with cookie-based consistent hashing (in `k8s/gateway.yml`) and `SERVER_FORWARD_HEADERS_STRATEGY=native` in configmap.

### 6. `terraform destroy` Stuck on VPC Deletion
**Symptom:** `terraform destroy` hangs on VPC delete with `DependencyViolation`.
**Cause:** Helm-installed resources (Envoy Gateway, Grafana LB) created AWS Load Balancers and Security Groups outside Terraform. When EKS is destroyed first, these orphan and block VPC deletion.
**Fix:** Always uninstall Helm releases and delete the ArgoCD app BEFORE running `terraform destroy`. If already stuck, delete orphaned ELBs and SGs via AWS CLI (see Cleanup section above).

### 7. ArgoCD Shows OutOfSync After Manual Rollout Restart
**Symptom:** ArgoCD status shows `OutOfSync` even though app is healthy.
**Cause:** `kubectl rollout restart` adds a restartedAt annotation that doesn't match the Git manifest.
**Fix:** Not a problem — next CI push updates the manifest and ArgoCD syncs to it, resolving the drift.

---

## Access Summary

| Service | URL Command | Credentials |
|---------|------------|-------------|
| **BankApp** | `kubectl get svc -n envoy-gateway-system -l gateway.envoyproxy.io/owning-gateway-name=bankapp-gateway -o jsonpath='{.items[0].status.loadBalancer.ingress[0].hostname}'` | App login |
| **ArgoCD** | `kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'` | `admin` / see Step 3 |
| **Grafana** | `kubectl get svc kube-prometheus-grafana -n monitoring -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'` | `admin` / see Step 5 |
