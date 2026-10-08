# Day 66 -- Provision an EKS Cluster with Terraform Modules

## Objective

Today I provisioned an AWS EKS cluster using Terraform Registry modules.
The goal was to create the networking and EKS infrastructure with
Terraform, connect `kubectl`, deploy an Nginx workload, verify it, and
clean up the AWS resources after the lab.

## Project Structure

``` text
terraform-eks/
├── eks.tf
├── outputs.tf
├── providers.tf
├── terraform.tfvars
├── variables.tf
├── vpc.tf
└── k8s/
    └── nginx-deployment.yaml
```

## What I Created

### 1. Terraform Providers

I configured the AWS provider and Kubernetes provider. The AWS region
used for this lab was:

``` text
ca-central-1
```

I also used `terraform.tfvars` to provide the region value.

### 2. VPC with Terraform Module

I used the Terraform Registry VPC module:

``` text
terraform-aws-modules/vpc/aws
```

The VPC included:

-   2 Availability Zones
-   2 public subnets
-   2 private subnets
-   NAT Gateway
-   DNS hostnames
-   EKS subnet tags

EKS uses private subnets for the worker nodes, while public subnets can
be used for public-facing AWS load balancers.

The subnet tags help Kubernetes/AWS identify which subnets can be used
for public or internal load balancers.

### 3. EKS Cluster

I used the Terraform EKS module:

``` text
terraform-aws-modules/eks/aws
```

My configuration created:

-   EKS cluster: `terraweek-eks`
-   Kubernetes version: `1.31`
-   Managed node group: `terraweek_nodes`
-   Instance type: `t3.medium`
-   Desired worker nodes: `2`
-   Public EKS API endpoint
-   IAM roles and security resources

The EKS worker nodes were placed in the private subnets created by the
VPC module.

## Terraform Validation and Plan

Before creating the infrastructure, I ran:

``` bash
terraform fmt
terraform validate
terraform plan
```

Terraform validation completed successfully.

The final plan showed:

``` text
Plan: 55 to add, 0 to change, 0 to destroy.
```

## Terraform Apply

I created the infrastructure with:

``` bash
terraform apply
```

The apply completed successfully:

``` text
Apply complete! Resources: 55 added, 0 changed, 0 destroyed.
```

### Screenshot

Add the screenshot showing the successful `terraform apply` here.

## Connecting kubectl to EKS

I updated my local kubeconfig using:

``` bash
aws eks update-kubeconfig --name terraweek-eks --region ca-central-1
```

The EKS context was added to:

``` text
/home/asma/.kube/config
```

Initially, `kubectl` returned a credentials error. I enabled cluster
creator administrator permissions in the EKS Terraform module:

``` hcl
enable_cluster_creator_admin_permissions = true
```

Terraform then added the required EKS access resources:

``` text
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

After updating kubeconfig again, `kubectl` successfully connected to the
cluster.

## Verify Worker Nodes

I ran:

``` bash
kubectl get nodes
```

Both managed worker nodes were in `Ready` state:

``` text
ip-10-0-11-218.ca-central-1.compute.internal   Ready
ip-10-0-12-6.ca-central-1.compute.internal    Ready
```

### Screenshot

Add the screenshot showing both EKS nodes in `Ready` state here.

## Deploy Nginx

I created:

``` text
k8s/nginx-deployment.yaml
```

The workload contained:

-   Nginx Deployment
-   3 replicas
-   Nginx container on port 80
-   Kubernetes Service of type `LoadBalancer`

I deployed it using:

``` bash
kubectl apply -f k8s/nginx-deployment.yaml
```

Then I verified the pods:

``` bash
kubectl get pods
```

All three Nginx pods were running successfully.

I also checked the service:

``` bash
kubectl get svc nginx-service
```

AWS successfully created an external LoadBalancer for the Nginx service.

### Screenshot

Add the screenshot showing the 3 running Nginx pods and the LoadBalancer
service here.

## Cleanup

Because EKS, EC2 worker nodes, NAT Gateway, and LoadBalancer resources
can generate AWS charges, cleanup is an important part of this lab.

First, I removed the Kubernetes resources:

``` bash
kubectl delete -f k8s/nginx-deployment.yaml
```

I verified that `nginx-service` was removed:

``` bash
kubectl get svc
```

Only the default Kubernetes `ClusterIP` service remained.

Next, the Terraform-managed infrastructure should be removed with:

``` bash
terraform destroy
```

After destruction, verify in AWS that the following lab resources are
gone:

-   EKS cluster
-   EC2 worker-node instances
-   VPC
-   NAT Gateway
-   Elastic IP
-   AWS LoadBalancer

### Destroy Screenshot

Add the final `Destroy complete!` screenshot here after cleanup is
complete.

> **Cleanup status:** At the time this document was created, the
> Kubernetes Nginx workload and LoadBalancer service had been deleted.
> Record the final Terraform destroy result here after
> `terraform destroy` completes.

## What I Learned

This lab helped me understand how Terraform modules can connect
together.

``` text
VPC Module
    ↓
Private/Public Subnets
    ↓
EKS Module
    ↓
EKS Cluster
    ↓
Managed Node Group
    ↓
EC2 Worker Nodes
    ↓
Kubernetes Pods
```

One important concept was using an output from one module as an input to
another:

``` hcl
vpc_id     = module.vpc.vpc_id
subnet_ids = module.vpc.private_subnets
```

Instead of manually creating every AWS resource, Terraform Registry
modules created the VPC, networking, IAM, security, EKS cluster, and
managed node group in a repeatable way.

## EKS vs kind/minikube

On Day 50, I practiced Kubernetes using a local cluster such as
kind/minikube. That was useful for learning Kubernetes objects and
commands.

In this lab, EKS was different because it created real AWS
infrastructure. AWS managed the Kubernetes control plane, while the
managed node group provided EC2 worker nodes.

The biggest lesson for me was:

**kind/minikube is useful for local Kubernetes practice, while EKS with
Terraform demonstrates how Kubernetes infrastructure can be provisioned
in AWS using Infrastructure as Code.**

## Result

I successfully:

-   Created AWS networking using a Terraform VPC module
-   Provisioned an EKS cluster using a Terraform EKS module
-   Created 2 managed EC2 worker nodes
-   Connected `kubectl` to EKS
-   Fixed EKS access permissions
-   Verified both nodes were `Ready`
-   Deployed 3 Nginx pods
-   Created and verified an AWS LoadBalancer
-   Deleted the Kubernetes workload and LoadBalancer service
-   Prepared the infrastructure for complete Terraform cleanup

This was a practical example of using **Terraform + AWS + EKS +
Kubernetes** together.
