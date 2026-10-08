# Day 54 -- Kubernetes ConfigMaps & Secrets (Hands-on Lab)

## Objective

-   Create and use ConfigMaps
-   Inject ConfigMaps as environment variables
-   Update ConfigMaps
-   Understand why running Pods don't automatically receive updated
    values
-   Create Kubernetes Secrets
-   Inject Secrets into Pods
-   Understand Base64 encoding vs encryption

## Create ConfigMap

``` bash
kubectl create configmap app-config \
  --from-literal=APP_ENV=production \
  --from-literal=APP_DEBUG=false \
  --from-literal=APP_PORT=8080
```

Verify:

``` bash
kubectl get configmap
kubectl describe configmap app-config
kubectl get configmap app-config -o yaml
```

## ConfigMap from File

Create `app.properties`:

``` properties
APP_ENV=production
APP_DEBUG=false
APP_PORT=8080
```

``` bash
kubectl create configmap app-config-file --from-file=app.properties
```

## Inject ConfigMap

``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: configmap-pod
spec:
  containers:
  - name: app-container
    image: nginx
    envFrom:
    - configMapRef:
        name: app-config
```

``` bash
kubectl apply -f configmap-pod.yaml
kubectl exec -it configmap-pod -- env | grep APP
```

## Update ConfigMap

``` bash
kubectl edit configmap app-config
```

Change APP_ENV from production to staging, save with `Esc` then `:wq`.

Recreate the Pod:

``` bash
kubectl delete pod configmap-pod
kubectl apply -f configmap-pod.yaml
kubectl exec -it configmap-pod -- env | grep APP_ENV
```

Expected:

``` text
APP_ENV=staging
```

## Create Secret

``` bash
kubectl create secret generic db-secret \
  --from-literal=DB_USER=admin \
  --from-literal=DB_PASSWORD=myPassword123
```

View:

``` bash
kubectl describe secret db-secret
kubectl get secret db-secret -o yaml
```

Decode:

``` bash
echo "YWRtaW4=" | base64 --decode
echo "bXlQYXNzd29yZDEyMw==" | base64 --decode
```

## Inject Secret

``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-pod
spec:
  containers:
  - name: app-container
    image: nginx
    envFrom:
    - secretRef:
        name: db-secret
```

``` bash
kubectl apply -f secret-pod.yaml
kubectl exec -it secret-pod -- env | grep DB
```

Expected:

``` text
DB_USER=admin
DB_PASSWORD=myPassword123
```

## Interview Notes

-   ConfigMap stores non-sensitive configuration.
-   Secret stores sensitive information.
-   Secrets are Base64 encoded, not encrypted by default.
-   Updating a ConfigMap does not update running Pods automatically.
-   Restart or recreate Pods to load updated ConfigMap values.

## Day 54 Complete ✅
