1. Install Docker, Kind, and kubectl

Create an installation script named install.sh to install the required dependencies.

Run the Script

chmod +x install.sh
./install.sh

#########################################################################################

#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -o pipefail

echo "🚀 Starting installation of Docker, Kind, and kubectl..."

# ----------------------------
# 1. Install Docker
# ----------------------------
if ! command -v docker &>/dev/null; then
  echo "📦 Installing Docker..."
  sudo apt-get update -y
  sudo apt-get install -y docker.io

  echo "👤 Adding current user to docker group..."
  sudo usermod -aG docker "$USER"

  echo "✅ Docker installed and user added to docker group."
else
  echo "✅ Docker is already installed."
fi

# ----------------------------
# 2. Install Kind (based on architecture)
# ----------------------------
if ! command -v kind &>/dev/null; then
  echo "📦 Installing Kind..."

  ARCH=$(uname -m)
  if [ "$ARCH" = "x86_64" ]; then
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.29.0/kind-linux-amd64
  elif [ "$ARCH" = "aarch64" ]; then
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.29.0/kind-linux-arm64
  else
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
  fi

  chmod +x ./kind
  sudo mv ./kind /usr/local/bin/kind
  echo "✅ Kind installed successfully."
else
  echo "✅ Kind is already installed."
fi

# ----------------------------
# 3. Install kubectl (based on architecture)
# ----------------------------
if ! command -v kubectl &>/dev/null; then
  echo "📦 Installing kubectl (latest stable version)..."

  ARCH=$(uname -m)
  VERSION=$(curl -Ls https://dl.k8s.io/release/stable.txt)

  if [ "$ARCH" = "x86_64" ]; then
    curl -Lo ./kubectl "https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl"
  elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    curl -Lo ./kubectl "https://dl.k8s.io/release/${VERSION}/bin/linux/arm64/kubectl"
  else
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
  fi

  chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
  echo "✅ kubectl installed successfully."
else
  echo "✅ kubectl is already installed."
fi

# ----------------------------
# 4. Confirm Versions
# ----------------------------
echo
echo "🔍 Installed Versions:"
docker --version
kind --version
kubectl version --client --output=yaml

echo
echo "🎉 Docker, Kind, and kubectl installation complete!"

#########################################################################################

2. Create Kind Cluster Configuration

Create a configuration file named kind-config.yml to define the Kubernetes cluster structure.


kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: kind-cluster
nodes:
  - role: control-plane
    image: kindest/node:v1.35.1
  - role: worker
    image: kindest/node:v1.35.1
  - role: worker
    image: kindest/node:v1.35.1
  - role: worker
    image: kindest/node:v1.35.1

#########################################################################################

3. Create the Kind Cluster

Run the following command to create the cluster using the configuration file:

kind create cluster --config kind-config.yml

#########################################################################################

4. Verify the Cluster

Check if the nodes are running successfully:

kubectl get nodes

NAME                         STATUS   ROLES           AGE   VERSION
kind-cluster-control-plane   Ready    control-plane   18m   v1.35.1
kind-cluster-worker          Ready    <none>          18m   v1.35.1
kind-cluster-worker2         Ready    <none>          18m   v1.35.1
kind-cluster-worker3         Ready    <none>          18m   v1.35.1


docker ps
CONTAINER ID   IMAGE                  COMMAND                  CREATED         STATUS         PORTS                       NAMES
e69c5baf61a4   kindest/node:v1.35.1   "/usr/local/bin/entr…"   9 minutes ago   Up 9 minutes   127.0.0.1:37975->6443/tcp   kind-cluster-control-plane
1fbc74bd4b46   kindest/node:v1.35.1   "/usr/local/bin/entr…"   9 minutes ago   Up 9 minutes                               kind-cluster-worker2
87e3dd3a5ce1   kindest/node:v1.35.1   "/usr/local/bin/entr…"   9 minutes ago   Up 9 minutes                               kind-cluster-worker3
b0c526301e39   kindest/node:v1.35.1   "/usr/local/bin/entr…"   9 minutes ago   Up 9 minutes                               kind-cluster-worker



