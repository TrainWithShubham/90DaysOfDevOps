# Day 53 – Kubernetes Services

## Overview
In Kubernetes, Pods are ephemeral and their IP addresses change whenever they restart.

Problems:
- Pod IPs are not stable
- Multiple Pods exist in a Deployment

Solution:
Kubernetes Services provide:
- Stable IP
- DNS name
- Load balancing

Client → Service → Pods

---

## Task 1: Deployment Setup

Deployment YAML:
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  labels:
    app: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 80

Commands:
kubectl apply -f app-deployment.yaml
kubectl get pods -o wide

Observation:
- 3 Pods running
- Each has different IP
- IP changes on restart

---

## Task 2: ClusterIP Service

YAML:
apiVersion: v1
kind: Service
metadata:
  name: web-app-clusterip
spec:
  type: ClusterIP
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 80

Commands:
kubectl apply -f clusterip-service.yaml
kubectl get services

Test:
kubectl run test-client --image=busybox:latest --rm -it --restart=Never -- sh
wget -qO- http://web-app-clusterip
exit

Key Points:
- Internal access only
- Stable IP
- Load balancing

---

## Task 3: Kubernetes DNS

Format:
<service-name>.<namespace>.svc.cluster.local

Commands:
kubectl run dns-test --image=busybox:latest --rm -it --restart=Never -- sh
wget -qO- http://web-app-clusterip
wget -qO- http://web-app-clusterip.default.svc.cluster.local
nslookup web-app-clusterip
exit

Key Points:
- Built-in DNS
- Short name works in same namespace
- Resolves to ClusterIP

---

## Task 4: NodePort Service

YAML:
apiVersion: v1
kind: Service
metadata:
  name: web-app-nodeport
spec:
  type: NodePort
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080

Commands:
kubectl apply -f nodeport-service.yaml
kubectl get services

Access:
curl http://localhost:30080

Key Points:
- External access
- Uses Node IP + port
- Port range: 30000–32767

---

## Task 5: LoadBalancer Service

YAML:
apiVersion: v1
kind: Service
metadata:
  name: web-app-loadbalancer
spec:
  type: LoadBalancer
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 80

Commands:
kubectl apply -f loadbalancer-service.yaml
kubectl get services

Observation:
- Local → EXTERNAL-IP pending
- Cloud → Public IP assigned

Minikube:
minikube tunnel

---

## Task 6: Service Comparison

| Type | Access | Use Case |
|------|--------|----------|
| ClusterIP | Internal | Service communication |
| NodePort | External via Node | Testing |
| LoadBalancer | External via LB | Production |

Key Concept:
- LoadBalancer = NodePort + ClusterIP

Verify:
kubectl describe service web-app-loadbalancer

---

## Endpoints

Endpoints = Pod IPs behind Service

Command:
kubectl get endpoints web-app-clusterip

Key Points:
- Auto updated
- Shows actual backend Pods

---

## Cleanup

kubectl delete -f app-deployment.yaml
kubectl delete -f clusterip-service.yaml
kubectl delete -f nodeport-service.yaml
kubectl delete -f loadbalancer-service.yaml

kubectl get pods
kubectl get services

Expected:
- Only default kubernetes service remains

---

## Final Understanding

- Pods = dynamic
- Services = stable

Types:
- ClusterIP → internal
- NodePort → external (node)
- LoadBalancer → production

Services provide:
- Stable access
- Load balancing
- Service discovery

---

## LinkedIn Post

Learned Kubernetes Services today — ClusterIP for internal traffic, NodePort for node-level access, and LoadBalancer for production. Services give Pods a stable identity and load balancing.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
