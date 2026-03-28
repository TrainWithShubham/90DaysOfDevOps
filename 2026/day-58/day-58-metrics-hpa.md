# Day 58 – Metrics Server and Horizontal Pod Autoscaler (HPA)

## What is the Metrics Server?
The Metrics Server is a cluster-wide aggregator of resource usage data. It collects CPU and memory usage from kubelets every 15 seconds and exposes it via the Kubernetes Metrics API. It is the backbone for:
- `kubectl top` commands
- Horizontal Pod Autoscaler (HPA)
- Vertical Pod Autoscaler (VPA)

> Without Metrics Server, HPA cannot function and `kubectl top` returns nothing.

---

## Installation

~~~bash
# Kind / kubeadm (may need --kubelet-insecure-tls flag on local clusters)
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Verify after 60 seconds
kubectl top nodes
kubectl top pods -A
~~~

---

## kubectl top — Real-time Usage

~~~bash
kubectl top nodes                        # CPU & memory usage of nodes
kubectl top pods -A                      # All pods across all namespaces
kubectl top pods -A --sort-by=cpu        # Sort by CPU usage
kubectl top pods -A --sort-by=memory     # Sort by memory usage
~~~

> **Important:** `kubectl top` shows **actual usage** — not configured requests or limits. These are three different values.

---

## Key Concepts Before Setting Up HPA

| Term | Meaning |
|---|---|
| Requests | Minimum CPU/memory guaranteed to the pod |
| Limits | Maximum CPU/memory the pod can use |
| Actual Usage | Real-time consumption shown by `kubectl top` |
| HPA Target | Threshold (% of request) that triggers scaling |

---

## Setting Up HPA — Prerequisites

HPA requires `resources.requests` to be set on the container. Without it, HPA cannot calculate utilization and TARGETS will show `<unknown>`.

~~~yaml
resources:
  requests:
    cpu: 200m
~~~

Expose the deployment as a Service:
~~~bash
kubectl expose deployment php-apache --port=80
~~~

---

## Creating HPA — Imperative

~~~bash
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10

# Check HPA status
kubectl get hpa
kubectl describe hpa php-apache
~~~

This scales up when average CPU exceeds 50% of the requested CPU, and scales down when it drops below.

---

## Creating HPA — Declarative (autoscaling/v2)

~~~yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: php-apache
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: php-apache
  minReplicas: 1
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50
  behavior:
    scaleUp:
      stabilizationWindowSeconds: 0       # Scale up immediately
    scaleDown:
      stabilizationWindowSeconds: 300     # Wait 5 mins before scaling down
~~~

---

## autoscaling/v1 vs autoscaling/v2

| Feature | autoscaling/v1 | autoscaling/v2 |
|---|---|---|
| CPU scaling | ✅ | ✅ |
| Memory scaling | ❌ | ✅ |
| Custom metrics | ❌ | ✅ |
| Scaling behavior control | ❌ | ✅ |
| Multiple metrics | ❌ | ✅ |

> Always prefer `autoscaling/v2` for production workloads.

---

## HPA Replica Calculation Formula

~~~
desiredReplicas = ceil(currentReplicas × (currentUsage / targetUsage))
~~~

Example:
- Current replicas: 2
- Current CPU usage: 90%
- Target CPU: 50%
- Desired replicas: ceil(2 × (90 / 50)) = ceil(3.6) = **4 replicas**

---

## Generating Load & Watching Autoscaling

~~~bash
# Start load generator
kubectl run load-generator --image=busybox:1.36 --restart=Never -- \
  /bin/sh -c "while true; do wget -q -O- http://php-apache; done"

# Watch HPA scale up in real time
kubectl get hpa php-apache --watch

# Stop load
kubectl delete pod load-generator
~~~

---

## HPA Scaling Behavior

| Direction | Default Behavior |
|---|---|
| Scale Up | Fast — checks every 15 seconds, scales up quickly |
| Scale Down | Slow — 5 minute stabilization window to avoid flapping |

The stabilization window prevents rapid scale-down when traffic temporarily drops.

---

## HPA Compatibility

HPA works with:
- Deployments ✅
- StatefulSets ✅
- ReplicaSets ✅

---

## Common Mistakes

| Mistake | Result |
|---|---|
| No `resources.requests` set | TARGETS shows `<unknown>`, HPA does nothing |
| Metrics Server not installed | `kubectl top` fails, HPA cannot get metrics |
| Using `autoscaling/v1` | No memory or custom metric support |
| Expecting instant scale-down | Scale-down has a 5-minute window by default |

---

## Useful Commands

~~~bash
kubectl get hpa                          # List all HPAs
kubectl describe hpa php-apache          # Detailed HPA info and events
kubectl get hpa php-apache --watch       # Watch scaling in real time
kubectl delete hpa php-apache            # Delete HPA
kubectl top nodes                        # Node resource usage
kubectl top pods -A --sort-by=cpu        # Pod usage sorted by CPU
~~~

---

## Key Takeaways
- **Metrics Server** collects real-time CPU/memory and powers both `kubectl top` and HPA
- **HPA** automatically scales pods up/down based on actual resource usage vs target threshold
- `resources.requests` is **mandatory** for HPA — without it, utilization cannot be calculated
- **Scale-up is fast**, scale-down has a 5-minute stabilization window to prevent flapping
- **`autoscaling/v2`** supports CPU, memory, custom metrics, and fine-grained behavior control
- HPA formula: `ceil(currentReplicas × (currentUsage / targetUsage))`
