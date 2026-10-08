# Day 56 - Kubernetes StatefulSet (Simple Notes)

## What is a StatefulSet?

A StatefulSet is used for applications that need: - Stable Pod names -
Stable network identity - Stable storage

Examples: - PostgreSQL - MySQL - MongoDB - Kafka - Cassandra

## Deployment vs StatefulSet

Deployment - Random Pod names - Good for stateless applications

StatefulSet - Fixed Pod names - Good for databases

Example: - Deployment: demo-app-abc123 - StatefulSet: nginx-0, nginx-1,
nginx-2

## Headless Service

``` yaml
clusterIP: None
```

Meaning: - No Cluster IP - DNS record for every Pod

Examples: - nginx-0.nginx-headless.default.svc.cluster.local -
nginx-1.nginx-headless.default.svc.cluster.local

## Normal Service

Client -\> Cluster IP -\> Any matching Pod

## Headless Service

Client -\> DNS -\> Specific Pod

## StatefulSet YAML

``` yaml
apiVersion: apps/v1
kind: StatefulSet

metadata:
  name: nginx

spec:
  serviceName: nginx-headless
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
```

## Commands

Create:

``` bash
kubectl apply -f statefulset.yaml
```

Watch:

``` bash
kubectl get pods -w
```

Delete:

``` bash
kubectl delete pod nginx-1
```

## What You Observed

-   Pods: nginx-0, nginx-1, nginx-2
-   Deleting nginx-1 recreates nginx-1
-   Scale to 5 creates nginx-3 and nginx-4
-   Scale to 2 deletes nginx-4, nginx-3 and nginx-2
-   Pods are created in order.
-   Pods are deleted in reverse order.

## Interview Answers

Why StatefulSet? - Databases need stable Pod names, network identity and
storage.

Why Headless Service? - It creates DNS names for each Pod instead of one
Cluster IP.

What happens if nginx-1 is deleted? - Kubernetes recreates nginx-1 with
the same name.

## Key Points

-   StatefulSet is for stateful applications.
-   Pod names stay the same.
-   Headless Service uses clusterIP: None.
-   DNS connects to a specific Pod.
-   Ordered creation.
-   Ordered deletion.
