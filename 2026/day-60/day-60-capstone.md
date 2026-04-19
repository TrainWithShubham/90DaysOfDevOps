# 🚀 Day 60 – Capstone: WordPress + MySQL on Kubernetes

---

# 📌 Overview

This capstone project demonstrates deploying a **real-world WordPress + MySQL application** on Kubernetes using multiple core concepts including StatefulSets, Deployments, Services, Secrets, ConfigMaps, Storage, Probes, and HPA.

The goal was not just deployment, but understanding **how each component interacts in a production-like architecture**.

---

# 🏗️ Architecture

## 🔹 Components Used

- Namespace → `capstone`
- MySQL → StatefulSet
- WordPress → Deployment (2 replicas)
- Storage → Persistent Volume Claim (PVC)
- Secret → DB credentials
- ConfigMap → DB configuration
- Services:
  - Headless Service (MySQL)
  - NodePort Service (WordPress)
- HPA → Auto scaling WordPress

---

## 🔗 Architecture Flow

~~~
WordPress Pods (Deployment)
        ↓
Connect via DNS
        ↓
MySQL Pod (StatefulSet)
        ↓
Persistent Volume (PVC)
~~~

---

# ⚙️ Implementation Summary

## 🔹 MySQL Setup

- Used **StatefulSet** for stable identity
- Used **Headless Service** for DNS resolution
- Mounted storage at `/var/lib/mysql`
- Credentials passed using **Secret**

---

## 🔹 WordPress Setup

- Used **Deployment with 2 replicas**
- Used:
  - ConfigMap → DB host & DB name
  - Secret → DB user & password
- Added:
  - Readiness Probe
  - Liveness Probe

---

## 🔹 Service Exposure

- NodePort Service on port `30080`
- Access via:

~~~
http://<NodeIP>:30080
~~~

---

## 🔹 HPA Setup

- Target CPU: 50%
- Min replicas: 2
- Max replicas: 10

---

# ✅ Verification Results

✔ WordPress pods running: `2/2 READY`  
✔ MySQL pod running: `1/1 READY`  
✔ WordPress UI accessible  
✔ Blog post created successfully  

---

# 🔁 Self-Healing Test

| Action | Result |
|------|-------|
| Delete WordPress pod | Recreated automatically ✅ |
| Delete MySQL pod | Recreated with same data ✅ |
| Refresh WordPress | Data persisted ✅ |

---

# 💾 Persistence Test

- Data stored in PVC
- After MySQL restart:
  - Blog content remained intact ✅

---

# 📊 Concepts Used

| Concept | Day |
|--------|----|
| Namespace | Day 52 |
| Deployment | Day 52 |
| Service | Day 53 |
| ConfigMap | Day 54 |
| Secret | Day 54 |
| StatefulSet | Day 56 |
| PVC | Day 56 |
| Probes | Day 57 |
| Resource Limits | Day 57 |
| HPA | Day 58 |
| Helm | Day 59 |

---

# ⚔️ Helm vs Manual Comparison

| Feature | Manual | Helm |
|--------|--------|------|
| Resource Count | ~10–12 | ~15–20 |
| Setup Time | High | Very Fast ⚡ |
| Control | Full | Limited |
| Best Practices | Manual | Built-in |
| Production Ready | Needs tuning | Yes |

👉 Helm created additional:
- Secrets
- ConfigMaps
- Init containers
- MariaDB instead of MySQL

---

# 🧠 Key Learnings

### 🔹 StatefulSet Behavior
- Provides stable DNS and storage
- Required for databases

---

### 🔹 Headless Service Usage
- Must use:

~~~
<pod>.<service>.<namespace>.svc.cluster.local
~~~

- Not just service name

---

### 🔹 MySQL Initialization

- MySQL reads env variables **only on first startup**
- If PVC exists → credentials won’t change

---

### 🔹 Secret Mapping

- MySQL uses `MYSQL_*`
- WordPress uses `WORDPRESS_DB_*`
- Mapping required via `secretKeyRef`

---

### 🔹 Probes Behavior

- Readiness probe failure ≠ container failure
- Liveness probe triggers restart

---

### 🔹 Image Pull in Multi-node Cluster

- Each node pulls image separately
- Causes delay in replicas

---

# 🚨 Troubleshooting (Real Issues Faced)

---

## ❌ Issue 1: MySQL Password Not Working

### 🔍 Cause:
- PVC already initialized with old password

### ✅ Fix:

~~~
kubectl delete pvc <pvc-name>
kubectl reapply
~~~

---

## ❌ Issue 2: WordPress 500 Error

### 🔍 Cause:
- Incorrect DB host (wrong service name)

### ❌ Wrong:

~~~
mysql-headless.capstone.svc.cluster.local
~~~

### ✅ Correct:

~~~
mysql-statefulset-0.mysql-headless.capstone.svc.cluster.local
~~~

---

## ❌ Issue 3: Pods Running but Not Ready

### 🔍 Cause:
- DB connection failure

### 🔍 Symptom:

~~~
READY 0/1
HTTP 500 in logs
~~~

---

## ❌ Issue 4: Image Pull Delay

### 🔍 Cause:
- Large image (~600MB)
- Multi-node cluster

### ✅ Fix:

~~~
kind load docker-image wordpress:latest
~~~

---

## ❌ Issue 5: Wrong Environment Variables

### ❌ Wrong:

~~~
MYSQL_USER
MYSQL_PASSWORD
~~~

### ✅ Correct:

~~~
WORDPRESS_DB_USER
WORDPRESS_DB_PASSWORD
~~~

---

## ❌ Issue 6: Headless Service Misuse

### 🔍 Cause:
- Using service DNS instead of pod DNS

---

# 💡 What Was Hard

- Understanding StatefulSet DNS  
- Debugging DB connection errors  
- PVC behavior with MySQL  
- Headless vs ClusterIP confusion  

---

# 💡 What Clicked

- Kubernetes DNS resolution  
- Difference between Deployment & StatefulSet  
- Secret + ConfigMap usage  
- Real-world troubleshooting mindset  

---

# 🚀 What I Would Add (Production)

- Ingress (instead of NodePort)  
- TLS (HTTPS)  
- External DB (RDS)  
- Monitoring (Prometheus + Grafana)  
- Logging (ELK stack)  
- CI/CD pipeline  

---

# 🎯 Final Reflection

This capstone combined **12 Kubernetes concepts into one working system**.  

It helped move from:
👉 Writing YAML  
➡️ To  
👉 Understanding real system behavior  

---

# 🏁 Conclusion

Successfully deployed a **production-like WordPress + MySQL architecture** with:

✔ High availability  
✔ Self-healing  
✔ Persistent storage  
✔ Auto-scaling  

---

# 🔥 Tag

#90DaysOfDevOps #Kubernetes #DevOps #LearningInPublic #Cloud
