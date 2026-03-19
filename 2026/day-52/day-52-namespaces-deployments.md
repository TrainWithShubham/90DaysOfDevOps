# Day 52 – Kubernetes Namespaces and Deployments

## 📌 Objective
Understand and use Kubernetes Namespaces for isolation and Deployments for managing self-healing, scalable applications.

---

## 🧱 What are Namespaces?

Namespaces are logical partitions inside a Kubernetes cluster used to organize and isolate resources.

### Why use Namespaces?
- Separate environments (dev, staging, production)
- Avoid naming conflicts
- Better resource management
- Access control (RBAC)

---

## 🔍 Default Namespaces

Command:
kubectl get namespaces

Default namespaces:
- default → used if no namespace is specified
- kube-system → Kubernetes internal components
- kube-public → publicly readable resources
- kube-node-lease → node heartbeat tracking

Check system pods:
kubectl get pods -n kube-system

<img width="862" height="202" alt="image" src="https://github.com/user-attachments/assets/69171f12-f035-4622-a534-b2e035bc9af3" />


---

## 🏗️ Creating Custom Namespaces

Commands:
kubectl create namespace dev  
kubectl create namespace staging  

Using YAML:
apiVersion: v1  
kind: Namespace  
metadata:  
  name: production  

kubectl apply -f namespace.yaml  

Verify:
kubectl get namespaces  

<img width="730" height="271" alt="image" src="https://github.com/user-attachments/assets/0d77d2c0-69ac-4edf-a228-aa62ac7ae8dd" />

---

## 🚀 Running Pods in Namespaces

kubectl run nginx-dev --image=nginx:latest -n dev  
kubectl run nginx-staging --image=nginx:latest -n staging  

List pods:
kubectl get pods -A  

Key Learning: 
kubectl get pods -A → shows all namespaces  

<img width="1077" height="392" alt="image" src="https://github.com/user-attachments/assets/a357bc3f-5bb2-40de-8e0f-850da0433df9" />


---

## 📦 Deployment Manifest

apiVersion: apps/v1  
kind: Deployment  
metadata:  
  name: nginx-deployment  
  namespace: dev  
  labels:  
    app: nginx  
spec:  
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
        image: nginx:1.24  
        ports:  
        - containerPort: 80  

---

## 🔑 Key Components of Deployment

- apiVersion: apps/v1 → required for Deployment  
- kind: Deployment → defines resource type  
- metadata → name, namespace, labels  
- replicas → number of pods to maintain  
- selector.matchLabels → connects Deployment to Pods  
- template → blueprint for Pods  

IMPORTANT:
selector.matchLabels MUST match template.metadata.labels  

---

## ▶️ Apply Deployment

kubectl apply -f nginx-deployment.yaml  

Check:
kubectl get deployments -n dev 
<img width="540" height="92" alt="image" src="https://github.com/user-attachments/assets/35bf3c9f-6997-48cb-9ddf-cc9e1361b31e" />

kubectl get pods -n dev  
<img width="782" height="152" alt="image" src="https://github.com/user-attachments/assets/2d7a0fe8-692c-4217-890f-6af932a39bf3" />


---

## 📊 Deployment Output Columns

READY → number of ready pods / desired pods  
UP-TO-DATE → pods running latest configuration  
AVAILABLE → pods available to serve traffic  

---

## 🔁 Self-Healing Behavior

Command:
kubectl delete pod <pod-name> -n dev  

Observation:
- Pod gets deleted  
- Deployment automatically creates a new pod

<img width="770" height="217" alt="image" src="https://github.com/user-attachments/assets/249a2245-7e87-4d4e-9af5-b454f1fdedd5" />


Key Learning:
- New pod has a DIFFERENT name  
- Deployment ensures desired replicas are always running  

---

## 📈 Scaling Deployment

Scale up:
kubectl scale deployment nginx-deployment --replicas=5 -n dev  
<img width="792" height="242" alt="image" src="https://github.com/user-attachments/assets/0555cae5-7a12-4ee0-ac90-5b0ea75d8227" />

Scale down:
kubectl scale deployment nginx-deployment --replicas=2 -n dev 
<img width="840" height="195" alt="image" src="https://github.com/user-attachments/assets/ec964f5d-9eda-49b9-a339-91b8637dd3ba" />


Declarative scaling:
Update replicas in YAML → kubectl apply -f  

Observation:
- Scaling up → new pods created  
- Scaling down → extra pods terminated  

---

## 🔄 Rolling Updates

Update image:
kubectl set image deployment/nginx-deployment nginx=nginx:1.25 -n dev  

Check rollout:
kubectl rollout status deployment/nginx-deployment -n dev  

View history:
kubectl rollout history deployment/nginx-deployment -n dev  

Key Learning:
- Pods updated one by one  
- Zero downtime deployment

<img width="707" height="276" alt="image" src="https://github.com/user-attachments/assets/26533c5f-e852-4cde-8967-8e5ed33e87ca" />
 

---

## ⏪ Rollback

kubectl rollout undo deployment/nginx-deployment -n dev  

Verify:
kubectl describe deployment nginx-deployment -n dev | grep Image  

Result:
- Previous image version restored

<img width="691" height="212" alt="image" src="https://github.com/user-attachments/assets/8c9023ca-0452-4f71-87e1-c934d794967f" />
 

---

## 🆚 Deployment vs Pod

Standalone Pod:
- No self-healing  
- Manual management  
- Not suitable for production  

Deployment:
- Self-healing  
- Scalable  
- Supports rolling updates and rollback  
- Production-ready  

---

## 🧹 Cleanup

kubectl delete deployment nginx-deployment -n dev  
kubectl delete pod nginx-dev -n dev  
kubectl delete pod nginx-staging -n staging  
kubectl delete namespace dev staging production  

Verify:
kubectl get namespaces  
kubectl get pods -A  

<img width="1047" height="686" alt="image" src="https://github.com/user-attachments/assets/019b0ad3-4c1f-4882-aede-75ef07f86c9e" />


---

## 🧠 Key Takeaways

- Namespaces isolate resources within a cluster  
- Deployments manage Pods automatically  
- Pods under Deployment are self-healing  
- Scaling adjusts number of running Pods dynamically  
- Rolling updates ensure zero downtime  
- Rollbacks help recover from failed updates  
