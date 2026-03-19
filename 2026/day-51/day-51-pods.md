# Day 51 – Kubernetes Manifests and Your First Pods

## 📌 Objective
Learn how to create Kubernetes Pods using YAML manifests and understand the structure of a manifest file.

---

## 🧱 Anatomy of a Kubernetes Manifest

Every Kubernetes resource requires these 4 main fields:

1. apiVersion  
Defines which Kubernetes API version to use  
Example: v1 (used for Pods)

2. kind  
Specifies the type of resource  
Example: Pod

3. metadata  
Contains identity details of the resource  
Includes:
- name → unique name of the pod  
- labels → key-value pairs for grouping/filtering  

4. spec  
Defines the desired state of the resource  
Includes:
- container image  
- ports  
- commands  

---

## 🚀 Pod 1: Nginx Pod

apiVersion: v1  
kind: Pod  
metadata:  
  name: nginx-pod  
  labels:  
    app: nginx  
spec:  
  containers:  
  - name: nginx  
    image: nginx:latest  
    ports:  
    - containerPort: 80  

Commands Used:
kubectl apply -f nginx-pod.yaml  
kubectl get pods  


<img width="767" height="192" alt="image" src="https://github.com/user-attachments/assets/436e35df-91a9-4aa2-8c69-9c069a474d60" />

kubectl describe pod nginx-pod  

<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/72d90023-df82-4177-bde2-42e98efd9adb" />

kubectl logs nginx-pod

<img width="915" height="601" alt="image" src="https://github.com/user-attachments/assets/357b72ef-1add-4822-bb43-1438da498ff3" />
 
kubectl exec -it nginx-pod -- bash  



Verification:
Run: curl localhost:80  
Result: Nginx welcome page displayed  

---

## 📦 Pod 2: BusyBox Pod

apiVersion: v1  
kind: Pod  
metadata:  
  name: busybox-pod  
  labels:  
    app: busybox  
    environment: dev  
spec:  
  containers:  
  - name: busybox  
    image: busybox:latest  
    command: ["sh", "-c", "echo Hello from BusyBox && sleep 3600"]  

Commands Used:
kubectl apply -f busybox-pod.yaml  
kubectl get pods  
kubectl logs busybox-pod  

Verification:
Output: Hello from BusyBox  

Key Learning:
BusyBox exits immediately without a long-running command  
sleep 3600 keeps container alive  

---

## 🧪 Pod 3: Custom Pod with Labels

apiVersion: v1  
kind: Pod  
metadata:  
  name: custom-pod  
  labels:  
    app: myapp  
    environment: test  
    team: devops  
spec:  
  containers:  
  - name: my-container  
    image: nginx:latest  

---

## 🔄 Imperative vs Declarative

Imperative:
kubectl run redis-pod --image=redis:latest  

Declarative:
kubectl apply -f nginx-pod.yaml  

Difference:

Imperative → quick, command-based, not version controlled  
Declarative → YAML-based, version controlled, preferred in production  

---

## 🧾 Generate YAML (Dry Run)

kubectl run test-pod --image=nginx --dry-run=client -o yaml  

Learning:
Used to generate base YAML and customize it  

---

## ✅ Validation Before Apply

Client-side:
kubectl apply -f nginx-pod.yaml --dry-run=client  

Server-side:
kubectl apply -f nginx-pod.yaml --dry-run=server  

Error when image is missing:
error: spec.containers[0].image: Required value  

---

## 🏷️ Labels and Filtering

View labels:
kubectl get pods --show-labels  

Filter:
kubectl get pods -l app=nginx  
kubectl get pods -l environment=dev  

Add label:
kubectl label pod nginx-pod environment=production  

Remove label:
kubectl label pod nginx-pod environment-  

---

## 🧹 Cleanup

kubectl delete pod nginx-pod  
kubectl delete pod busybox-pod  
kubectl delete pod redis-pod  

OR  

kubectl delete -f nginx-pod.yaml  

Key Learning:
Pods are not self-healing  
Once deleted, they are gone permanently  

---

## 📸 Output Screenshot

Take screenshot of:
kubectl get pods  

Make sure STATUS is Running  

Store image at:
2026/day-51/images/pods-running.png  

Add in markdown:
![Pods Running](./images/pods-running.png)  

---

## 🧠 Key Takeaways

Pods are the smallest deployable unit in Kubernetes  
YAML defines desired state  
Declarative approach is preferred  
Labels help in filtering  
Pods are temporary and not used directly in production  
