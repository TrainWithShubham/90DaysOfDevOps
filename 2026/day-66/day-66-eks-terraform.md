# Day 66: Provision an EKS Cluster with Terraform Modules

## Task 1: Project Setup & File Structure
Initialized a production-ready Terraform project structure separating providers, networking, cluster configurations, and variables.

**Complete File Structure:**
```text
terraform-eks/
├── providers.tf
├── variables.tf
├── terraform.tfvars
├── vpc.tf
├── eks.tf
└── outputs.tf
```

*Proof Reference: [Task 1 - Project Setup Screenshot](screenshots/task-01-project-setup.png)*

## Task 2: Create the VPC with Registry Module
Provisioned a 2-AZ Virtual Private Cloud using `terraform-aws-modules/vpc/aws`. Optimized costs by enabling a single NAT Gateway instead of one per AZ.

**Official AWS Documentation Answers:**
*   **Why does EKS need both public and private subnets?** 
    According to official AWS EKS documentation, worker nodes and Pods are placed in private subnets to protect them from direct internet access. Public subnets are required to host NAT Gateways (allowing nodes to pull container images from external registries) and to provision internet-facing Load Balancers that route external traffic to the private Pods.
*   **What do the subnet tags do?** 
    The AWS Load Balancer Controller uses these specific tags for auto-discovery:
    *   `kubernetes.io/role/elb = 1`: Instructs the controller to place external/public Application or Network Load Balancers in these public subnets.
    *   `kubernetes.io/role/internal-elb = 1`: Instructs the controller to place internal Load Balancers in these private subnets.

*Proof Reference: [Task 2 - VPC Plan Screenshot](screenshots/task-02-vpc-plan.png)*

## Task 3 & Task 4: Create EKS Cluster & Connect kubectl
Utilized `terraform-aws-modules/eks/aws` version `~> 20.0` to abstract the creation of the EKS Control Plane, Managed Node Groups, and associated IAM Roles/Security Groups.

**Total Resources Created:** 
The initial `terraform apply` created exactly **55 resources**. (An additional explicit AWS EKS Access Entry resource was created subsequently to map the local `terraform-admin` IAM user to the Kubernetes `ClusterAdmin` role to resolve a 401 Unauthorized API error).

**kubectl Verification:**
Successfully updated the local kubeconfig and authenticated using AWS STS:
```bash
aws eks update-kubeconfig --name terraweek-eks --region ap-south-1
kubectl get nodes
```

*Proof Reference: [Task 4 - kubectl nodes Screenshot](screenshots/task-04-kubectl-nodes.png)*

## Task 5: Deploy a Workload on the Cluster
Deployed a 3-replica Nginx Deployment and exposed it via a Kubernetes Service of `type: LoadBalancer`. This successfully triggered AWS to provision an Elastic Load Balancer (ELB) mapped to the EKS worker nodes.

```text
NAME            TYPE           CLUSTER-IP       EXTERNAL-IP                                                              PORT(S)        AGE
nginx-service   LoadBalancer   172.20.138.176   ac1f6481d53204e65997a909c91bd098-877639985.ap-south-1.elb.amazonaws.com   80:32636/TCP   112s
```

*Proof Reference: [Task 5 - Nginx Workload Screenshot](screenshots/task-05-nginx-workload.png)*

## Task 6: Destroy Everything & Reflection
**The Destroy Process:**
To ensure a clean teardown, the Kubernetes LoadBalancer must be deleted via `kubectl delete -f k8s/nginx-deployment.yaml` *before* running Terraform destroy. If this is skipped, the AWS Elastic Load Balancer will leave behind active Elastic Network Interfaces (ENIs) in the public subnets, causing `terraform destroy` to hang and ultimately fail due to the VPC being "in use".

**Verification:**
After deleting the k8s resources, `terraform destroy --auto-approve` successfully wiped the entire architecture cleanly.

*Proof Reference: [Task 6 - Destroy Complete Screenshot](screenshots/task-06-destroy-complete.png)*

**Reflection (EKS vs Minikube):**
On Day 50, setting up Minikube was a manual, localized process providing a single-node testing environment. In contrast, provisioning EKS via Terraform is a highly automated infrastructure-as-code approach that yields a production-ready, multi-AZ distributed architecture. Terraform abstracts away the immense complexity of AWS IAM Roles, Security Group cross-references, and Control Plane API configurations, executing an enterprise-grade setup in just 15 minutes.