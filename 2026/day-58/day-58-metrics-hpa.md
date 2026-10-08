# Day 58 -- Metrics Server & Horizontal Pod Autoscaler (HPA)

## Objective

Learn how Kubernetes automatically scales applications based on CPU
usage using the Metrics Server and Horizontal Pod Autoscaler (HPA).

## What I Learned

### Metrics Server

-   Collects CPU and memory metrics.
-   Enables `kubectl top` and HPA.
-   HPA cannot work without Metrics Server.

### kubectl top

Commands:

``` bash
kubectl top nodes
kubectl top pods -A
kubectl top pods -A --sort-by=cpu
```

-   `kubectl top` shows actual resource usage.
-   `kubectl describe pod` shows configured requests and limits.

### Deployment

Created a Deployment using: - Image: `registry.k8s.io/hpa-example` - CPU
request: `200m`

``` yaml
resources:
  requests:
    cpu: 200m
```

HPA uses CPU **requests**, not limits.

### Service

``` bash
kubectl expose deployment php-apache --port=80
```

### HPA (Imperative)

``` bash
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
```

Target CPU: 50% Minimum Pods: 1 Maximum Pods: 10

### Load Test

``` bash
kubectl run load-generator --image=busybox:1.36 --restart=Never -- /bin/sh -c "while true; do wget -q -O- http://php-apache; done"
```

Observed: - CPU usage increased. - HPA scaled Pods automatically. -
Replicas increased from **1 to 8**.

### HPA (Declarative)

Used `autoscaling/v2`.

``` yaml
behavior:
  scaleUp:
    stabilizationWindowSeconds: 0
  scaleDown:
    stabilizationWindowSeconds: 300
```

-   Scale up immediately.
-   Wait 300 seconds before scaling down.

## HPA Formula

    desiredReplicas = ceil(currentReplicas × currentUsage / targetUsage)

## autoscaling/v1 vs autoscaling/v2

  v1            v2
  ------------- ------------------------------
  CPU only      CPU, Memory & Custom Metrics
  Basic         Advanced behavior
  No behavior   Supports behavior

## Important Commands

``` bash
kubectl top nodes
kubectl top pods -A
kubectl get hpa
kubectl describe hpa php-apache
kubectl get hpa --watch
kubectl delete hpa php-apache
kubectl delete deployment php-apache
kubectl delete service php-apache
kubectl delete pod load-generator
```

## Key Takeaways

-   Metrics Server provides metrics.
-   HPA needs CPU requests.
-   HPA scales automatically.
-   `kubectl top` shows live usage.
-   `autoscaling/v2` supports advanced scaling behavior.

## Interview Questions

1.  Why is Metrics Server needed?
    -   It provides metrics for `kubectl top` and HPA.
2.  Does HPA use CPU requests or CPU limits?
    -   CPU requests.
3.  Why did TARGETS show `<unknown>`?
    -   Metrics were not yet available.
4.  Why didn't HPA scale down immediately?
    -   Because of the 300-second stabilization window.
5.  What did I complete?
    -   Installed Metrics Server, created Deployment and Service,
        configured HPA, generated load, observed automatic scaling from
        1 to 8 Pods, created HPA using `autoscaling/v2`, and cleaned up
        the lab.
