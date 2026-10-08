# Day 53 -- Kubernetes Deployment Lab

## Objective

Deploy an Nginx application using a Kubernetes Deployment and understand
how Deployments, ReplicaSets, and Pods work together.

## Architecture

    Deployment
        │
        ▼
    ReplicaSet
        │
        ▼
    Pods

## Deployment YAML

``` yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: backend-deployment

spec:
  replicas: 3

  selector:
    matchLabels:
      app: backend

  template:
    metadata:
      labels:
        app: backend

    spec:
      containers:
        - name: backend
          image: nginx:latest
          ports:
            - containerPort: 80
```

## Commands Used

### Apply Deployment

``` bash
kubectl apply -f deployment.yml
```

### Verify Resources

``` bash
kubectl get deployments
kubectl get replicasets
kubectl get pods
kubectl describe deployment backend-deployment
```

### Self-Healing Test

``` bash
kubectl delete pod <pod-name>
kubectl get pods
```

Result: - ReplicaSet detected only 2 Pods. - ReplicaSet created a new
Pod from the Pod Template. - Scheduler selected a worker node. - kubelet
started the container.

### Scale Up

``` bash
kubectl scale deployment backend-deployment --replicas=5
kubectl get pods
```

Result: - Desired State = 5 - ReplicaSet created 2 additional Pods.

### Scale Down

``` bash
kubectl scale deployment backend-deployment --replicas=2
kubectl get pods
```

Result: - ReplicaSet terminated 3 Pods. - 2 Pods remained running.

### Cleanup

``` bash
kubectl delete deployment backend-deployment
kubectl get deployments
kubectl get replicasets
kubectl get pods
```

## Interview Questions

### What is a Deployment?

A Deployment manages ReplicaSets and provides scaling, rolling updates,
rollback, and self-healing.

### Why do we need a ReplicaSet?

It keeps the current number of Pods equal to the desired number of
replicas.

### Why do selector and template labels match?

The ReplicaSet uses the selector to identify and manage the Pods created
from the template.

### What is the Pod Template?

It is the blueprint used to create new Pods.

### What happens when a Pod is deleted?

1.  ReplicaSet detects fewer Pods than desired.
2.  ReplicaSet creates a new Pod using the template.
3.  API Server stores the new Pod.
4.  Scheduler assigns a node.
5.  kubelet starts the container.

### What happens when scaling from 3 to 5 replicas?

The Deployment updates the desired state, the ReplicaSet creates two new
Pods, the Scheduler assigns nodes, and the kubelet starts the
containers.

### What happens when scaling from 5 to 2 replicas?

The ReplicaSet terminates three Pods and keeps two Pods running.

## Key Learnings

-   Deployment manages ReplicaSets.
-   ReplicaSet manages Pods.
-   Pod Template is the blueprint for Pods.
-   Labels and selectors connect Deployments, ReplicaSets, Services, and
    Pods.
-   Self-healing recreates failed Pods automatically.
-   Scaling changes the desired number of replicas.
-   Kubernetes always works toward the desired state.
