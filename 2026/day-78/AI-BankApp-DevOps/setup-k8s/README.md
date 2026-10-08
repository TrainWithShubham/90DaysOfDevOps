# Kind Cluster Setup

## Prerequisites

Install these three tools if you don't have them already.

**Docker** — Kind runs clusters inside Docker containers.

```bash
# macOS
brew install --cask docker

# Ubuntu/Debian
sudo apt-get update && sudo apt-get install -y docker.io
sudo usermod -aG docker $USER && newgrp docker  
```

**kubectl** — CLI to talk to your cluster.

```bash
# macOS
brew install kubectl

# Linux
curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin/
```

**Kind** — runs K8s clusters locally using Docker.

```bash
# macOS
brew install kind

# Linux
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x kind && sudo mv kind /usr/local/bin/
```

## 1. Build the BankApp image

```bash
docker build -t trainwithshubham/bankapp:k8s .
```

## 2. Create the cluster

```bash
kind create cluster --config setup-k8s/kind-config.yml
```

## 3. Load the image into Kind

Kind can't pull from your local Docker daemon — you need to explicitly load images into the cluster.

```bash
kind load docker-image trainwithshubham/bankapp:k8s --name tws-cluster
```

## 4. Install metrics-server

HPA needs real CPU/memory numbers. Without this, `kubectl top` and autoscaling won't work.

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

Kind uses self-signed certs, so metrics-server can't verify kubelet TLS — patch it:

```bash
kubectl patch deployment metrics-server -n kube-system \
  --type='json' \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'
```

Wait for it to be ready:

```bash
kubectl rollout status deployment/metrics-server -n kube-system --timeout=120s
```

## 5. Install Kubernetes Dashboard

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl apply -f k8s/dashboard-admin.yml
```

Generate a login token:

```bash
kubectl -n kubernetes-dashboard create token dashboard-admin
```

Start the proxy and open the dashboard:

```bash
kubectl proxy
```

```
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```

Select **Token**, paste the token, and sign in.

## 6. Apply manifests

Order matters — namespace and config first, then storage, then workloads.

```bash
kubectl apply -f k8s/namespace.yml
kubectl apply -f k8s/configmap.yml
kubectl apply -f k8s/secrets.yml
kubectl apply -f k8s/pv.yml
kubectl apply -f k8s/pvc.yml
kubectl apply -f k8s/mysql-deployment.yml
kubectl apply -f k8s/ollama-deployment.yml
kubectl apply -f k8s/bankapp-deployment.yml
kubectl apply -f k8s/service.yml
kubectl apply -f k8s/hpa.yml
```

## 7. Verify

```bash
kubectl get all -n bankapp
kubectl get hpa -n bankapp            # wait ~60s for metrics to populate
kubectl top pods -n bankapp
```

App will be at **http://localhost:8080** once pods are ready.

## 8. Test HPA (autoscaling)

Generate CPU load on bankapp to trigger scale-up:

```bash
kubectl run load-test --image=busybox:1.36 -n bankapp -- sh -c "while true; do wget -q -O- http://bankapp-service:8080/actuator/health >/dev/null 2>&1; done"
```

Watch replicas scale from 2 → 4 (takes ~1-2 min for metrics to kick in):

```bash
kubectl get hpa -n bankapp -w
```

Clean up when done:

```bash
kubectl delete pod load-test -n bankapp
```

Scale-down happens automatically after 5 minutes of low CPU.
