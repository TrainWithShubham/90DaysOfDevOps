# Day 59 -- Helm (Kubernetes Package Manager)

## Objective

Learn how Helm simplifies Kubernetes deployments by packaging multiple
Kubernetes manifests into reusable charts.

## What is Helm?

Helm is the package manager for Kubernetes, similar to apt for Ubuntu.

### Three Core Concepts

-   **Chart**: A package of Kubernetes templates.
-   **Release**: An installed instance of a chart.
-   **Repository**: A collection of charts.

## Commands Practiced

### Install Helm

``` bash
helm version
helm env
```

### Add Repository

``` bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo nginx
helm search repo bitnami
```

### Install a Chart

``` bash
helm install my-nginx oci://registry-1.docker.io/bitnamicharts/nginx
```

### Customize with --set

``` bash
helm install my-nginx-nodeport oci://registry-1.docker.io/bitnamicharts/nginx --set replicaCount=3 --set service.type=NodePort
```

### Customize with values.yaml

``` yaml
replicaCount: 3

service:
  type: NodePort

resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    cpu: 200m
    memory: 256Mi
```

Install:

``` bash
helm install my-nginx-custom oci://registry-1.docker.io/bitnamicharts/nginx -f custom-values.yaml
```

### Upgrade

``` bash
helm upgrade my-nginx oci://registry-1.docker.io/bitnamicharts/nginx --set replicaCount=5
```

### Rollback

``` bash
helm rollback my-nginx 1
```

Rollback creates a new revision instead of replacing the previous one.

## Create Your Own Chart

``` bash
helm create my-app
helm lint my-app
helm template my-release ./my-app
helm install my-release ./my-app
helm upgrade my-release ./my-app --set replicaCount=5
```

Chart structure:

``` text
my-app/
├── Chart.yaml
├── values.yaml
├── charts/
└── templates/
```

Go template examples:

``` text
{{ .Values.replicaCount }}
{{ .Chart.Name }}
{{ .Release.Name }}
```

## Cleanup

``` bash
helm uninstall my-nginx
helm uninstall my-nginx-custom
helm uninstall my-nginx-nodeport
helm uninstall my-release
helm list
```

## What I Learned

-   Helm is the package manager for Kubernetes.
-   Charts package Kubernetes resources.
-   Releases are installed chart instances.
-   Repositories store charts.
-   values.yaml customizes deployments.
-   helm upgrade updates applications.
-   helm rollback restores previous revisions.
-   helm template renders manifests without installing.
-   helm lint validates charts before deployment.

## Cheat Sheet

``` bash
helm version
helm env
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo nginx
helm install my-nginx oci://registry-1.docker.io/bitnamicharts/nginx
helm list
helm history my-nginx
helm upgrade my-nginx oci://registry-1.docker.io/bitnamicharts/nginx --set replicaCount=5
helm rollback my-nginx 1
helm create my-app
helm lint my-app
helm template my-release ./my-app
helm install my-release ./my-app
helm uninstall my-release
```
