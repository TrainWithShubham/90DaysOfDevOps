# Day 85 - ArgoCD Deep Dive: GitOps Operations

## Objective

Day 85 focused on deeper ArgoCD operations for the **Asma AI BankApp** running on Amazon EKS.

The goal was to practice:

- Automated vs manual synchronization
- ArgoCD sync waves
- Rollback and recovery
- App of Apps pattern
- ArgoCD Notifications
- ArgoCD Projects and RBAC concepts

---

## Architecture

```text
GitHub Repository
       |
       v
   ArgoCD
       |
       v
 Amazon EKS
       |
       v
Asma AI BankApp
```

Git is the source of truth. ArgoCD compares the desired configuration in Git with the live Kubernetes cluster.

---

# Task 1 - Automated vs Manual Sync

The BankApp ArgoCD Application normally uses automated synchronization with:

```yaml
syncPolicy:
  automated:
    prune: true
    selfHeal: true
  syncOptions:
    - CreateNamespace=true
    - ServerSideApply=true
```

### Manual Sync Test

Automatic synchronization was temporarily disabled.

A harmless ConfigMap change was committed to Git.

ArgoCD detected the difference and showed:

```text
OutOfSync
Healthy
```

Because auto-sync was disabled, ArgoCD did not automatically apply the Git change.

The application was then manually synchronized.

After synchronization:

```text
Synced
Healthy
```

Finally, automatic synchronization was restored.

### Key Learning

- **Manual Sync:** ArgoCD detects Git changes but waits for a person to synchronize.
- **Auto Sync:** ArgoCD automatically applies Git changes.
- **Prune:** Removes ArgoCD-managed Kubernetes resources that were removed from Git.
- **Self Heal:** Corrects configuration drift when the live cluster is changed manually.

---

# Task 2 - ArgoCD Sync Waves

Sync waves control the order in which Kubernetes resources are applied.

The annotation used is:

```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "0"
```

The following order was configured:

| Wave | Resources |
|---|---|
| `-2` | Namespace, StorageClass |
| `-1` | PersistentVolumeClaims, ConfigMap, Secret |
| `0` | MySQL Deployment, Ollama Deployment, Services |
| `1` | BankApp Deployment |
| `2` | HorizontalPodAutoscaler |

### Deployment Flow

```text
Wave -2
Namespace + StorageClass
        |
        v
Wave -1
PVC + ConfigMap + Secret
        |
        v
Wave 0
MySQL + Ollama + Services
        |
        v
Wave 1
BankApp
        |
        v
Wave 2
HPA
```

This ensures dependencies are created before the resources that need them.

The sync-wave configuration was committed to Git, and ArgoCD synchronized the application successfully.

Final status:

```text
Synced / Healthy
```

### Key Learning

ArgoCD processes lower-numbered waves before higher-numbered waves. Resources in the same wave can be processed together.

---

# Task 3 - ArgoCD Rollback

ArgoCD deployment history was reviewed.

The current sync-wave deployment and the previous application revision were identified.

Before rollback, automatic synchronization was disabled so ArgoCD would not immediately restore the newest Git revision.

The application was rolled back from the current deployment to the previous revision using the ArgoCD UI.

After rollback:

```text
OutOfSync / Healthy
```

This was expected.

### Why OutOfSync?

Git still contained the newest configuration, but the live Kubernetes cluster had been rolled back to an older revision.

```text
Git = New version
Cluster = Previous version

Git != Cluster

Result: OutOfSync
```

The application remained healthy because the older version was still a working deployment.

The latest Git version was then manually synchronized again.

Final result:

```text
Synced / Healthy
```

Automatic synchronization was restored with:

```text
prune = true
selfHeal = true
```

### Rollback vs Git Revert

**ArgoCD Rollback**

```text
Changes the live cluster to an older deployed revision.
Git itself does not change.
```

**Git Revert**

```text
Creates a new Git commit that reverses an earlier change.
ArgoCD then synchronizes the cluster to that Git state.
```

For GitOps, Git remains the source of truth.

### Interview Explanation

> An ArgoCD rollback can temporarily restore an older cluster revision, but it does not change Git. If Git still contains the newer configuration, the application becomes OutOfSync. In a GitOps workflow, a Git revert is the preferred way to permanently roll back desired state.

---

# Task 4 - App of Apps Pattern

The App of Apps pattern was implemented.

Two ArgoCD Applications were used:

```text
Git
 |
 v
asma-app-of-apps
Parent Application
 |
 v
asma-ai-bankapp
Child Application
 |
 v
Kubernetes Resources
```

The parent application watches the `argocd-apps` directory.

The child application manages the BankApp resources from the `k8s` directory.

Both applications were verified:

```text
asma-ai-bankapp    Synced    Healthy
asma-app-of-apps   Synced    Healthy
```

### Why App of Apps?

Instead of manually creating many ArgoCD Applications, one parent Application can manage multiple child Applications.

Example:

```text
Root Application
   |
   +-- BankApp
   |
   +-- Monitoring
   |
   +-- Gateway
   |
   +-- Other Applications
```

### Important Lab Decision

Existing cert-manager and Envoy Gateway installations were left under their existing Helm management instead of forcing ArgoCD to take ownership during this lab.

This avoided unnecessary ownership conflicts with working cluster components.

---

# Task 5 - ArgoCD Notifications

The ArgoCD Notifications Controller was verified as running.

A notification template was added:

```yaml
template.app-sync-status: |
  message: |
    Application {{.app.metadata.name}} sync status is {{.app.status.sync.status}}.
```

A trigger was also configured:

```yaml
trigger.on-sync-status: |
  - description: Application sync status changed
    send:
      - app-sync-status
    when: app.status.sync.status == 'Synced'
```

### Notification Flow

```text
Application becomes Synced
          |
          v
ArgoCD trigger matches
          |
          v
Notification template
          |
          v
Configured notification service
```

No real Slack, email, or webhook recipient was connected during this lab, so no external notification delivery was claimed.

### Key Learning

ArgoCD Notifications consists of:

- **Trigger** - decides when a notification should happen.
- **Template** - defines the message.
- **Service/Recipient** - defines where the message is delivered.

---

# Task 6 - ArgoCD Projects and RBAC

An ArgoCD AppProject was created for the Day 85 security demonstration.

Project:

```text
asma-devops-project
```

The project was restricted to the BankApp Git repository and BankApp namespace.

Conceptually:

```text
AppProject
   |
   +-- Which Git repositories are allowed?
   |
   +-- Which Kubernetes destinations are allowed?
```

### Why AppProject?

AppProjects create security boundaries between ArgoCD applications.

They can restrict:

- Source Git repositories
- Destination clusters
- Destination namespaces
- Kubernetes resource types
- Application access

### RBAC Concept

RBAC means **Role-Based Access Control**.

It controls what a user or team is allowed to do.

Example:

```text
Developer
   -> View applications
   -> Sync approved applications

Admin
   -> Create applications
   -> Delete applications
   -> Manage projects
   -> Manage ArgoCD configuration
```

For safety, the working BankApp was not moved into the restrictive demo project during this lab because the application also uses cluster-scoped resources.

---

# HPA and ArgoCD Drift Handling

The BankApp uses a HorizontalPodAutoscaler.

HPA can change:

```yaml
spec:
  replicas:
```

If ArgoCD continuously compares this field with Git, it may fight with the HPA.

The Application therefore ignores the BankApp Deployment replica difference:

```yaml
ignoreDifferences:
  - group: apps
    kind: Deployment
    name: bankapp
    namespace: bankapp
    jsonPointers:
      - /spec/replicas
```

### Key Learning

```text
Git defines application configuration
HPA controls runtime replica count
ArgoCD ignores only the replica difference
```

This allows GitOps and Kubernetes autoscaling to work together.

---

# Day 85 Final Verification

At the end of the lab:

```text
BankApp: Synced / Healthy
App of Apps: Synced / Healthy
Auto Sync: Enabled
Prune: Enabled
Self Heal: Enabled
Notifications Controller: Running
AppProject: Created
```

The application remained operational after the rollback test and was restored to the latest Git state.

---

# Important Commands Used

Check application:

```bash
kubectl get application asma-ai-bankapp -n argocd
```

Check ArgoCD applications:

```bash
kubectl get applications -n argocd
```

View deployment history:

```bash
kubectl get application asma-ai-bankapp -n argocd \
  -o jsonpath='{range .status.history[*]}ID={.id}{"  Revision="}{.revision}{"  Deployed="}{.deployedAt}{"\n"}{end}'
```

Check notifications controller:

```bash
kubectl get pods -n argocd | grep notifications
```

Check Helm releases:

```bash
helm list -A
```

Check AppProject:

```bash
kubectl get appproject asma-devops-project -n argocd
```

---

# Interview Summary

> In Day 85, I worked with advanced ArgoCD GitOps features on Amazon EKS. I tested manual and automated synchronization, configured sync waves to control Kubernetes deployment order, performed an ArgoCD rollback and restored the cluster from Git, implemented the App of Apps pattern, configured a notification trigger and template, and created an ArgoCD AppProject to understand security boundaries and RBAC. I also handled the interaction between ArgoCD and HPA by ignoring the Deployment replica field so autoscaling would not create continuous configuration drift.

---

# Day 85 Completed

**Topics completed:**

```text
Automated Sync       - Complete
Manual Sync          - Complete
Sync Waves           - Complete
Rollback             - Complete
GitOps Recovery      - Complete
App of Apps          - Complete
Notifications        - Complete
Projects / RBAC      - Complete
HPA Drift Handling   - Complete
```

**Final Status: Day 85 Complete**
