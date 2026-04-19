# Day 56 – Kubernetes StatefulSets

## What are StatefulSets?
StatefulSets are a Kubernetes workload API object designed for stateful applications (databases, message queues, distributed systems) that require:
- Stable, unique pod identities
- Ordered deployment and scaling
- Persistent storage per pod

---

## StatefulSets vs Deployments

| Feature | Deployment | StatefulSet |
|---|---|---|
| Pod names | Random (`app-xyz-abc`) | Stable, ordered (`app-0`, `app-1`, `app-2`) |
| Startup order | All at once | Ordered: pod-0 → pod-1 → pod-2 |
| Storage | Shared PVC | Each pod gets its own PVC |
| Network identity | No stable hostname | Stable DNS per pod |
| Use case | Stateless apps (web servers) | Stateful apps (MySQL, PostgreSQL, Kafka) |

---

## Key Components

### 1. Headless Service
- A Service with `clusterIP: None`
- Does NOT load-balance — instead creates individual DNS entries per pod
- Required by StatefulSets for stable network identity

~~~yaml
apiVersion: v1
kind: Service
metadata:
  name: web
spec:
  clusterIP: None       # This makes it headless
  selector:
    app: nginx
  ports:
    - port: 80
~~~

### 2. StatefulSet Manifest

~~~yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  serviceName: "web"    # Must match the Headless Service name
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx
          volumeMounts:
            - name: web-data
              mountPath: /usr/share/nginx/html
  volumeClaimTemplates:           # Each pod gets its own PVC
    - metadata:
        name: web-data
      spec:
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: 100Mi
~~~

### 3. volumeClaimTemplates
- Automatically creates a dedicated PVC for each pod
- PVC naming pattern: `<template-name>-<statefulset-name>-<ordinal>`
  - Example: `web-data-web-0`, `web-data-web-1`, `web-data-web-2`

---

## Stable Network Identity (DNS)

Each StatefulSet pod gets a predictable DNS name:

~~~
<pod-name>.<service-name>.<namespace>.svc.cluster.local
~~~

Examples:
~~~
web-0.web.default.svc.cluster.local
web-1.web.default.svc.cluster.local
web-2.web.default.svc.cluster.local
~~~

Test with:
~~~bash
kubectl run -it --rm dns-test --image=busybox --restart=Never -- \
  nslookup web-0.web.default.svc.cluster.local
~~~

---

## Ordered Behavior

### Scale Up (0 → N)
Pods are created strictly in order — next pod only starts after previous is `Ready`:
~~~
web-0 → web-1 → web-2
~~~

### Scale Down (N → 0)
Pods are terminated in reverse order:
~~~
web-2 → web-1 → web-0
~~~

---

## Data Persistence — Survives Pod Deletion

~~~bash
# Write data to web-0
kubectl exec web-0 -- sh -c "echo 'Data from web-0' > /usr/share/nginx/html/index.html"

# Delete the pod
kubectl delete pod web-0

# After pod restarts, data is still there — same PVC was reattached
kubectl exec web-0 -- cat /usr/share/nginx/html/index.html
# Output: Data from web-0
~~~

---

## PVC Retention Behavior

| Action | PVCs Deleted? |
|---|---|
| Pod deleted | No — PVC reattaches to new pod |
| Scale down | No — PVCs preserved for future scale-up |
| StatefulSet deleted | No — must delete PVCs manually |

> **Safety Feature:** Kubernetes never auto-deletes PVCs to prevent accidental data loss.

Manual PVC cleanup:
~~~bash
kubectl delete pvc web-data-web-0 web-data-web-1 web-data-web-2
~~~

---

## Useful Commands

~~~bash
kubectl get sts                        # List StatefulSets (short name)
kubectl get pods -l app=nginx -w       # Watch ordered pod creation
kubectl get pvc                        # View all PersistentVolumeClaims
kubectl scale statefulset web --replicas=5
kubectl delete statefulset web
kubectl describe sts web               # Detailed StatefulSet info
~~~

---

## When to Use StatefulSets

**Use StatefulSet for:**
- Databases: MySQL, PostgreSQL, MongoDB
- Message queues: Kafka, RabbitMQ
- Distributed systems: ZooKeeper, etcd, Elasticsearch
- Any app requiring stable identity or per-instance storage

**Use Deployment for:**
- Web servers, APIs, microservices
- Any app that is truly stateless
- Apps that share a single PVC or no PVC

---

## Key Takeaways
- StatefulSets give pods **stable names**, **stable DNS**, and **dedicated storage**
- A **Headless Service** (`clusterIP: None`) is mandatory — it enables per-pod DNS
- `volumeClaimTemplates` auto-provisions one PVC per pod
- Pods start in order and terminate in reverse
- PVCs outlive pods, scale-down, and even StatefulSet deletion — manual cleanup required
