# Day 66 — Provision an EKS Cluster with Terraform Modules

## What We Built

A production-grade AWS EKS cluster provisioned entirely through Terraform registry modules — VPC, subnets, NAT gateway, IAM roles, security groups, node groups, KMS encryption — 72 resources created with one command.

---

## Project Structure

~~~
terraform-eks/
  providers.tf        # Provider and version config
  vpc.tf              # VPC module call
  eks.tf              # EKS module call
  variables.tf        # All input variables
  outputs.tf          # Cluster outputs
  terraform.tfvars    # Variable values
  k8s/
    nginx-deployment.yaml  # Nginx workload
~~~

---

## Task 1 — Providers and Variables

### `providers.tf`

~~~hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.region
}
~~~

### `variables.tf`

~~~hcl
variable "region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
  default     = "terraweek-eks"
}

variable "cluster_version" {
  description = "EKS Cluster version"
  type        = string
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.small"
}

variable "node_desired_count" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "ami_type" {
  description = "AMI type for EKS nodes"
  type        = string
}
~~~

### `terraform.tfvars`

~~~hcl
region             = "us-east-2"
cluster_name       = "terraweek-eks"
cluster_version    = "1.35"
ami_type           = "AL2023_x86_64_STANDARD"
node_instance_type = "t3.small"
node_desired_count = 3
min_size           = 1
max_size           = 5
~~~

---

## Task 2 — VPC with Registry Module

### `vpc.tf`

~~~hcl
data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = {
    Environment = "Dev"
    Project     = "TerraWeek"
    ManagedBy   = "Terraform"
  }
}
~~~

**Why EKS needs both public and private subnets:**
- **Private subnets** — worker nodes live here, not directly exposed to internet
- **Public subnets** — NAT Gateway lives here, allows nodes to pull images outbound. Also where internet-facing Load Balancers are placed
- **NAT Gateway** — allows private subnet nodes to reach internet (ECR, EKS API) without being publicly accessible

**What subnet tags do:**
- `kubernetes.io/role/elb = 1` → tells EKS to place internet-facing LoadBalancer services here
- `kubernetes.io/role/internal-elb = 1` → tells EKS to place internal LoadBalancer services here
- Without these tags, `kubectl` services of type `LoadBalancer` won't provision correctly

---

## Task 3 — EKS Cluster with Registry Module

### `eks.tf`

~~~hcl
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    terraweek-nodes = {
      ami_type       = var.ami_type
      instance_types = [var.node_instance_type]
      min_size       = var.min_size
      max_size       = var.max_size
      desired_size   = var.node_desired_count
    }
  }

  tags = {
    Environment = "Dev"
    Project     = "TerraWeek"
    ManagedBy   = "Terraform"
  }
}
~~~

### `outputs.tf`

~~~hcl
output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_region" {
  description = "AWS region"
  value       = var.region
}
~~~

---

## Task 4 — Apply and Connect kubectl

~~~bash
# Initialize — downloads EKS module + all dependencies
terraform init

# Review — 70+ resources planned
terraform plan

# Apply — takes 10-15 minutes
terraform apply
~~~

**Apply output:**
~~~
Apply complete! Resources: 59 added, 0 changed, 0 destroyed.

Outputs:
cluster_endpoint = "https://483BE51168897559E4191769D56A079A.gr7.us-east-2.eks.amazonaws.com"
cluster_name     = "terraweek-eks"
cluster_region   = "us-east-2"
~~~

**Connect kubectl:**
~~~bash
aws eks update-kubeconfig \
  --name terraweek-eks \
  --region us-east-2
~~~

**Verify nodes:**
~~~bash
kubectl get nodes -o wide
~~~

~~~
NAME                                       STATUS   ROLES  AGE  VERSION
ip-10-0-1-102.us-east-2.compute.internal  Ready    none   22m  v1.35.2-eks-f69f56f
ip-10-0-2-231.us-east-2.compute.internal  Ready    none   22m  v1.35.2-eks-f69f56f
ip-10-0-3-201.us-east-2.compute.internal  Ready    none   22m  v1.35.2-eks-f69f56f
~~~

**3 nodes — one per AZ, all Ready ✅**

**Verify system pods:**
~~~bash
kubectl get pods -A
~~~

~~~
NAMESPACE    NAME                    READY  STATUS   AGE
kube-system  aws-node-4q9j5          2/2    Running  23m
kube-system  aws-node-l74dt          2/2    Running  23m
kube-system  aws-node-wr228          2/2    Running  23m
kube-system  coredns-b74dcdb4-c9t6k  1/1    Running  27m
kube-system  coredns-b74dcdb4-pxtv9  1/1    Running  27m
kube-system  kube-proxy-5gwd4        1/1    Running  23m
kube-system  kube-proxy-8tmtc        1/1    Running  23m
kube-system  kube-proxy-bzf8l        1/1    Running  23m
~~~

**What each system pod does:**
- `aws-node` × 3 — AWS VPC CNI plugin, one per node, manages pod networking
- `coredns` × 2 — Kubernetes DNS, HA across 2 nodes
- `kube-proxy` × 3 — Network rules on each node for service routing

~~~bash
kubectl cluster-info
~~~

~~~
Kubernetes control plane is running at https://483BE51168897559E4191769D56A079A.gr7.us-east-2.eks.amazonaws.com
CoreDNS is running at .../api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
~~~

---

## Task 5 — Deploy Nginx Workload

### `k8s/nginx-deployment.yaml`

~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-terraweek
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: LoadBalancer
  selector:
    app: nginx
  ports:
  - port: 80
    targetPort: 80
~~~

~~~bash
kubectl apply -f k8s/nginx-deployment.yaml

# Wait for LoadBalancer external IP
kubectl get svc nginx-service -w

# Verify everything
kubectl get nodes
kubectl get deployments
kubectl get pods
kubectl get svc
~~~

---

## Task 6 — Destroy Everything

~~~bash
# Step 1 — delete k8s resources first (removes AWS LoadBalancer)
kubectl delete -f k8s/nginx-deployment.yaml

# Step 2 — wait for LB to be fully removed in AWS console
# EC2 → Load Balancers → verify empty

# Step 3 — destroy all Terraform resources
terraform destroy
~~~

**Why delete k8s resources before destroy?**
The Nginx Service of type `LoadBalancer` creates an AWS ELB. If you run `terraform destroy` first, the ELB still exists and holds ENIs inside the VPC — Terraform cannot delete the VPC and gets stuck. Always clean up k8s LoadBalancer services first.

**Post-destroy verification:**
- EKS clusters → empty ✅
- EC2 instances → no node group instances ✅
- VPC → terraweek VPC gone ✅
- NAT Gateways → deleted ✅
- Elastic IPs → released ✅

---

## What the EKS Module Created (72 resources)

| Resource | Count | Purpose |
|---|---|---|
| `aws_eks_cluster` | 1 | Control plane |
| `aws_eks_node_group` | 1 | Managed worker nodes |
| `aws_launch_template` | 1 | Node launch config |
| `aws_iam_role` | 2 | Cluster + node group roles |
| `aws_iam_role_policy_attachment` | 5 | Required IAM policies |
| `aws_iam_policy` | 2 | Custom + encryption policies |
| `aws_security_group` | 2 | Cluster + node SGs |
| `aws_security_group_rule` | 10 | Inter-component rules |
| `aws_kms_key` + alias | 2 | Secrets encryption |
| `aws_cloudwatch_log_group` | 1 | Control plane logs |
| `aws_iam_openid_connect_provider` | 1 | IRSA support |
| VPC resources | 14+ | VPC, subnets, IGW, NAT, routes |

**All of this from ~30 lines of HCL in `eks.tf`.**

---

## Troubleshooting Encountered

### AWS India Account Restriction
**Error:** `InvalidParameterCombination - not eligible for Free Tier`
**Cause:** AWS India accounts (`Amazon Web Services India Private Limited`) have additional EC2 launch restrictions via Auto Scaling Fleet for non-free-tier instances.
**Fix:** `t3.small` worked as it falls under a different threshold. Raised quota increase request for `t3.medium`.

### kubectl connection refused
**Error:** `dial tcp 127.0.0.1:8080: connect: connection refused`
**Cause:** kubeconfig not updated after cluster creation.
**Fix:**
~~~bash
aws eks update-kubeconfig --name terraweek-eks --region us-east-2
~~~

### Nodes not visible in EKS Console
**Cause:** IAM user not added to EKS access config.
**Fix:**
~~~bash
aws eks create-access-entry \
  --cluster-name terraweek-eks \
  --principal-arn arn:aws:iam::<account-id>:user/Shivkumar \
  --region us-east-2

aws eks associate-access-policy \
  --cluster-name terraweek-eks \
  --principal-arn arn:aws:iam::<account-id>:user/Shivkumar \
  --policy-arn arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy \
  --access-scope type=cluster \
  --region us-east-2
~~~

### Private subnets with no NAT Gateway
**Cause:** Nodes in private subnets couldn't reach internet to bootstrap.
**Fix:** `enable_nat_gateway = true` + `single_nat_gateway = true` in VPC module.

---

## EKS vs Manual Cluster (kind/minikube)

| Aspect | Manual (kind/minikube) | EKS via Terraform |
|---|---|---|
| Setup time | 5 minutes | 15 minutes |
| HA control plane | ❌ | ✅ AWS managed |
| Multi-node | Limited | ✅ Auto Scaling |
| Cost | Free | ~$0.27/hour |
| Production ready | ❌ | ✅ |
| Repeatable | Manual steps | One command |
| Destroy | Manual | `terraform destroy` |
| IAM integration | ❌ | ✅ IRSA |
| Load Balancers | ❌ | ✅ AWS ELB |

---

## Key Commands Reference

~~~bash
# Initialize and apply
terraform init
terraform plan
terraform apply

# Connect kubectl
aws eks update-kubeconfig --name <cluster-name> --region <region>

# Verify cluster
kubectl get nodes -o wide
kubectl get pods -A
kubectl cluster-info

# Deploy workload
kubectl apply -f k8s/nginx-deployment.yaml
kubectl get svc -w

# Clean destroy sequence
kubectl delete -f k8s/nginx-deployment.yaml
terraform destroy
~~~

---

## Cost Warning

| Resource | Cost/hour |
|---|---|
| EKS Control Plane | $0.10 |
| t3.small × 3 nodes | $0.06 |
| NAT Gateway | $0.045 |
| **Total** | **~$0.21/hour** |

**Always `terraform destroy` immediately after practice.**

---

*Day 66 of #90DaysOfDevOps | #TerraWeek | #TrainWithShubham*
