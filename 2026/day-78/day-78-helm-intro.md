# Day 78 -- Introduction to Helm and Chart Basics

## Objective

Learn the basic concepts of Helm and use Helm to deploy and manage MySQL
on a Kubernetes Kind cluster for the AI-BankApp project.

## Project Setup

Repository:

`TrainWithShubham/AI-BankApp-DevOps`

Branch:

`feat/gitops`

The existing project contains Kubernetes manifests under `k8s/` and a
Kind cluster configuration under `setup-k8s/`.

## 1. Helm Concepts

Helm is a **package manager for Kubernetes**, similar to `apt` or `yum`
in Linux.

Important Helm terms:

-   **Chart** -- A reusable package containing Kubernetes templates and
    configuration.
-   **Repository** -- A location where Helm charts are stored and
    shared.
-   **Values** -- Configuration used to customize a chart.
-   **Release** -- An installed instance of a Helm chart inside
    Kubernetes.

Simple flow:

`Helm Repository → Chart → Values → Templates → Kubernetes Resources → Release`

Helm does not replace Kubernetes. Helm generates/manages the Kubernetes
configuration, while Kubernetes still runs and manages the actual
workloads.

## 2. Kind Cluster

The project Kind configuration created:

-   1 control-plane node
-   2 worker nodes
-   Kubernetes v1.35.0
-   Host port `8080` mapped to container port `30080`

Command:

``` bash
kind create cluster --config setup-k8s/kind-config.yml
```

Verification:

``` bash
kubectl get nodes
```

All three nodes reached `Ready` status.

## 3. Verify Helm

Helm was already installed.

``` bash
helm version
helm list
```

`helm list` initially showed no releases.

## 4. Add Bitnami Helm Repository

``` bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo bitnami/mysql
```

MySQL chart found:

-   Chart version: `14.0.3`
-   Application version: `9.4.0`

The chart version represents the Helm package version, while the
application version represents the MySQL version packaged by the chart.

## 5. Inspect Default Values

``` bash
helm show values bitnami/mysql | head -80
```

This displays the default configurable settings of the chart without
deploying anything.

## 6. Install MySQL with Helm

``` bash
helm install bankapp-mysql bitnami/mysql \
  --set auth.rootPassword=Test@123 \
  --set auth.database=bankappdb \
  --set primary.resources.requests.memory=256Mi \
  --set primary.resources.requests.cpu=250m \
  --set primary.resources.limits.memory=512Mi \
  --set primary.resources.limits.cpu=500m \
  --set primary.persistence.size=5Gi
```

The Helm release was created as:

-   Release: `bankapp-mysql`
-   Namespace: `default`
-   Chart: `mysql-14.0.3`
-   App version: `9.4.0`

## 7. Troubleshooting ImagePullBackOff

The MySQL Pod initially failed with:

`Init:ImagePullBackOff`

`kubectl describe pod bankapp-mysql-0` showed that Kubernetes could not
pull:

`docker.io/bitnami/mysql:9.4.0-debian-12-r1`

For this lab environment, the release was updated to use the available
legacy image repository:

``` bash
helm upgrade bankapp-mysql bitnami/mysql \
  --reuse-values \
  --set image.repository=bitnamilegacy/mysql \
  --set global.security.allowInsecureImages=true
```

The StatefulSet template was checked and showed:

`docker.io/bitnamilegacy/mysql:9.4.0-debian-12-r1`

The old stuck Pod was then deleted so the StatefulSet could recreate it:

``` bash
kubectl delete pod bankapp-mysql-0
```

The recreated Pod became:

`1/1 Running`

> Note: This image substitution was used for the local learning lab.
> Helm displayed security warnings indicating that substituted images
> are not the chart's normal validated production configuration.

## 8. Verify Persistent Storage

``` bash
kubectl get pvc -l app.kubernetes.io/instance=bankapp-mysql
```

Result:

-   PVC status: `Bound`
-   Capacity: `5Gi`
-   Access mode: `RWO`
-   StorageClass: `standard`

This confirmed that the Helm persistence value was applied.

## 9. Verify Kubernetes Secret

``` bash
kubectl get secret -l app.kubernetes.io/instance=bankapp-mysql
```

Helm created an `Opaque` Kubernetes Secret for the MySQL release.

## 10. Verify Database

``` bash
kubectl exec -it bankapp-mysql-0 -- \
  mysql -uroot -pTest@123 -e "SHOW DATABASES;"
```

The output included:

`bankappdb`

This proved that the Helm value:

`auth.database=bankappdb`

was successfully passed to the MySQL application.

## 11. Use a Values File

Instead of providing many `--set` arguments, a reusable values file was
created.

File: `mysql-values.yaml`

``` yaml
auth:
  rootPassword: Test@123
  database: bankappdb

primary:
  resources:
    limits:
      cpu: 500m
      memory: 512Mi
    requests:
      cpu: 250m
      memory: 256Mi
  persistence:
    size: 5Gi
    storageClass: ""

metrics:
  enabled: true
  serviceMonitor:
    enabled: false
```

A second release was installed using:

``` bash
helm install bankapp-mysql-v2 bitnami/mysql \
  -f mysql-values.yaml \
  --set image.repository=bitnamilegacy/mysql \
  --set global.security.allowInsecureImages=true
```

This demonstrated that the **same chart can create multiple independent
releases** and that `-f` can load reusable configuration from a values
file.

## 12. Upgrade a Helm Release

The original release was upgraded:

``` bash
helm upgrade bankapp-mysql bitnami/mysql \
  --reuse-values \
  --set metrics.enabled=true
```

Helm created a new revision instead of replacing the release history.

## 13. Helm History

``` bash
helm history bankapp-mysql
```

The lab produced multiple revisions:

-   Revision 1 -- Initial installation
-   Revision 2 -- Image repository fix
-   Revision 3 -- Upgrade
-   Revision 4 -- Upgrade with metrics enabled
-   Revision 5 -- Rollback to Revision 2

Older revisions showed `superseded`, while the active revision showed
`deployed`.

## 14. Rollback

Because Revision 1 contained the image configuration that had failed in
this environment, the lab safely rolled back to Revision 2:

``` bash
helm rollback bankapp-mysql 2
```

Helm reported:

`Rollback was a success! Happy Helming!`

The rollback created **Revision 5** with the description:

`Rollback to 2`

Important lesson: a Helm rollback does not delete later history. It
creates a new revision using the configuration from an older revision.

## 15. Inspect a Helm Chart

The Bitnami MySQL chart was downloaded and extracted:

``` bash
helm pull bitnami/mysql --untar
ls mysql/
```

Important files/directories included:

-   `Chart.yaml` -- chart metadata and version information
-   `values.yaml` -- default chart configuration
-   `templates/` -- Kubernetes resource templates
-   `charts/` -- chart dependencies
-   `README.md`
-   `values.schema.json`

Templates were inspected with:

``` bash
ls mysql/templates/
```

Examples included:

-   `_helpers.tpl`
-   `NOTES.txt`
-   `secrets.yaml`
-   `serviceaccount.yaml`
-   `networkpolicy.yaml`
-   `primary/`

The downloaded chart directory was then removed:

``` bash
rm -rf mysql/
```

## 16. Cleanup

The MySQL release can be removed with:

``` bash
helm uninstall bankapp-mysql
```

Verification:

``` bash
helm list
kubectl get pods
```

## Key Learning

Before Helm, Kubernetes applications may require many separate YAML
files.

With Helm:

`Chart + Values → Rendered Kubernetes YAML → Kubernetes API → Resources`

Helm makes Kubernetes application configuration reusable and provides
release management features such as:

-   Install
-   Upgrade
-   Revision history
-   Rollback
-   Uninstall

### Interview Summary

**Helm is a package manager for Kubernetes. A Helm chart contains
reusable Kubernetes templates, `values.yaml` provides configuration, and
installing a chart creates a release. Helm makes it easier to deploy,
upgrade, rollback, and reuse Kubernetes application configurations
across environments.**

## Day 78 Status

**Completed successfully.**

The next step is **Day 79 -- Creating a Custom Helm Chart for
AI-BankApp**, where the existing Kubernetes manifests will be converted
into our own reusable Helm chart.
