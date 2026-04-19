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

<img width="757" height="541" alt="image" src="https://github.com/user-attachments/assets/5900adcc-2e53-4af6-879c-77cb5f3e398e" />

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

<img width="607" height="83" alt="image" src="https://github.com/user-attachments/assets/f5f85645-3de7-4bb8-bda1-49361f88f5f1" />

kubectl get pods 

<img width="646" height="113" alt="image" src="https://github.com/user-attachments/assets/edf300c7-99b9-4ef3-b6c7-beabf2063283" />

kubectl logs busybox-pod  

<img width="625" height="77" alt="image" src="https://github.com/user-attachments/assets/6b0b9ca4-75ba-49be-8ebb-b3708f2a5ea5" />


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

<img width="748" height="177" alt="image" src="https://github.com/user-attachments/assets/6fe66353-f1b9-4c26-ba90-f574d2fefd7d" />

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
<img width="825" height="316" alt="image" src="https://github.com/user-attachments/assets/29b9cd6f-5df6-48dd-b03f-81b320faa037" />

<img width="1088" height="86" alt="image" src="https://github.com/user-attachments/assets/8e52e345-0d08-441e-8a89-f213b0028eb8" />

Server-side:
kubectl apply -f nginx-pod.yaml --dry-run=server  
<img width="483" height="213" alt="image" src="https://github.com/user-attachments/assets/a04358e7-b629-45ad-82a0-435274a1b917" />

<img width="1648" height="87" alt="image" src="https://github.com/user-attachments/assets/47fe5613-6f0c-486e-9bb8-eb6d2903165a" /> 

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

<img width="797" height="676" alt="image" src="https://github.com/user-attachments/assets/0126e66f-11ed-4d1e-a2af-501534711660" />


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

<img width="822" height="192" alt="image" src="https://github.com/user-attachments/assets/3d0a8b22-2580-42f9-a5c6-39ced9807fac" />

---

## 🧠 Key Takeaways

Pods are the smallest deployable unit in Kubernetes  
YAML defines desired state  
Declarative approach is preferred  
Labels help in filtering  
Pods are temporary and not used directly in production  
