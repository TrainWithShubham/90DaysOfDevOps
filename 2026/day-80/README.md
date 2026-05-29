# Day 80 -- Helm Project: Multi-Environment Deployment and CI/CD

## Task
Two days of Helm -- chart basics and a custom chart for the AI-BankApp. Today you bring it all together. You will create environment-specific values for dev, staging, and production, add Helm hooks, package the chart, and integrate Helm into the AI-BankApp's CI/CD pipeline.

Reference: https://github.com/TrainWithShubham/AI-BankApp-DevOps (branch: `feat/gitops`)

---

## Expected Output
- Environment-specific values files (dev, staging, prod) for the AI-BankApp Helm chart
- Helm hooks for database readiness validation
- A packaged chart (`.tgz` file) ready for distribution
- Understanding of how Helm fits into the AI-BankApp's GitOps pipeline
- A markdown file: `day-80-helm-project.md`

---

## Challenge Tasks

### Task 1: Create Environment-Specific Values
One chart, three environments. The AI-BankApp runs differently in dev vs production.

Create `bankapp/values-dev.yaml`:
```yaml
bankapp:
  replicaCount: 1
  image:
    repository: trainwithshubham/ai-bankapp-eks
    tag: "latest"
    pullPolicy: Always
  resources:
    requests:
      memory: "256Mi"
      cpu: "100m"
    limits:
      memory: "512Mi"
      cpu: "250m"
  autoscaling:
    enabled: false

mysql:
  enabled: true
  resources:
    requests:
      memory: "128Mi"
      cpu: "100m"
    limits:
      memory: "256Mi"
      cpu: "250m"
  persistence:
    size: 2Gi
    storageClass: standard

ollama:
  enabled: true
  model: tinyllama
  resources:
    requests:
      memory: "1Gi"
      cpu: "500m"
    limits:
      memory: "1.5Gi"
      cpu: "1000m"
  persistence:
    size: 5Gi
    storageClass: standard

storageClass:
  create: false
```

Create `bankapp/values-staging.yaml`:
```yaml
bankapp:
  replicaCount: 2
  image:
    repository: trainwithshubham/ai-bankapp-eks
    tag: "v1.2.0"
    pullPolicy: IfNotPresent
  resources:
    requests:
      memory: "256Mi"
      cpu: "250m"
    limits:
      memory: "512Mi"
      cpu: "500m"
  autoscaling:
    enabled: true
    minReplicas: 2
    maxReplicas: 3
    targetCPUUtilization: 75

mysql:
  enabled: true
  resources:
    requests:
      memory: "256Mi"
      cpu: "250m"
    limits:
      memory: "512Mi"
      cpu: "500m"
  persistence:
    size: 5Gi
    storageClass: gp3

ollama:
  enabled: true
  model: tinyllama
  persistence:
    size: 10Gi
    storageClass: gp3

secrets:
  mysqlRootPassword: StagingPass@456
  mysqlUser: root
  mysqlPassword: StagingPass@456

storageClass:
  create: true
```

Create `bankapp/values-prod.yaml`:
```yaml
bankapp:
  replicaCount: 4
  image:
    repository: trainwithshubham/ai-bankapp-eks
    tag: "v1.2.0"
    pullPolicy: IfNotPresent
  resources:
    requests:
      memory: "256Mi"
      cpu: "250m"
    limits:
      memory: "512Mi"
      cpu: "500m"
  autoscaling:
    enabled: true
    minReplicas: 2
    maxReplicas: 4
    targetCPUUtilization: 70

mysql:
  enabled: true
  resources:
    requests:
      memory: "512Mi"
      cpu: "500m"
    limits:
      memory: "1Gi"
      cpu: "1000m"
  persistence:
    size: 20Gi
    storageClass: gp3

ollama:
  enabled: true
  model: tinyllama
  resources:
    requests:
      memory: "2Gi"
      cpu: "900m"
    limits:
      memory: "2.5Gi"
      cpu: "1500m"
  persistence:
    size: 10Gi
    storageClass: gp3

secrets:
  mysqlRootPassword: ProdSecure@789
  mysqlUser: root
  mysqlPassword: ProdSecure@789

storageClass:
  create: true

gateway:
  enabled: true
```

**Compare the environments:**

| Setting | Dev | Staging | Prod |
|---------|-----|---------|------|
| BankApp replicas | 1 (fixed) | 2-3 (HPA) | 2-4 (HPA) |
| Image tag | latest | v1.2.0 | v1.2.0 |
| MySQL storage | 2Gi | 5Gi | 20Gi |
| MySQL resources | 128Mi/100m | 256Mi/250m | 512Mi/500m |
| Ollama memory | 1Gi | 2Gi | 2.5Gi |
| Gateway | disabled | disabled | enabled |

**Deploy to different environments:**
```bash
# Dev (on Kind)
helm install bankapp-dev bankapp/ -f bankapp/values-dev.yaml -n dev --create-namespace

# Staging (render to check)
helm template bankapp-staging bankapp/ -f bankapp/values-staging.yaml | grep "replicas:"

# Prod (render to check)
helm template bankapp-prod bankapp/ -f bankapp/values-prod.yaml | grep "replicas:"
```

Same chart, wildly different deployments.

---

### Task 2: Add Helm Hooks
The AI-BankApp uses init containers to wait for MySQL. Helm hooks offer another approach -- running pre-install jobs.

Create `bankapp/templates/pre-install-job.yaml`:
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ include "bankapp.fullname" . }}-db-ready
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "bankapp.labels" . | nindent 4 }}
  annotations:
    "helm.sh/hook": pre-install,pre-upgrade
    "helm.sh/hook-weight": "0"
    "helm.sh/hook-delete-policy": before-hook-creation
spec:
  template:
    spec:
      containers:
        - name: db-check
          image: busybox:1.36
          command:
            - /bin/sh
            - -c
            - |
              echo "Waiting for MySQL to be ready..."
              until nc -z {{ include "bankapp.fullname" . }}-mysql 3306; do
                echo "MySQL not ready, retrying in 3s..."
                sleep 3
              done
              echo "MySQL is ready!"
          resources:
            requests: { memory: "32Mi", cpu: "50m" }
            limits: { memory: "64Mi", cpu: "100m" }
      restartPolicy: Never
  backoffLimit: 10
```

**How hooks work in the AI-BankApp context:**
- `helm.sh/hook: pre-install,pre-upgrade` -- runs before install and before upgrade
- This ensures MySQL is up before the BankApp Deployment is created
- `before-hook-creation` -- deletes the old job before creating a new one on re-runs
- Combined with init containers in the Deployment, this provides defense-in-depth

**Other useful hook types:**
- `post-install` -- run database migrations after deploy
- `pre-delete` -- backup database before teardown
- `test` -- runs when you execute `helm test`

**Add a Helm test:**

Create `bankapp/templates/tests/test-connection.yaml`:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: {{ include "bankapp.fullname" . }}-test
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "bankapp.labels" . | nindent 4 }}
  annotations:
    "helm.sh/hook": test
spec:
  containers:
    - name: test
      image: busybox:1.36
      command: ['sh', '-c', 'wget -qO- http://{{ include "bankapp.fullname" . }}-service:8080/actuator/health']
  restartPolicy: Never
```

After deploying, run:
```bash
helm test bankapp-dev -n dev
```

This hits the Spring Boot health endpoint and confirms the app is running.

---

### Task 3: Package and Version the Chart
Package the chart into a distributable `.tgz` file:

```bash
# Lint first
helm lint bankapp/

# Package
helm package bankapp/
```

This creates `bankapp-0.1.0.tgz`.

**Bump the version after changes:**
Edit `bankapp/Chart.yaml`:
```yaml
version: 0.2.0        # Chart structure changed (added hooks)
appVersion: "1.1.0"    # App version updated
```

Re-package:
```bash
helm package bankapp/
```

Now you have `bankapp-0.1.0.tgz` and `bankapp-0.2.0.tgz`.

**Install from a package:**
```bash
helm install my-bankapp bankapp-0.2.0.tgz -f bankapp/values-dev.yaml -n bankapp --create-namespace
```

**Create a chart repository index** (for sharing via GitHub Pages):
```bash
mkdir chart-repo
cp bankapp-*.tgz chart-repo/
helm repo index chart-repo/ --url https://your-username.github.io/helm-charts
cat chart-repo/index.yaml
```

---

### Task 4: Understand Helm in the AI-BankApp GitOps Pipeline
The AI-BankApp uses a GitOps pipeline. Study how Helm could integrate:

**Current pipeline (from `.github/workflows/gitops-ci.yml`):**
```
Developer pushes code
  -> GitHub Actions builds Docker image
  -> Tags with git commit SHA
  -> Updates image tag in k8s/bankapp-deployment.yml via sed
  -> Commits the change back to the repo
  -> ArgoCD detects the change and syncs to EKS
```

**With Helm, the pipeline becomes:**
```
Developer pushes code
  -> GitHub Actions builds Docker image
  -> Tags with git commit SHA
  -> Updates image.tag in helm-chart/values.yaml (or values-prod.yaml)
  -> Commits the change back to the repo
  -> ArgoCD detects the change and runs helm upgrade on EKS
```

Here is how the CI step would look with Helm (reference pattern):
```yaml
# In the GitHub Actions workflow
- name: Update Helm values with new image tag
  run: |
    TAG=${{ steps.tag.outputs.sha_short }}
    yq -i '.bankapp.image.tag = "'$TAG'"' helm-chart/bankapp/values-prod.yaml

- name: Commit updated Helm values
  run: |
    git config user.name "github-actions[bot]"
    git config user.email "github-actions[bot]@users.noreply.github.com"
    git add helm-chart/bankapp/values-prod.yaml
    git diff --staged --quiet || git commit -m "ci: update bankapp image to $TAG [skip ci]"
    git push
```

**ArgoCD with Helm** (the ArgoCD Application would change from):
```yaml
# Current: raw manifests
source:
  path: k8s
```

To:
```yaml
# With Helm
source:
  path: helm-chart/bankapp
  helm:
    valueFiles:
      - values-prod.yaml
```

ArgoCD natively supports Helm charts -- it renders templates and applies the result, tracking drift against the rendered output.

**Document:** What are the advantages of ArgoCD syncing a Helm chart vs raw manifests?

---

### Task 5: Helm Best Practices for Production
Review these patterns used in production AI-BankApp deployments:

**1. Always use `helm upgrade --install`:**
```bash
helm upgrade --install bankapp bankapp/ \
  -f bankapp/values-prod.yaml \
  --set bankapp.image.tag=$GIT_SHA \
  -n bankapp --create-namespace \
  --wait --timeout 300s \
  --atomic
```

- `--install` -- creates if missing, upgrades if exists
- `--set bankapp.image.tag=$GIT_SHA` -- pins to exact git commit
- `--wait` -- waits for all pods to be ready
- `--atomic` -- rolls back automatically if the upgrade fails

**2. Use `helm diff` before upgrading:**
```bash
helm plugin install https://github.com/databus23/helm-diff
helm diff upgrade bankapp bankapp/ -f bankapp/values-prod.yaml
```

Shows exactly what would change before you commit to the upgrade.

**3. Resource quotas per namespace:**
```yaml
# Add to templates/resourcequota.yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: {{ include "bankapp.fullname" . }}-quota
  namespace: {{ .Release.Namespace }}
spec:
  hard:
    requests.cpu: "2"
    requests.memory: 4Gi
    limits.cpu: "4"
    limits.memory: 8Gi
```

**4. Never store real secrets in values.yaml.** In production, use:
- External Secrets Operator with AWS Secrets Manager
- Sealed Secrets
- Vault by HashiCorp

The `values.yaml` defaults are fine for local dev but should be overridden in CI/CD via `--set` with pipeline secrets.

---

### Task 6: Clean Up and Review
Check what you have deployed:
```bash
helm list -A
```

**Reflect and document the 3-day Helm journey:**

| Day | Concept | AI-BankApp Connection |
|-----|---------|----------------------|
| 78 | Helm install, repos, values, upgrade, rollback | Deployed MySQL for the BankApp via Bitnami chart |
| 79 | Custom chart from scratch, Go templates | Converted 12 raw `k8s/` manifests into a Helm chart |
| 80 | Multi-env values, hooks, packaging, CI/CD | Production-ready chart with dev/staging/prod configs |

**When would you use Helm vs raw manifests vs Kustomize?**

| Approach | Best For | AI-BankApp Example |
|----------|---------|-------------------|
| Raw manifests | Simple, single-env deployments | The current `k8s/` directory |
| Helm | Multi-env, complex apps with dependencies | The chart you built (3 services, HPA, hooks) |
| Kustomize | Overlays on existing manifests, no templating | Good if you want to patch `k8s/` without rewriting |

**Clean up:**
```bash
helm uninstall bankapp-dev -n dev
kubectl delete namespace dev
kind delete cluster --name tws-cluster
```

---

## Hints
- Multiple `-f` flags stack: `helm install app chart/ -f values.yaml -f values-prod.yaml` -- later files override earlier ones
- `--atomic` is critical in CI/CD -- it auto-rollbacks on failure, preventing half-deployed states
- `helm diff` plugin is a must-have for production -- never upgrade blind
- `yq` is better than `sed` for updating YAML values in CI pipelines (preserves structure)
- ArgoCD has native Helm support -- you do not need to render templates before pushing to Git
- Helm hooks run outside the normal release lifecycle -- they are not tracked in `helm get manifest`
- The AI-BankApp's Gateway and cert-manager resources could also be templated, but are often managed separately as cluster-level infrastructure
- Reference: https://github.com/TrainWithShubham/AI-BankApp-DevOps (branch: `feat/gitops`)

---

## Documentation
Create `day-80-helm-project.md` with:
- All three environment values files with a comparison table
- The Helm hook template with annotations explained
- Screenshot of `helm list -A` showing deployment
- Output of `helm test` on the dev deployment
- How the GitOps CI/CD pipeline would integrate Helm
- Comparison: Helm vs raw manifests vs Kustomize for the AI-BankApp
- What you would add for production secrets management

---

## Submission
1. Add `day-80-helm-project.md` to `2026/day-80/`
2. Commit and push to your fork

---

## Learn in Public
Share on LinkedIn: "Completed the Helm block -- built a full Helm chart for the AI-BankApp (Spring Boot + MySQL + Ollama AI), created environment-specific values for dev, staging, and prod, added pre-install hooks, packaged the chart for distribution, and mapped out how it integrates with the GitOps CI/CD pipeline. Same chart, three environments, zero duplication."

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
