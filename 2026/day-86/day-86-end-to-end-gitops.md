# Day 86 -- End-to-End GitOps CI/CD Pipeline with ArgoCD

## Goal

Deploy the updated **Asma AI BankApp** through:

**Code → GitHub → GitHub Actions → DockerHub → Git → ArgoCD → Amazon
EKS**

Then verify, troubleshoot, and clean up AWS resources.

## 1. Project Overview

-   Customized the frontend as **Asma AI BankApp**.
-   GitHub Actions handled the CI pipeline.
-   Maven built the Java application.
-   Docker built and pushed the application image.
-   The pipeline updated the Kubernetes image tag in Git.
-   ArgoCD reconciled Git with Amazon EKS.
-   Final application state reached **Synced + Healthy**.
-   Troubleshot a real `ImagePullBackOff` rollout issue.

## 2. Architecture

``` text
Developer Code Change
        ↓
      GitHub
        ↓
 GitHub Actions
        ↓
Build Java Application
        ↓
Build Docker Image
        ↓
Push to DockerHub
        ↓
Update Image Tag in Git
        ↓
      ArgoCD
        ↓
    Amazon EKS
        ↓
 Asma AI BankApp
```

**Main idea:** GitHub Actions builds and publishes the application.
ArgoCD deploys the desired state stored in Git.

## 3. GitHub Actions CI Pipeline

Workflow:

``` text
.github/workflows/gitops-ci.yml
```

Main steps: 1. Checkout code. 2. Configure Java 21. 3. Build with Maven.
4. Run tests. 5. Generate a short Git SHA. 6. Authenticate to DockerHub
using GitHub Secrets. 7. Build and push the Docker image. 8. Update the
Kubernetes Deployment image tag. 9. Commit the manifest change back to
Git using `[skip ci]`.

### Why use a Git SHA image tag?

A SHA tag identifies the exact application version that produced the
image. It makes deployments traceable and avoids depending only on
`latest`.

### Why `[skip ci]`?

The pipeline commits the updated image tag back to Git. `[skip ci]`
prevents that bot commit from unnecessarily triggering the workflow
again.

## 4. DockerHub Security

GitHub Secrets used:

``` text
DOCKERHUB_USERNAME
DOCKERHUB_TOKEN
```

Never commit the actual token or credentials to Git.

The initial DockerHub authentication failed. After correcting the secret
values, the GitHub Actions pipeline completed successfully.

## 5. GitOps with ArgoCD

``` text
Git = Desired State
       ↓
     ArgoCD
       ↓
Compare Git with live Kubernetes
       ↓
    Amazon EKS
```

Important statuses: - **Synced** -- Git matches the live cluster. -
**OutOfSync** -- Git and the cluster differ. - **Healthy** --
application resources are working. - **Progressing** -- Kubernetes is
still completing a rollout. - **Self-Heal** -- ArgoCD can correct
configuration drift.

The project also demonstrated the **App of Apps** pattern, where a root
ArgoCD Application manages child Applications.

## 6. HPA and ArgoCD

The BankApp uses a Horizontal Pod Autoscaler. Because HPA changes
Deployment replicas dynamically, ArgoCD was configured to ignore the
BankApp replica field:

``` yaml
ignoreDifferences:
  - group: apps
    kind: Deployment
    name: bankapp
    namespace: bankapp
    jsonPointers:
      - /spec/replicas
```

This prevents ArgoCD and HPA from fighting over replica count.

## 7. Troubleshooting Scenario

### Problem

The BankApp rollout failed with:

``` text
deployment "bankapp" exceeded its progress deadline
```

Pod status showed:

``` text
ImagePullBackOff
```

Pod events revealed Kubernetes was attempting to pull an old image tag
that was not available in the new DockerHub repository.

### Investigation

Compared the desired image in Git with the live Deployment:

``` bash
grep "image:" k8s/bankapp-deployment.yml

kubectl get deployment bankapp -n bankapp \
  -o jsonpath='{.spec.template.spec.containers[?(@.name=="bankapp")].image}{"\n"}'
```

Result:

``` text
Git desired image != Live Kubernetes image
```

ArgoCD showed:

``` text
OutOfSync
Progressing
```

Its operation message showed it was waiting for the BankApp Deployment
to become healthy.

### Fix

Applied the exact committed Deployment manifest:

``` bash
kubectl apply -f k8s/bankapp-deployment.yml
```

Then verified:

``` bash
kubectl rollout status deployment/bankapp -n bankapp --timeout=120s
```

Final result:

``` text
deployment "bankapp" successfully rolled out
```

ArgoCD returned to:

``` text
Synced
Healthy
```

### Troubleshooting Flow

``` text
Rollout problem
     ↓
Check Pods
     ↓
ImagePullBackOff
     ↓
Check Pod Events
     ↓
Old/missing image identified
     ↓
Compare Git vs Live Deployment
     ↓
Apply correct committed manifest
     ↓
Successful rollout
     ↓
ArgoCD Synced + Healthy
```

## 8. Useful Verification Commands

Check rollout:

``` bash
kubectl rollout status deployment/bankapp -n bankapp --timeout=120s
```

Check live image:

``` bash
kubectl get deployment bankapp -n bankapp \
  -o jsonpath='{.spec.template.spec.containers[?(@.name=="bankapp")].image}{"\n"}'
```

Check ArgoCD:

``` bash
kubectl get application asma-ai-bankapp -n argocd \
  -o custom-columns='NAME:.metadata.name,SYNC:.status.sync.status,HEALTH:.status.health.status'
```

Expected final status:

``` text
SYNC     HEALTH
Synced   Healthy
```

## 9. AWS Verification

Before cleanup: - Amazon EKS cluster was Active. - Three EC2 worker
nodes were running. - Worker node health checks passed. - BankApp
successfully ran on EKS.

**Security:** Blur/crop AWS account numbers, ARNs, endpoints, instance
IDs, node names, IPs, and infrastructure identifiers before publishing
screenshots.

## 10. Cleanup

Cleanup is important because EKS, EC2, NAT Gateway, load balancers, and
related AWS resources can continue generating charges.

Completed:

``` bash
kubectl delete application asma-app-of-apps -n argocd
kubectl delete application asma-ai-bankapp -n argocd
helm uninstall eg -n envoy-gateway-system
helm uninstall cert-manager -n cert-manager
```

Cert-manager kept some CRDs because of Helm resource policy. Since the
whole EKS cluster will be destroyed, they do not need separate cleanup
for this lab.

Terraform cleanup:

``` bash
cd terraform
terraform init -upgrade
terraform destroy
```

Review the destroy plan carefully before entering `yes`.

After destroy, verify the lab-created EKS cluster, EC2 workers, load
balancer, NAT Gateway, and related storage/resources are gone.

## 11. Tool Responsibilities

``` text
Terraform
   ↓
Creates AWS infrastructure

GitHub Actions
   ↓
Builds/tests application
Builds and pushes Docker image
Updates image tag in Git

ArgoCD
   ↓
Watches Git
Reconciles Kubernetes

Amazon EKS
   ↓
Runs the application
```

## 12. Interview Answers

### Explain your Day 86 project

I built an end-to-end GitOps CI/CD pipeline for a Java BankApp. GitHub
Actions builds the application, creates and pushes a Docker image, and
updates the Kubernetes image tag in Git. ArgoCD watches Git and deploys
the desired state to Amazon EKS.

### What problem did you troubleshoot?

The rollout became stuck with `ImagePullBackOff` because the live
Deployment referenced an unavailable old image tag. I checked pod
events, compared Git with the live Deployment, corrected the deployment
state, verified the rollout, and confirmed ArgoCD returned to Synced and
Healthy.

### Why doesn't CI deploy directly using kubectl?

In this GitOps design, CI updates Git and ArgoCD performs the
deployment. Git remains the source of truth.

### Terraform vs ArgoCD?

Terraform creates AWS infrastructure. ArgoCD manages Kubernetes
application state from Git.

## 13. Final Day 86 Status

``` text
Frontend customization        DONE
GitHub Actions CI             DONE
Java/Maven build              DONE
Docker image build            DONE
DockerHub push                DONE
SHA image tagging             DONE
Git manifest update           DONE
ArgoCD GitOps deployment      DONE
EKS rollout                   DONE
Troubleshooting               DONE
ArgoCD Synced + Healthy       DONE
App of Apps demonstration     DONE
AWS cleanup                   IN PROGRESS
```

## Key Lesson

> **CI builds and publishes the application. Git stores the desired
> deployment state. ArgoCD reconciles Amazon EKS with Git.**
