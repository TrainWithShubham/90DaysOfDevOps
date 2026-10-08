# AI BankApp - End-to-End GitOps on EKS

Complete guide to deploy AI BankApp on AWS EKS using Terraform, ArgoCD, Gateway API, and Prometheus monitoring.

## Architecture

```
Developer Push → GitHub Actions CI → DockerHub → ArgoCD → EKS Cluster
                                                    ↑
                                          watches k8s/ manifests
```

```
                        ┌─────────────────────────────────────────────────┐
                        │                 VPC (10.0.0.0/16)               │
                        │                                                 │
                        │  ┌──────────────┐ ┌──────────────┐ ┌────────┐  │
                        │  │ Public Sub    │ │ Public Sub    │ │Pub Sub │  │
                        │  │ 10.0.1.0/24  │ │ 10.0.2.0/24  │ │.3.0/24 │  │
                        │  │  (us-west-2a) │ │  (us-west-2b) │ │ (2c)  │  │
                        │  └──────┬───────┘ └──────┬───────┘ └───┬────┘  │
                        │         │ NAT GW                       │        │
                        │  ┌──────┴───────┐ ┌──────────────┐ ┌───┴────┐  │
                        │  │ Private Sub   │ │ Private Sub   │ │Priv Sub│  │
                        │  │ 10.0.4.0/24  │ │ 10.0.5.0/24  │ │.6.0/24 │  │
                        │  │ (Worker Nodes)│ │ (Worker Nodes)│ │(Nodes) │  │
                        │  └──────────────┘ └──────────────┘ └────────┘  │
                        │  ┌──────────────┐ ┌──────────────┐ ┌────────┐  │
                        │  │  Intra Sub    │ │  Intra Sub    │ │Intra   │  │
                        │  │  10.0.7.0/24  │ │  10.0.8.0/24  │ │.9.0/24│  │
                        │  │ (Ctrl Plane)  │ │ (Ctrl Plane)  │ │(Ctrl)  │  │
                        │  └──────────────┘ └──────────────┘ └────────┘  │
                        └─────────────────────────────────────────────────┘
```

| Component | Tool |
|-----------|------|
| Infrastructure | Terraform (VPC + EKS + ArgoCD) |
| CI Pipeline | GitHub Actions → DockerHub |
| GitOps / CD | ArgoCD (auto-sync from `k8s/` folder) |
| Ingress | Gateway API + Envoy Gateway (AWS NLB) |
| Monitoring | kube-prometheus-stack (Prometheus + Grafana) |
| AI Chatbot | Ollama (tinyllama) on EKS |
| Storage | EBS CSI Driver (gp3 dynamic provisioning) |

## What Gets Created

| Resource | Details |
|---|---|
| **VPC** | `10.0.0.0/16` across 3 AZs with public, private, and intra subnets |
| **NAT Gateway** | Single NAT for private subnet internet access |
| **EKS Cluster** | `bankapp-eks` running Kubernetes **1.35** |
| **Node Group** | `bankapp-ng` — 3x `t3.medium` instances on AL2023 |
| **Add-ons** | CoreDNS, kube-proxy, VPC-CNI, Pod Identity Agent, EBS CSI Driver |
| **ArgoCD** | Installed via Helm, exposed as LoadBalancer |

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5.7
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) v2 (configured with `aws configure`)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm 3](https://helm.sh/docs/intro/install/)
- GitHub repo secrets:
  - `DOCKERHUB_USERNAME` — DockerHub username
  - `DOCKERHUB_TOKEN` — DockerHub access token

## 1. Provision EKS Cluster

```bash
cd terraform
terraform init
terraform plan
terraform apply    # ~15 minutes
```

This creates the VPC, EKS cluster, node group, add-ons, and ArgoCD.

## 2. Configure kubectl

```bash
aws eks update-kubeconfig --name bankapp-eks --region us-west-2
kubectl get nodes
```

## 3. Access ArgoCD

```bash
# Get the ArgoCD server URL (AWS NLB)
kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

# Get the initial admin password
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 -d
```

Login: username = `admin`, password = output from above.

## 4. Install Gateway API + Envoy Gateway

```bash
# Install Gateway API CRDs (must use --server-side to avoid ownership conflicts with Envoy Gateway)
kubectl apply --server-side -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.1/standard-install.yaml

# Install Envoy Gateway via Helm (--skip-crds since Gateway API CRDs are already installed above)
helm install eg oci://docker.io/envoyproxy/gateway-helm \
  --version v1.2.6 \
  -n envoy-gateway-system \
  --create-namespace \
  --skip-crds \
  --wait

# --skip-crds also skips Envoy Gateway extension CRDs (BackendTrafficPolicy etc.)
# Install them separately, then restart the controller to pick them up
helm pull oci://docker.io/envoyproxy/gateway-helm --version v1.2.6 --untar -d /tmp/eg-chart
kubectl apply --server-side -f /tmp/eg-chart/gateway-helm/crds/generated/
kubectl rollout restart deployment envoy-gateway -n envoy-gateway-system

# Verify GatewayClass is registered
kubectl get gatewayclass
```

On EKS, Envoy Gateway automatically provisions an AWS NLB when a Gateway resource is created.

## 5. Install cert-manager (HTTPS/TLS)

```bash
helm install cert-manager oci://quay.io/jetstack/charts/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set crds.enabled=true \
  --set config.enableGatewayAPI=true \
  --wait
```

cert-manager integrates with Gateway API to auto-provision Let's Encrypt TLS certificates.
The `ClusterIssuer` and HTTPS listener are defined in `k8s/cert-manager.yml` and `k8s/gateway.yml` — ArgoCD syncs them automatically.

**DNS setup (GoDaddy):** Create a CNAME record:
- `bankapp.trainwithshubham.com` → `<NLB hostname from Gateway>`

```bash
# Verify cert-manager
kubectl get pods -n cert-manager

# Check certificate (after ArgoCD syncs and DNS propagates)
kubectl get certificate -n bankapp
kubectl describe certificate -n bankapp
```

## 6. Install kube-prometheus-stack

```bash
# Add Helm repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Install kube-prometheus-stack
helm install kube-prometheus prometheus-community/kube-prometheus-stack \
  -n monitoring \
  --create-namespace \
  --set grafana.service.type=LoadBalancer \
  --wait
```

Access Grafana:

```bash
# Get Grafana URL
kubectl get svc kube-prometheus-grafana -n monitoring -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

# Get admin password
kubectl get secret kube-prometheus-grafana -n monitoring -o jsonpath='{.data.admin-password}' | base64 -d; echo
# Login: admin / <password from above>
```

Access Prometheus (port-forward):

```bash
kubectl port-forward svc/kube-prometheus-kube-prome-prometheus 9090:9090 -n monitoring
# Open http://localhost:9090
```

## 7. Deploy Application via ArgoCD

### Option A: CLI

```bash
kubectl apply -f argocd/application.yml
```

### Option B: ArgoCD UI

1. Open ArgoCD UI (URL from Step 3)
2. Click **New App** → fill in:
   - **Name:** `bankapp`
   - **Project:** `default`
   - **Repo URL:** `https://github.com/TrainWithShubham/AI-BankApp-DevOps.git`
   - **Revision:** `feat/gitops`
   - **Path:** `k8s`
   - **Cluster:** `https://kubernetes.default.svc`
   - **Namespace:** `bankapp`
3. Enable **Auto-Sync** + **Self-Heal** + **Prune**
4. Click **Create**

ArgoCD deploys everything from `k8s/`:

| Resource | What it does |
|----------|-------------|
| `namespace.yml` | Creates `bankapp` namespace |
| `pv.yml` | gp3 StorageClass (EBS CSI dynamic provisioning) |
| `pvc.yml` | PVCs for MySQL (5Gi) and Ollama (10Gi) |
| `configmap.yml` | DB host, port, Ollama URL |
| `secrets.yml` | DB credentials |
| `mysql-deployment.yml` | MySQL 8.0 with EBS volume |
| `ollama-deployment.yml` | Ollama AI with tinyllama model |
| `bankapp-deployment.yml` | BankApp (2 replicas, HPA enabled) |
| `service.yml` | ClusterIP services for all components |
| `gateway.yml` | Gateway API → external access via NLB |
| `hpa.yml` | Auto-scale BankApp 2-4 replicas |

## 8. Verify Deployment

```bash
# Pods
kubectl get pods -n bankapp

# Services
kubectl get svc -n bankapp

# Gateway + NLB
kubectl get gateway -n bankapp

# Get the app URL
export APP_URL=$(kubectl get svc -n envoy-gateway-system \
  -l gateway.envoyproxy.io/owning-gateway-name=bankapp-gateway \
  -o jsonpath='{.items[0].status.loadBalancer.ingress[0].hostname}')
echo "BankApp: http://$APP_URL"
```

## 9. CI/CD Pipeline (GitOps Flow)

```
Code Push → GitHub Actions → Build & Push to DockerHub → Update k8s manifest → ArgoCD auto-sync → EKS
```

1. **Developer** pushes code changes to `feat/gitops`
2. **GitHub Actions** (`.github/workflows/gitops-ci.yml`):
   - Builds the Spring Boot app with Maven
   - Builds Docker image
   - Pushes `trainwithshubham/ai-bankapp-eks:<sha>` to DockerHub
   - Updates `k8s/bankapp-deployment.yml` with new image tag
   - Commits with `[skip ci]`
3. **ArgoCD** detects the manifest change → auto-syncs to EKS
4. **EKS** performs rolling update with zero downtime

### GitHub Secrets Required

Set in repo → Settings → Secrets → Actions:

| Secret | Value |
|--------|-------|
| `DOCKERHUB_USERNAME` | DockerHub username |
| `DOCKERHUB_TOKEN` | DockerHub access token |

## 10. ArgoCD Add-ons

| Add-on | Purpose | Install |
|--------|---------|---------|
| **Image Updater** | Auto-update image tags from registries | `helm install argocd-image-updater argo/argocd-image-updater -n argocd` |
| **Notifications** | Slack/Teams alerts on sync events | Built into argo-cd chart, configure via ConfigMap |
| **Rollouts** | Blue/Green and Canary deployments | `kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml` |
| **ApplicationSets** | Template-driven multi-cluster apps | Built into ArgoCD 2.x |

## 11. Cleanup

> **Order matters** — Helm releases create AWS Load Balancers outside Terraform.
> Delete them first or `terraform destroy` will hang on VPC deletion.

```bash
# 1. Delete ArgoCD app (removes Gateway → NLB)
kubectl delete -f argocd/application.yml

# 2. Uninstall Helm releases
helm uninstall cert-manager -n cert-manager
helm uninstall kube-prometheus -n monitoring
helm uninstall eg -n envoy-gateway-system

# 3. Wait for LBs to terminate
sleep 60

# 4. Destroy infrastructure
cd terraform
terraform destroy
```

See [`DEPLOYMENT.md`](../DEPLOYMENT.md#cleanup) for detailed cleanup steps and troubleshooting if VPC deletion gets stuck.

## Project Structure

```
.
├── terraform/
│   ├── provider.tf        # Terraform + AWS + Helm providers
│   ├── variables.tf       # Configurable inputs (region, cluster, nodes)
│   ├── vpc.tf             # VPC module — public, private, intra subnets
│   ├── eks.tf             # EKS module — cluster, node group, add-ons
│   ├── argocd.tf          # ArgoCD Helm release
│   ├── outputs.tf         # Cluster info, kubectl command, ArgoCD password
│   └── terraform.tfvars   # Default variable values
├── k8s/                   # Application manifests (ArgoCD watches this)
├── argocd/
│   └── application.yml    # ArgoCD Application pointing to k8s/
└── .github/workflows/
    └── gitops-ci.yml      # CI → DockerHub → manifest update
```

## Module Versions

| Module | Version | Registry |
|---|---|---|
| terraform-aws-modules/eks/aws | ~> 21.0 | [Terraform Registry](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest) |
| terraform-aws-modules/vpc/aws | ~> 6.0 | [Terraform Registry](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) |
| hashicorp/aws provider | ~> 6.0 | [Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest) |
| argoproj/argo-cd (Helm) | latest | [Artifact Hub](https://artifacthub.io/packages/helm/argo/argo-cd) |

## Troubleshooting

```bash
# ArgoCD app status
kubectl get applications -n argocd
kubectl describe application bankapp -n argocd

# Pod logs
kubectl logs -l app=bankapp -n bankapp --tail=50

# EBS PVC status (should be Bound)
kubectl get pvc -n bankapp

# Gateway status
kubectl get gateway,httproute -n bankapp
```
