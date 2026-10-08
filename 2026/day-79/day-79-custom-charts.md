# Day 79 -- Creating a Custom Helm Chart for AI-BankApp

## Objective

Convert the AI-BankApp Kubernetes manifests into a reusable custom Helm
chart and deploy the complete Spring Boot + MySQL + Ollama stack using
one Helm release.

## 1. Create the Chart

``` bash
mkdir -p helm-chart
cd helm-chart
helm create bankapp
rm -rf bankapp/templates/*.yaml bankapp/templates/tests/
```

We kept `_helpers.tpl` for reusable naming/label helpers and customized
`NOTES.txt`.

## 2. Chart Metadata

`Chart.yaml`:

``` yaml
apiVersion: v2
name: bankapp
description: AI-BankApp -- Spring Boot banking application with MySQL and Ollama AI chatbot
type: application
version: 0.1.0
appVersion: "1.0.0"
maintainers:
  - name: TrainWithShubham
    url: https://github.com/TrainWithShubham
keywords:
  - bankapp
  - spring-boot
  - mysql
  - ollama
  - ai
```

`version` is the Helm chart version. `appVersion` is the application
version.

## 3. values.yaml

Configuration was moved out of hardcoded Kubernetes manifests into
`values.yaml`.

Main sections:

-   `bankapp` -- Spring Boot application settings
-   `mysql` -- MySQL image, resources, and persistence
-   `ollama` -- Ollama image, TinyLlama model, resources, and
    persistence
-   `config` -- shared application configuration
-   `secrets` -- database credentials
-   `storageClass` -- storage configuration
-   `gateway` -- optional gateway configuration

Important examples:

``` yaml
bankapp:
  replicaCount: 4
  autoscaling:
    enabled: true
    minReplicas: 2
    maxReplicas: 4
    targetCPUUtilization: 70

mysql:
  enabled: true
  persistence:
    size: 5Gi
    storageClass: gp3

ollama:
  enabled: true
  model: tinyllama
  persistence:
    size: 10Gi
    storageClass: gp3

config:
  mysqlDatabase: bankappdb
```

## 4. ConfigMap Template

Created `templates/configmap.yaml`.

Example:

``` yaml
MYSQL_DATABASE: {{ .Values.config.mysqlDatabase | quote }}
```

Helm rendered it as:

``` yaml
MYSQL_DATABASE: "bankappdb"
```

This demonstrates the main Helm flow:

``` text
values.yaml
    ↓
Helm template {{ ... }}
    ↓
helm template
    ↓
Normal Kubernetes YAML
```

## 5. Secret Template

Created `templates/secret.yaml`.

Example:

``` yaml
MYSQL_ROOT_PASSWORD: {{ .Values.secrets.mysqlRootPassword | b64enc | quote }}
```

`b64enc` Base64-encodes the value for the Kubernetes Secret.

For production, secrets should normally be stored in a dedicated
secret-management solution rather than committed as plain text in
`values.yaml`.

## 6. Persistent Storage

Created `templates/storage.yaml` containing:

-   Optional StorageClass
-   MySQL PVC -- 5Gi
-   Ollama PVC -- 10Gi

Conditional resources use syntax such as:

``` yaml
{{- if .Values.ollama.enabled }}
```

This allows Ollama-related resources to disappear automatically when
Ollama is disabled.

## 7. Deployments

Three Deployment templates were created.

### BankApp

`templates/bankapp-deployment.yaml`

Important features:

-   Spring Boot container
-   ConfigMap and Secret via `envFrom`
-   Resource requests/limits
-   Readiness and liveness probes
-   Init container waiting for MySQL
-   Init container waiting for Ollama
-   HPA-aware replica configuration

### MySQL

`templates/mysql-deployment.yaml`

Important features:

-   MySQL 8.0
-   Password from Secret
-   Database name from ConfigMap
-   Persistent volume at `/var/lib/mysql`
-   Readiness/liveness probes
-   Recreate strategy

### Ollama

`templates/ollama-deployment.yaml`

Important features:

-   Ollama container
-   Persistent storage
-   TinyLlama model
-   `postStart` lifecycle hook
-   Readiness/liveness probes

The lifecycle hook runs `ollama pull tinyllama`.

## 8. Services

Created `templates/services.yaml`.

  Service      Port
  --------- -------
  MySQL        3306
  Ollama      11434
  BankApp      8080

All are ClusterIP services in this lab.

## 9. Horizontal Pod Autoscaler

Created `templates/hpa.yaml`.

``` text
Target CPU: 70%
Minimum BankApp Pods: 2
Maximum BankApp Pods: 4
```

Because the minimum is 2, Kubernetes created two BankApp Pods.

## 10. Validate the Chart

``` bash
helm lint bankapp/
```

Result:

``` text
1 chart(s) linted, 0 chart(s) failed
```

Render locally:

``` bash
helm template my-bankapp bankapp/ > /tmp/bankapp-rendered.yaml
grep "^kind:" /tmp/bankapp-rendered.yaml
```

The chart rendered 12 resources:

``` text
Secret
ConfigMap
StorageClass
PersistentVolumeClaim
PersistentVolumeClaim
Service
Service
Service
Deployment
Deployment
Deployment
HorizontalPodAutoscaler
```

`helm template` is useful because it renders final Kubernetes YAML
without installing anything.

## 11. Troubleshooting NOTES.txt

Initially `helm template` failed because the starter `NOTES.txt`
referenced:

``` text
.Values.httpRoute.enabled
```

Our custom `values.yaml` did not contain that old starter setting. We
replaced the stale starter `NOTES.txt` content with BankApp-specific
release notes.

Debugging lesson:

1.  Read the file name in the Helm error.
2.  Find the failing `.Values` reference.
3.  Compare it with `values.yaml`.
4.  Fix the stale/incorrect template rather than adding unrelated
    values.

## 12. Install on Kind

AWS/EKS uses the configured `gp3` storage, but the local Kind lab used
its `standard` StorageClass.

``` bash
helm install my-bankapp bankapp/   -n bankapp   --create-namespace   --set storageClass.create=false   --set mysql.persistence.storageClass=standard   --set ollama.persistence.storageClass=standard
```

The Helm release was successfully deployed:

``` text
NAME        NAMESPACE   REVISION   STATUS     CHART           APP VERSION
my-bankapp  bankapp     1          deployed   bankapp-0.1.0   1.0.0
```

## 13. Verify Storage and Resources

Both PVCs became Bound:

``` text
my-bankapp-mysql-pvc    Bound    5Gi     RWO    standard
my-bankapp-ollama-pvc   Bound    10Gi    RWO    standard
```

The three Services and HPA were also created successfully.

## 14. Ollama Startup Troubleshooting

Ollama initially stayed in `ContainerCreating`.

We inspected it with:

``` bash
kubectl describe pod my-bankapp-ollama-55bb44df54-nmzgr -n bankapp
```

The Events showed Kubernetes was downloading the large
`ollama/ollama:latest` image. It took approximately 2 minutes 35
seconds, and the reported image size was approximately 3.78 GB.

After the download:

``` text
State:           Running
Ready:           True
ContainersReady: True
Restart Count:   0
```

So the Helm chart was not broken; the large image simply needed time to
download.

## 15. Final Pod Status

``` bash
kubectl get pods -n bankapp
```

Final result:

``` text
my-bankapp-7567587896-7vcrl          1/1   Running   0
my-bankapp-7567587896-tcpv8          1/1   Running   0
my-bankapp-mysql-6788576b64-qmrmj    1/1   Running   0
my-bankapp-ollama-55bb44df54-nmzgr   1/1   Running   0
```

Architecture:

``` text
                 Helm Release
                  my-bankapp
                       |
        +--------------+--------------+
        |              |              |
        v              v              v
     BankApp         MySQL          Ollama
     2 Pods          1 Pod           1 Pod
        |              |              |
        |              v              v
        |           5Gi PVC        10Gi PVC
        |
        +------ HPA: min 2 / max 4
```

All four Pods were healthy with zero restarts.

## 16. Useful Verification Commands

``` bash
helm list -n bankapp
kubectl get pods -n bankapp
kubectl get svc -n bankapp
kubectl get pvc -n bankapp
kubectl get hpa -n bankapp
```

## 17. Cleanup

``` bash
helm uninstall my-bankapp -n bankapp
helm list -n bankapp
kubectl get pods -n bankapp
```

## Key Helm Concepts Learned

**Chart:** Package containing Kubernetes templates, values, metadata,
and helpers.

**Values:** Configuration supplied to templates.

**Template:** Kubernetes YAML containing Helm expressions.

**Release:** An installed instance of a Helm chart.

**Conditional:** `{{- if .Values.ollama.enabled }}` enables/disables
resources.

**Helper:** `{{ include "bankapp.fullname" . }}` reuses naming logic
from `_helpers.tpl`.

**b64enc:** Base64-encodes Secret values.

**toYaml + nindent:** Renders nested YAML cleanly.

## Interview Summary

> I converted the AI-BankApp Kubernetes manifests into a reusable custom
> Helm chart. I moved configurable settings into `values.yaml` and
> created templates for ConfigMaps, Secrets, persistent storage,
> Deployments, Services, and HPA. I used Helm helpers, conditionals,
> Base64 encoding, and templated resource configuration. I validated the
> chart using `helm lint` and `helm template`, then deployed the
> complete Spring Boot, MySQL, and Ollama stack to a Kind Kubernetes
> cluster as one Helm release. I also verified the Pods, Services, PVCs,
> and HPA and troubleshot Ollama startup by inspecting Kubernetes Pod
> events.

## Final Result

``` text
Custom Helm Chart       DONE
Chart.yaml              DONE
values.yaml             DONE
ConfigMap               DONE
Secret                  DONE
Persistent Storage      DONE
BankApp Deployment      DONE
MySQL Deployment        DONE
Ollama Deployment       DONE
Services                DONE
HPA                     DONE
helm lint               PASSED
helm template           PASSED
Helm Release            DEPLOYED
PVCs                    BOUND
All Pods                RUNNING
```

**Day 79 -- Custom Helm Chart: COMPLETE**
