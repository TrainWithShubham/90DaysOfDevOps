# Day 59 – Helm: Kubernetes Package Manager

## What is Helm?
Helm is the package manager for Kubernetes — like `apt` for Ubuntu or `brew` for macOS. Instead of managing dozens of individual YAML files (Deployments, Services, ConfigMaps, Secrets, PVCs), Helm bundles them into a single installable package called a **Chart**.

---

## Three Core Concepts

| Concept | What it is |
|---|---|
| **Chart** | A package of Kubernetes manifest templates |
| **Release** | A specific installation of a chart in your cluster |
| **Repository** | A collection of charts (like a package registry) |

---

## Installation & Verification

~~~bash
# Verify installation
helm version
helm env
~~~

---

## Working with Repositories

~~~bash
# Add Bitnami repo
helm repo add bitnami https://charts.bitnami.com/bitnami

# Update repo index
helm repo update

# Search charts
helm search repo nginx
helm search repo bitnami

# List all added repos
helm repo list
~~~

---

## Installing a Chart

~~~bash
# Install nginx from Bitnami
helm install my-nginx bitnami/nginx

# Check what was created in the cluster
kubectl get all

# Inspect the release
helm list
helm status my-nginx
helm get manifest my-nginx
~~~

> One `helm install` command replaces writing a Deployment, Service, and ConfigMap by hand.

---

## Customizing with Values

~~~bash
# View all default values of a chart
helm show values bitnami/nginx

# Override values inline with --set
helm install my-nginx bitnami/nginx --set replicaCount=3 --set service.type=NodePort

# Override with a values file
helm install my-nginx bitnami/nginx -f custom-values.yaml

# Check what overrides are active on a release
helm get values my-nginx

# Check all values (defaults + overrides)
helm get values my-nginx --all
~~~

### custom-values.yaml

~~~yaml
replicaCount: 3

service:
  type: NodePort
  port: 80

resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    cpu: 200m
    memory: 256Mi
~~~

> Use `--set` for quick single overrides. Use `-f values.yaml` for multiple or reusable overrides.
> Nested values use dot notation: `--set service.type=NodePort`

---

## Upgrade and Rollback

~~~bash
# Upgrade a release
helm upgrade my-nginx bitnami/nginx --set replicaCount=5

# View revision history
helm history my-nginx

# Rollback to revision 1
helm rollback my-nginx 1

# View history again — rollback creates a NEW revision, not overwrite
helm history my-nginx
~~~

> After one upgrade and one rollback, `helm history` shows 3 revisions. Rollback = new revision, not overwrite. Same concept as Deployment rollouts.

---

## Creating Your Own Chart

~~~bash
# Scaffold a new chart
helm create my-app
~~~

### Chart Directory Structure

~~~
my-app/
├── Chart.yaml          # Chart metadata (name, version, description)
├── values.yaml         # Default configurable values
└── templates/          # Kubernetes manifest templates
    ├── deployment.yaml
    ├── service.yaml
    ├── hpa.yaml
    └── _helpers.tpl    # Reusable template helpers
~~~

### Go Template Syntax

~~~yaml
# In templates/deployment.yaml
replicas: {{ .Values.replicaCount }}        # From values.yaml
name: {{ .Chart.Name }}                     # From Chart.yaml
release: {{ .Release.Name }}                # Set at install time
~~~

### Edit values.yaml

~~~yaml
replicaCount: 3

image:
  repository: nginx
  tag: "1.25"
~~~

### Validate, Preview, Install, Upgrade

~~~bash
# Validate chart structure
helm lint my-app

# Preview rendered manifests without installing
helm template my-release ./my-app

# Install the chart
helm install my-release ./my-app

# Upgrade the chart
helm upgrade my-release ./my-app --set replicaCount=5
~~~

---

## Clean Up

~~~bash
# Uninstall a release (removes all cluster resources)
helm uninstall my-nginx

# Uninstall but keep history for auditing
helm uninstall my-nginx --keep-history

# Verify all releases are gone
helm list
~~~

---

## Helm vs Raw YAML

| | Raw YAML | Helm |
|---|---|---|
| Reusability | ❌ Copy-paste per env | ✅ Parameterized via values |
| Versioning | ❌ Manual | ✅ Built-in revision history |
| Rollback | ❌ Manual | ✅ `helm rollback` |
| Sharing | ❌ Difficult | ✅ Push to chart repo |
| Templating | ❌ None | ✅ Go templates |

---

## Useful Commands Quick Reference

~~~bash
helm repo add <name> <url>               # Add a chart repository
helm repo update                         # Refresh repo index
helm search repo <keyword>               # Search for charts
helm show values <chart>                 # View default values
helm install <release> <chart>           # Install a chart
helm upgrade <release> <chart>           # Upgrade a release
helm rollback <release> <revision>       # Rollback to a revision
helm history <release>                   # View revision history
helm list                                # List all releases
helm status <release>                    # Status of a release
helm get manifest <release>              # View rendered manifests
helm get values <release>                # View active overrides
helm uninstall <release>                 # Delete a release
helm lint <chart-dir>                    # Validate chart structure
helm template <release> <chart-dir>      # Preview without installing
helm create <chart-name>                 # Scaffold a new chart
~~~

---

## Key Takeaways
- **Helm** is the Kubernetes package manager — one command replaces dozens of YAML files
- A **Chart** is a package, a **Release** is an installation, a **Repository** is a registry of charts
- Use `--set` for quick overrides and `-f values.yaml` for reusable, version-controlled config
- **Rollback creates a new revision** — history is never overwritten
- `helm template` and `helm lint` are essential for debugging charts before installing
- Go templates (`{{ .Values.key }}`, `{{ .Chart.Name }}`, `{{ .Release.Name }}`) make charts dynamic and reusable
