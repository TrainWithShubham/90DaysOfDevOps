# Day 85 -- ArgoCD Deep Dive: Sync Strategies, Rollbacks, and Multi-App Management

---

## Challenge Tasks

### Task 1: Understand Sync Strategies
ArgoCD offers multiple ways to sync:

**Automated sync** (what the AI-BankApp uses):
```yaml
syncPolicy:
  automated:
    prune: true      # Delete resources removed from Git
    selfHeal: true   # Revert manual cluster changes
```
- Every Git change syncs automatically within 3 minutes
- No human approval needed
- Good for dev/staging environments

**Manual sync** (for production):
```yaml
syncPolicy: {}   # No automated section
```
- ArgoCD detects drift but does NOT auto-correct
- A human must click "Sync" or run `argocd app sync`
- Good for production where you want a review gate

**Try switching to manual sync:**
```bash
argocd app set bankapp --sync-policy none
```
![image](images/switch_manual_sync.png)

Now make a change in Git (edit `k8s/configmap.yml` in your fork -- change `APP_NAME` or add a new key). Push the commit.

![image](images/edit_cm.png)

![image](images/edit_cm_push.png)

Wait 3 minutes and check:
```bash
argocd app get bankapp
```

![image](images/argo_app_get_bankapp.png)

The status will show `OutOfSync` but ArgoCD will NOT apply the change. You can see exactly what differs:
```bash
argocd app diff bankapp
```

![image](images/argo_app_get_diff.png)

**Preview before syncing:**
```bash
# Dry run -- show what would change
argocd app sync bankapp --dry-run

![image](images/argo_dry_run.png)

# Sync for real
argocd app sync bankapp
```

![image](images/argo_app_sync.png)

In the UI, clicking "Sync" shows a preview dialog listing all resources that will change.

![image](images/ui_sync.png)

**Switch back to automated:**
```bash
argocd app set bankapp --sync-policy automated --self-heal --auto-prune
```
![image](images/back_to_automated.png)
---

### Task 2: Sync Waves and Resource Ordering
The AI-BankApp has dependencies: MySQL must be running before the BankApp starts. ArgoCD handles this with **sync waves** -- annotations that control the order of resource creation.

**Add sync wave annotations to the AI-BankApp manifests in your fork:**

Edit `k8s/namespace.yml`:
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: bankapp
  annotations:
    argocd.argoproj.io/sync-wave: "-2"
```

Edit `k8s/pv.yml` (StorageClass):
```yaml
metadata:
  name: gp3
  annotations:
    argocd.argoproj.io/sync-wave: "-2"
```

Edit `k8s/pvc.yml` (both PVCs):
```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "-1"
```

Edit `k8s/configmap.yml` and `k8s/secrets.yml`:
```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "-1"
```

Edit `k8s/mysql-deployment.yml`:
```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "0"
```

Edit `k8s/ollama-deployment.yml`:
```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "0"
```

Edit `k8s/service.yml` (all three services):
```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "0"
```

Edit `k8s/bankapp-deployment.yml`:
```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "1"
```

Edit `k8s/hpa.yml`:
```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "2"
```

**The sync order becomes:**
```
Wave -2: Namespace, StorageClass          (infrastructure)
Wave -1: PVCs, ConfigMap, Secret          (configuration)
Wave  0: MySQL, Ollama, Services          (databases and networking)
Wave  1: BankApp Deployment               (application)
Wave  2: HPA                              (scaling)
```

ArgoCD processes each wave in order. Resources in the same wave sync in parallel. ArgoCD waits for each wave to be healthy before moving to the next.

Commit and push these changes. ArgoCD will re-sync and you will see the ordered deployment in the UI.

![image](images/wave.png)


![image](images/sync_wave.png)

---

### Task 3: ArgoCD Rollbacks
ArgoCD tracks every sync as a revision. You can rollback to any previous state.

**Check the sync history:**
```bash
argocd app history bankapp
```

Output:
```
ID  DATE                 REVISION
1   2026-04-10 10:00:00  abc1234
2   2026-04-10 10:15:00  def5678   (sync wave annotations)
```

![image](images/argo_app_history.png)

**Rollback to a previous revision:**

Via CLI:
```bash
argocd app rollback bankapp 1
```

Via UI: Click the application > History > select a revision > "Rollback".

After rollback:
```bash
argocd app get bankapp
```

The status will show `OutOfSync` because the cluster now matches an older Git commit, not the latest.

![image](images/agro_rollback.png)


![image](images/argo_app_get_after_rollback.png)


**Important:** Rollback is a temporary fix. It does not change Git. The proper GitOps rollback is:
```bash
# In your fork
git revert HEAD
git push
```

This creates a new commit that undoes the last change. ArgoCD syncs the revert and the cluster is updated. The Git history shows the full audit trail: deploy, then revert.

![image](images/git_revert_head.png)

**Document:** What is the difference between ArgoCD rollback and `git revert`? Which is the GitOps-correct approach?

**ArgoCD rollback** changes the *cluster state* back to a previous deployed version without changing Git.
**`git revert`** creates a new commit in Git that undoes changes, and ArgoCD then syncs it to the cluster.

**GitOps-correct approach: `git revert`**, because Git must remain the source of truth.

---

### Task 4: App of Apps Pattern
In production, you do not manage one application -- you manage dozens. The **App of Apps** pattern uses one parent ArgoCD Application that creates child Applications.

Create a directory for the pattern:
```bash
mkdir -p argocd-apps/
```

Create `argocd-apps/bankapp.yaml` (the BankApp application):
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: bankapp
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: default
  source:
    repoURL: https://github.com/srdangat/AI-BankApp-DevOps.git
    targetRevision: feat/gitops
    path: k8s
  destination:
    server: https://kubernetes.default.svc
    namespace: bankapp
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
      - ServerSideApply=true
```

Create `argocd-apps/monitoring.yaml` (Prometheus + Grafana):
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: monitoring
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: default
  source:
    repoURL: https://prometheus-community.github.io/helm-charts
    chart: kube-prometheus-stack
    targetRevision: "65.*"
    helm:
      values: |
        grafana:
          adminPassword: admin123
        prometheus:
          prometheusSpec:
            retention: 3d
            resources:
              requests:
                memory: 256Mi
                cpu: 100m
  destination:
    server: https://kubernetes.default.svc
    namespace: monitoring
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
      - ServerSideApply=true
```

Create `argocd-apps/envoy-gateway.yaml`:
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: envoy-gateway
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: default
  source:
    repoURL: docker.io/envoyproxy
    chart: gateway-helm
    targetRevision: "v1.4.*"
  destination:
    server: https://kubernetes.default.svc
    namespace: envoy-gateway-system
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
```

**Create the parent Application** that manages all child apps:
```yaml
# argocd-apps/root-app.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: root-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/srdangat/AI-BankApp-DevOps.git
    targetRevision: feat/gitops
    path: argocd-apps
  destination:
    server: https://kubernetes.default.svc
    namespace: argocd
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

Push the `argocd-apps/` directory to your fork and apply the root app:
```bash
kubectl apply -f argocd-apps/root-app.yaml
```

![image](images/app_of_apps.png)

ArgoCD will:
1. Read the `argocd-apps/` directory from Git
2. Find `bankapp.yaml`, `monitoring.yaml`, and `envoy-gateway.yaml`
3. Create three child Applications
4. Each child Application syncs independently

**In the ArgoCD UI,** you now see 4 applications: `root-app`, `bankapp`, `monitoring`, `envoy-gateway`. Adding a new app to the cluster is as simple as adding a new YAML file to the `argocd-apps/` directory.

```bash
argocd app list
```

![image](images/app_of_apps_ui.png)

---

### Task 5: ArgoCD Notifications
Get notified when deployments succeed, fail, or drift.

Install ArgoCD Notifications (included in modern ArgoCD versions):
```bash
# Check if notifications controller is running
kubectl get pods -n argocd -l app.kubernetes.io/component=notifications-controller
```

**Configure a Slack or webhook notification** (using a generic webhook example):

Create a notification config:
```bash
kubectl apply -n argocd -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-notifications-cm
  namespace: argocd
data:
  trigger.on-sync-succeeded: |
    - when: app.status.operationState.phase in ['Succeeded']
      send: [app-sync-succeeded]
  trigger.on-sync-failed: |
    - when: app.status.operationState.phase in ['Error', 'Failed']
      send: [app-sync-failed]
  trigger.on-health-degraded: |
    - when: app.status.health.status == 'Degraded'
      send: [app-health-degraded]
  template.app-sync-succeeded: |
    message: "Application {{.app.metadata.name}} sync succeeded. Revision: {{.app.status.sync.revision}}"
  template.app-sync-failed: |
    message: "Application {{.app.metadata.name}} sync FAILED! Check ArgoCD for details."
  template.app-health-degraded: |
    message: "Application {{.app.metadata.name}} health is DEGRADED. Investigate immediately."
EOF
```

**Subscribe an application to notifications:**
```bash
kubectl annotate application bankapp -n argocd \
  notifications.argoproj.io/subscribe.on-sync-succeeded.webhook="" \
  notifications.argoproj.io/subscribe.on-sync-failed.webhook="" \
  notifications.argoproj.io/subscribe.on-health-degraded.webhook=""
```

For Slack integration, you would add a Slack service to the ConfigMap with your webhook URL. The pattern is the same -- triggers fire on events, templates format the message, services deliver it.

**View notification history:**
```bash
kubectl get applications bankapp -n argocd -o jsonpath='{.status.operationState.message}'
```

![image](images/webook_notification.png)


![image](images/noti_msg.png)

---

### Task 6: ArgoCD Projects and RBAC
In production, you do not give every team access to every application. ArgoCD **Projects** provide multi-tenancy.

Create a project for the BankApp team:
```bash
argocd proj create bankapp-team \
  --description "AI-BankApp team project" \
  --src "https://github.com/srdangat/AI-BankApp-DevOps.git" \
  --dest "https://kubernetes.default.svc,bankapp" \
  --dest "https://kubernetes.default.svc,monitoring"
```

This project:
- Can only source from the AI-BankApp repo
- Can only deploy to the `bankapp` and `monitoring` namespaces
- Cannot deploy to `kube-system`, `argocd`, or other namespaces

Move the bankapp Application to this project:
```bash
argocd app set bankapp --project bankapp-team
```

**Verify restrictions work:**
```bash
# This should fail -- cert-manager namespace is not allowed
argocd proj add-destination bankapp-team https://kubernetes.default.svc kube-system 2>&1 || echo "Restricted!"
```

**RBAC policies** (in `argocd-rbac-cm` ConfigMap):
```yaml
policy.csv: |
  p, role:bankapp-dev, applications, get, bankapp-team/*, allow
  p, role:bankapp-dev, applications, sync, bankapp-team/*, allow
  p, role:bankapp-dev, applications, rollback, bankapp-team/*, deny
  g, bankapp-developers, role:bankapp-dev
```

This gives the `bankapp-developers` group permission to view and sync but NOT rollback. Rollback requires a senior team member.

![image](images/rbac.png)


![image](images/rbac2.png)


**Document:** How do Projects and RBAC prevent one team from accidentally affecting another team's applications?

- `Projects` separate teams’ apps, repos, and clusters. `RBAC` controls user permissions.
- `Together`, they ensure each team can only access and change their own resources, preventing cross-team impact

---

**Automated vs manual sync comparison and when to use each**

**Automated sync**

* ArgoCD automatically applies Git changes to the cluster
* Keeps cluster always in sync with Git
* Good for production where you want consistency and less manual work

**Manual sync**

* You must click or trigger sync yourself
* Changes in Git are not applied automatically
* Good for staging, testing, or when you want control before deploying

**When to use what**

* Use **automated sync** for stable environments (like production)
* Use **manual sync** when you need approval, safety checks, or testing before applying changes


**Sync waves table showing the AI-BankApp deployment order**

* **Wave -2:** Create base infrastructure (Namespace, StorageClass)
* **Wave -1:** Add config layer (PVCs, ConfigMaps, Secrets)
* **Wave 0:** Deploy core dependencies (MySQL, Ollama, Services)
* **Wave 1:** Deploy the main app (BankApp)
* **Wave 2:** Add scaling (HPA)

**ArgoCD applies resources in order so dependencies are ready before the application starts.**


**How ArgoCD rollback works (vs `git revert`)**

**ArgoCD rollback** changes the *cluster state* back to a previous deployed version without changing Git.
**`git revert`** creates a new commit in Git that undoes changes, and ArgoCD then syncs it to the cluster.

**App of Apps architecture diagram**

![image](images/apps_of_app_diagram.png)

**How Projects and RBAC restrict access**

- `Projects` separate teams’ apps, repos, and clusters. `RBAC` controls user permissions.
- `Together`, they ensure each team can only access and change their own resources, preventing cross-team impact

---
