# Day 80 – Helm Project: Multi-Environment Deployment and CI/CD

## Objective

Day 80 brings the three-day Helm journey together for the AI-BankApp.

The goal was to:

- Use one Helm chart for **dev, staging, and production**
- Create environment-specific values files
- Add a Helm database-readiness hook
- Add a Helm application health test
- Package the chart as a `.tgz` file
- Understand how Helm fits into a GitOps CI/CD pipeline
- Deploy and verify the dev environment on the local Kind cluster

---

## Project Architecture

The Helm chart deploys three main application components:

```text
                 AI-BankApp Helm Chart
                         |
          +--------------+--------------+
          |              |              |
       BankApp         MySQL          Ollama
     Spring Boot      Database       AI Model
       :8080           :3306          :11434
          |              |              |
          |           2Gi PVC         5Gi PVC
          |
      Helm Test
 /actuator/health
```

The same chart is reused for all environments. Only the values files change.

---

## Task 1 – Environment-Specific Values

Three values files were created:

```text
bankapp/
├── values.yaml
├── values-dev.yaml
├── values-staging.yaml
└── values-prod.yaml
```

### Development – `values-dev.yaml`

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

### Staging – `values-staging.yaml`

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

### Production – `values-prod.yaml`

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

### Environment Comparison

| Setting | Dev | Staging | Production |
|---|---|---|---|
| BankApp replicas | 1 fixed | HPA 2–3 | HPA 2–4 |
| Image tag | latest | v1.2.0 | v1.2.0 |
| MySQL storage | 2Gi | 5Gi | 20Gi |
| MySQL request | 128Mi / 100m | 256Mi / 250m | 512Mi / 500m |
| Ollama storage | 5Gi | 10Gi | 10Gi |
| Gateway | Disabled | Disabled | Enabled |

This demonstrates one of Helm's biggest benefits: **one chart can deploy the same application differently in multiple environments without duplicating Kubernetes manifests.**

---

## Validate the Environments

All three environment configurations passed Helm lint:

```bash
helm lint bankapp/ -f bankapp/values-dev.yaml
helm lint bankapp/ -f bankapp/values-staging.yaml
helm lint bankapp/ -f bankapp/values-prod.yaml
```

Result:

```text
1 chart(s) linted, 0 chart(s) failed
```

The environments were also rendered with `helm template`.

```bash
helm template bankapp-dev bankapp/ -f bankapp/values-dev.yaml
helm template bankapp-staging bankapp/ -f bankapp/values-staging.yaml
helm template bankapp-prod bankapp/ -f bankapp/values-prod.yaml
```

The rendered values confirmed:

```text
DEV
MySQL: 2Gi
Ollama: 5Gi
BankApp: 1 replica

STAGING
MySQL: 5Gi
Ollama: 10Gi
HPA: min 2 / max 3

PRODUCTION
MySQL: 20Gi
Ollama: 10Gi
HPA: min 2 / max 4
```

---

## Task 2 – Helm Database Readiness Hook

A Helm hook was added at:

```text
bankapp/templates/pre-install-job.yaml
```

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

### Hook annotations

`pre-install,pre-upgrade`

Runs the hook before an installation or upgrade.

`hook-weight: "0"`

Controls hook execution order when multiple hooks exist.

`before-hook-creation`

Removes the previous hook resource before creating another copy.

### Local Kind observation

For the local verification deployment, the hook was temporarily moved outside `templates/`.

A fresh `pre-install` hook that waits for a normal MySQL Service has a lifecycle problem: normal chart resources have not necessarily been created yet when the pre-install hook runs. The chart already has BankApp init containers that wait for MySQL and Ollama, so those init containers provided dependency readiness during the local test.

The hook was restored afterward as part of the Day 80 exercise.

---

## Helm Test

A Helm test was created:

```text
bankapp/templates/tests/test-connection.yaml
```

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

The test calls the Spring Boot health endpoint:

```text
/actuator/health
```

Command:

```bash
helm test bankapp-dev -n dev
```

Actual result:

```text
TEST SUITE: bankapp-dev-test
Phase: Succeeded
```

This confirmed that the BankApp Service could successfully serve the application's health endpoint.

---

## Task 3 – Package the Helm Chart

The chart was validated and packaged:

```bash
helm lint bankapp/
helm package bankapp/
```

Result:

```text
bankapp-0.1.0.tgz
```

The package is a portable Helm chart that can be distributed or stored in a chart repository.

Conceptually:

```text
bankapp/
   |
   | helm package
   v
bankapp-0.1.0.tgz
```

---

## Dev Deployment on Kind

The dev environment was deployed into the `dev` namespace.

Because the exercise's 256Mi MySQL memory limit caused MySQL to be OOMKilled in the local Kind environment, the local deployment used a 512Mi limit override:

```bash
helm install bankapp-dev bankapp/ \
  -f bankapp/values-dev.yaml \
  --set mysql.resources.requests.memory=256Mi \
  --set mysql.resources.limits.memory=512Mi \
  -n dev \
  --timeout 5m
```

This keeps the exercise's environment values file unchanged while adapting the local runtime resources.

### Final pod status

```text
bankapp-dev-5755945795-btxqw          1/1   Running
bankapp-dev-mysql-579fd5cb9d-j8bdh   1/1   Running
bankapp-dev-ollama-6f997d754b-8d9m6  1/1   Running
```

### Persistent storage

```text
bankapp-dev-mysql-pvc    Bound    2Gi    RWO    standard
bankapp-dev-ollama-pvc   Bound    5Gi    RWO    standard
```

### Application verification

The BankApp logs showed:

- Spring Boot started
- Tomcat initialized on port 8080
- Spring Data JPA repositories initialized
- HikariCP started
- MySQL connection was successfully created

The final Helm test succeeded.

---

## Troubleshooting Performed

### 1. MySQL OOMKilled

Initial result:

```text
bankapp-dev-mysql   OOMKilled
```

Cause:

The dev configuration limited MySQL to 256Mi memory, which was not enough in the local Kind environment.

Local solution:

```bash
--set mysql.resources.requests.memory=256Mi
--set mysql.resources.limits.memory=512Mi
```

After reinstalling with the override:

```text
bankapp-dev-mysql   1/1 Running
```

### 2. Helm upgrade timed out

An attempted upgrade returned:

```text
etcdserver: request timed out
```

The Helm release then showed:

```text
STATUS: pending-upgrade
```

A later operation returned:

```text
another operation (install/upgrade/rollback) is in progress
```

The Kind nodes themselves remained `Ready`.

For this local lab, the fastest clean recovery was to uninstall the stuck dev release and reinstall it with the corrected MySQL memory override.

### 3. BankApp readiness initially failed

The readiness probe temporarily returned:

```text
connect: connection refused
```

The application was still starting.

After Spring Boot and Tomcat finished initialization:

```text
BankApp   1/1 Running
```

No probe change was required.

---

## Task 4 – Helm in the GitOps CI/CD Pipeline

### Current raw-manifest approach

```text
Developer pushes code
        |
        v
GitHub Actions
        |
        v
Build Docker image
        |
        v
Tag image with Git commit SHA
        |
        v
Update k8s/bankapp-deployment.yml
        |
        v
Commit change to Git
        |
        v
ArgoCD detects change
        |
        v
Sync to EKS
```

### Helm-based GitOps approach

```text
Developer pushes code
        |
        v
GitHub Actions
        |
        v
Build Docker image
        |
        v
Tag image with Git commit SHA
        |
        v
Update bankapp.image.tag
in values-prod.yaml
        |
        v
Commit values change
        |
        v
ArgoCD detects Git change
        |
        v
ArgoCD renders Helm chart
        |
        v
Kubernetes/EKS receives resources
```

A CI workflow can update only the image value instead of editing an entire Kubernetes Deployment manifest.

Example:

```yaml
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

### ArgoCD Helm configuration

Instead of pointing ArgoCD to raw manifests:

```yaml
source:
  path: k8s
```

ArgoCD can point directly to the Helm chart:

```yaml
source:
  path: helm-chart/bankapp
  helm:
    valueFiles:
      - values-prod.yaml
```

ArgoCD can render Helm templates and compare the desired Git state with the Kubernetes cluster.

### Advantages of ArgoCD + Helm

- One reusable chart
- Environment-specific values
- Less YAML duplication
- Git remains the source of truth
- Easier image-tag updates
- ArgoCD detects drift
- Helm provides templating and reusable configuration

---

## Production Helm Practices

A useful production deployment pattern is:

```bash
helm upgrade --install bankapp bankapp/ \
  -f bankapp/values-prod.yaml \
  --set bankapp.image.tag=$GIT_SHA \
  -n bankapp \
  --create-namespace \
  --wait \
  --timeout 300s \
  --atomic
```

Important flags:

- `--install` – install the release if it does not exist
- `--wait` – wait for Kubernetes resources to become ready
- `--timeout` – define how long Helm should wait
- `--atomic` – automatically roll back when an upgrade fails
- `--set bankapp.image.tag=$GIT_SHA` – deploy an exact application version

### Helm diff

Before an upgrade, `helm diff` can show what will change:

```bash
helm plugin install https://github.com/databus23/helm-diff
helm diff upgrade bankapp bankapp/ -f bankapp/values-prod.yaml
```

---

## Production Secrets

Real production passwords should **not** be committed in `values.yaml` or `values-prod.yaml`.

Production options include:

- External Secrets Operator with AWS Secrets Manager
- Sealed Secrets
- HashiCorp Vault
- CI/CD secret injection

The passwords used in this lab are demonstration values only.

---

## Helm vs Raw Manifests vs Kustomize

| Approach | Best For | AI-BankApp Example |
|---|---|---|
| Raw manifests | Simple, single-environment deployments | Original `k8s/` directory |
| Helm | Complex applications and multiple environments | BankApp + MySQL + Ollama + HPA + hooks |
| Kustomize | Patching existing manifests without Helm-style templates | Environment overlays on the original `k8s/` manifests |

For this AI-BankApp project, Helm is useful because the same application needs different configuration for dev, staging, and production.

---

## Three-Day Helm Journey

| Day | Concept | AI-BankApp Work |
|---|---|---|
| Day 78 | Helm repositories, install, values, upgrade and rollback | Deployed MySQL using a community Helm chart |
| Day 79 | Custom charts and Go templates | Converted the AI-BankApp Kubernetes resources into a reusable custom chart |
| Day 80 | Multi-environment values, hooks, tests, packaging and GitOps | Created dev/staging/prod configuration and connected the chart concept to CI/CD |

---

## Commands Used

```bash
# Validate
helm lint bankapp/ -f bankapp/values-dev.yaml
helm lint bankapp/ -f bankapp/values-staging.yaml
helm lint bankapp/ -f bankapp/values-prod.yaml

# Render
helm template bankapp-dev bankapp/ -f bankapp/values-dev.yaml
helm template bankapp-staging bankapp/ -f bankapp/values-staging.yaml
helm template bankapp-prod bankapp/ -f bankapp/values-prod.yaml

# Package
helm package bankapp/

# Deploy dev locally
helm install bankapp-dev bankapp/ \
  -f bankapp/values-dev.yaml \
  --set mysql.resources.requests.memory=256Mi \
  --set mysql.resources.limits.memory=512Mi \
  -n dev \
  --timeout 5m

# Verify
helm list -A
kubectl get pods -n dev
kubectl get pvc -n dev

# Test
helm test bankapp-dev -n dev

# History / rollback troubleshooting
helm history bankapp-dev -n dev
helm status bankapp-dev -n dev
```

---

## Final Result

Day 80 successfully demonstrated:

```text
One Helm Chart
      |
      +---- Dev
      |
      +---- Staging
      |
      +---- Production
      |
      +---- Hooks
      |
      +---- Helm Test
      |
      +---- Packaged .tgz
      |
      +---- GitOps / CI-CD integration
```

Final local verification:

```text
Helm release       DEPLOYED
BankApp            1/1 Running
MySQL              1/1 Running
Ollama             1/1 Running
MySQL PVC          Bound
Ollama PVC         Bound
Helm test          Succeeded
```

## Key Learning

**Helm lets us maintain one reusable Kubernetes application package and change only the values needed for each environment. CI/CD can update the image tag in Git, and ArgoCD can detect that change, render the Helm chart, and synchronize Kubernetes with the desired state.**
