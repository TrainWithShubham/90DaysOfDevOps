# Day 84 -- GitOps with ArgoCD

## Objective

Implement GitOps for the **Asma AI BankApp** on Amazon EKS using ArgoCD.
Git is the source of truth, and ArgoCD synchronizes the desired
Kubernetes state.

## Architecture

``` text
Developer → GitHub → ArgoCD → Amazon EKS
                              ├─ BankApp
                              ├─ MySQL
                              ├─ Ollama
                              ├─ HPA
                              └─ Gateway / HTTPS
```

## ArgoCD Application

The Application watches the `feat/gitops` branch and the `k8s`
directory.

``` yaml
syncPolicy:
  automated:
    prune: true
    selfHeal: true
  syncOptions:
    - CreateNamespace=true
    - ServerSideApply=true
```

-   `prune: true` removes managed resources that are removed from Git.
-   `selfHeal: true` corrects manual cluster drift.
-   `CreateNamespace=true` allows creation of the destination namespace.
-   `ServerSideApply=true` uses Kubernetes server-side apply.

## HPA Replica Drift Problem

ArgoCD became `OutOfSync` while the application itself was healthy. The
HPA was dynamically changing the BankApp Deployment replica count while
ArgoCD compared that value with Git.

``` text
ArgoCD → Deployment configuration
HPA    → dynamic replica count
```

### Fix

ArgoCD was told to ignore the HPA-managed replica field:

``` yaml
ignoreDifferences:
  - group: apps
    kind: Deployment
    name: bankapp
    namespace: bankapp
    jsonPointers:
      - /spec/replicas
```

After applying the fix, the Application returned to:

``` text
SYNC STATUS     HEALTH STATUS
Synced          Healthy
```

The configuration change was committed and pushed to the GitOps branch.

## Self-Healing Test

The BankApp Service was intentionally deleted from the live cluster:

``` bash
kubectl delete service bankapp-service -n bankapp
```

The Service still existed in Git, so ArgoCD detected drift and
automatically recreated it.

``` text
Git says Service exists
          ↓
Service manually deleted from EKS
          ↓
ArgoCD detects drift
          ↓
selfHeal: true
          ↓
Service recreated automatically
```

No manual recreation was performed.

Final verification:

``` bash
kubectl get applications -n argocd
```

Result:

``` text
SYNC STATUS     HEALTH STATUS
Synced          Healthy
```

## GitOps Flow

``` text
Change → Commit → Push to GitHub
                    ↓
                 ArgoCD
                    ↓
          Compare Git with EKS
                    ↓
             Synchronize
                    ↓
            Desired state
```

## Important Lessons

1.  **Git is the source of truth.**
2.  **Synced** means the live configuration matches the desired Git
    state.
3.  **Healthy** means the deployed resources are operating normally.
4.  HPA and ArgoCD need clear ownership; HPA owns replica scaling.
5.  ArgoCD self-healing can automatically correct manual Kubernetes
    drift.

## Interview Answer

**What is GitOps?**

GitOps is a way of managing Kubernetes where Git is the source of truth.
ArgoCD continuously compares the configuration in Git with the live
cluster and automatically synchronizes changes or corrects configuration
drift.

## Day 84 Result

-   ArgoCD configured for Asma AI BankApp
-   Git used as source of truth
-   Automated sync and self-healing enabled
-   HPA replica drift identified and fixed
-   Self-healing successfully tested
-   Deleted Service automatically restored
-   Final ArgoCD status: **Synced + Healthy**

**Day 84 -- GitOps with ArgoCD: COMPLETE**
