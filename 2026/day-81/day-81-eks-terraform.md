# Day 81 -- Amazon EKS with Terraform

## Goal

Build a production-style Amazon EKS environment using Terraform and
deploy the AI BankApp application.

## Architecture

`Terraform → AWS VPC → EKS Cluster → Worker Nodes → Kubernetes Workloads`

## Infrastructure Created

-   Amazon EKS cluster `bankapp-eks`, Kubernetes 1.35, region
    `us-west-2`
-   Managed node group using `t3.medium`, with 3 worker nodes
-   VPC across 3 Availability Zones with public, private, and intra
    subnets
-   NAT Gateway, IAM roles, security groups, and KMS encryption
-   Argo CD installed through Terraform/Helm

## EKS Add-ons

-   **VPC CNI** -- Pod networking with VPC IP addresses
-   **CoreDNS** -- Kubernetes DNS
-   **kube-proxy** -- Service networking
-   **EBS CSI Driver** -- dynamic Amazon EBS storage
-   **Metrics Server** -- CPU/memory metrics for `kubectl top` and HPA
-   **EKS Pod Identity Agent** -- AWS permissions support for workloads

## Application Deployment

The Kubernetes application contained Spring Boot BankApp, MySQL, Ollama,
ConfigMap, Secret, Services, persistent storage, and HPA.

The ConfigMap supplied non-sensitive settings such as MySQL host/port,
database name, and Ollama URL. Kubernetes Secret supplied sensitive
application configuration. Base64 is encoding, not encryption;
production environments should use a stronger secret-management approach
such as AWS Secrets Manager/External Secrets.

## Persistent Storage

A `gp3` StorageClass used the EBS CSI driver:

`PVC → gp3 StorageClass → EBS CSI Driver → AWS EBS → PV`

-   MySQL: 5 GiB
-   Ollama: 10 GiB

Both PVCs became `Bound`.

## MySQL and Ollama

MySQL 8.0 used persistent storage at `/var/lib/mysql` and
readiness/liveness checks.

Ollama exposed port `11434`, stored data on a 10 GiB volume, and pulled
the `tinyllama` model.

## BankApp

The Spring Boot deployment used init containers to wait for MySQL and
Ollama before starting. It exposed port `8080` and used
`/actuator/health` for health checks.

## Horizontal Pod Autoscaler

-   Minimum Pods: 2
-   Maximum Pods: 4
-   CPU target: 70%

The application initially ran 4 replicas and HPA later reduced it to 2
because CPU usage was low. HPA scales Pods; node autoscaling requires a
separate solution such as Karpenter or Cluster Autoscaler.

## Validation

``` bash
kubectl get nodes
kubectl get pods -A
kubectl get pvc -n bankapp
kubectl top pods -n bankapp
kubectl port-forward -n bankapp svc/bankapp-service 8080:8080
```

All three worker nodes became Ready, system components were healthy, and
the BankApp ran successfully. The login page opened and a test
registration succeeded, confirming application-to-database
communication.

## Interview Explanation

> I provisioned an Amazon EKS cluster using Terraform in a multi-AZ VPC.
> I used an EKS managed node group and deployed a Spring Boot
> application with MySQL and Ollama. I configured dynamic EBS storage,
> health checks, Services, ConfigMaps, Secrets, Metrics Server, HPA, and
> Argo CD.

## Result

-   EKS and 3 worker nodes working
-   BankApp, MySQL, and Ollama deployed
-   Dynamic EBS storage working
-   Metrics Server and HPA working
-   Argo CD installed
