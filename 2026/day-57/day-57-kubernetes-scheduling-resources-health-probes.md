# Day 57 -- Kubernetes Scheduling, Resources & Health Probes

## What I Learned

Today I learned how Kubernetes schedules Pods, manages CPU and memory,
and checks application health.

## 1. Resource Requests

Requests tell Kubernetes the minimum CPU and memory a Pod needs.
Example:

``` yaml
resources:
  requests:
    cpu: "100m"
    memory: "128Mi"
```

Scheduler uses requests to choose a node.

## 2. Resource Limits

Limits tell Kubernetes the maximum CPU and memory a container can use.

``` yaml
resources:
  limits:
    cpu: "250m"
    memory: "256Mi"
```

If memory exceeds the limit, Kubernetes kills the container (OOMKilled).

## 3. Requests vs Limits

  Requests            Limits
  ------------------- ---------------------
  Minimum resources   Maximum resources
  Used by Scheduler   Enforced by Kubelet

## 4. QoS Classes

-   Guaranteed: Requests = Limits
-   Burstable: Requests and Limits are different
-   BestEffort: No requests or limits

## 5. OOMKilled

The container uses more memory than its memory limit, so Kubernetes
kills it.

## 6. Pending Pod

A Pod stays Pending when no node has enough CPU or memory. Example
message:

    Insufficient cpu
    Insufficient memory

## 7. Liveness Probe

Checks whether the application is still alive. If it fails repeatedly,
Kubernetes restarts the container.

## 8. Readiness Probe

Checks whether the application is ready to receive traffic. If it fails,
the Pod keeps running but the Service does not send traffic to it.

## 9. Startup Probe

Used for slow-starting applications. Kubernetes waits for the
application to finish starting before running liveness and readiness
probes.

## Interview Questions

### Difference between Requests and Limits?

-   Requests: Minimum resources, used by Scheduler.
-   Limits: Maximum resources, enforced by Kubernetes.

### Difference between Liveness and Readiness?

-   Liveness restarts the container.
-   Readiness stops traffic but does not restart the container.

### When do we use Startup Probe?

For applications that take a long time to start, such as Java
applications or databases.

## Summary

-   Scheduler uses Requests.
-   Limits prevent overuse.
-   OOMKilled happens when memory exceeds the limit.
-   Pending Pods cannot be scheduled.
-   Liveness restarts unhealthy containers.
-   Readiness controls traffic.
-   Startup Probe waits until the application is fully started.
