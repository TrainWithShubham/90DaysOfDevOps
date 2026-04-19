# Day 57 – Resource Requests, Limits & Probes Notes

## 🔹 Task 1: Resource Requests and Limits

### Key Concepts
- Requests = minimum resources (used by scheduler)
- Limits = maximum resources (enforced by kubelet)

CPU:
- 100m = 0.1 CPU  
Memory:
- 128Mi = 128 Mebibytes  

### QoS Classes
- Guaranteed → requests == limits  
- Burstable → requests < limits  
- BestEffort → no requests/limits  

### Example Pod
~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-pod
spec:
  containers:
    - name: nginx
      image: nginx
      resources:
        requests:
          cpu: "100m"
          memory: "128Mi"
        limits:
          cpu: "250m"
          memory: "256Mi"
~~~

### Verify
~~~bash
kubectl describe pod resource-pod
~~~

👉 QoS Class = Burstable  

---

## 🔹 Task 2: OOMKilled (Memory Limit Exceeded)

### Key Concept
- CPU → throttled  
- Memory → container killed  

### Example
~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: stress-pod
spec:
  containers:
    - name: stress
      image: polinux/stress
      command: ["stress"]
      args: ["--vm", "1", "--vm-bytes", "200M", "--vm-hang", "1"]
      resources:
        limits:
          memory: "100Mi"
~~~

### Verify
~~~bash
kubectl describe pod stress-pod
~~~

👉 Reason: OOMKilled  
👉 Exit Code: 137  

✔ Final Answer: Exit Code = 137  

---

## 🔹 Task 3: Pending Pod (Too Large Requests)

### Example
~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: huge-pod
spec:
  containers:
    - name: nginx
      image: nginx
      resources:
        requests:
          cpu: "100"
          memory: "128Gi"
~~~

### Behavior
- Pod stays Pending  

### Verify
~~~bash
kubectl describe pod huge-pod
~~~

👉 Event:
0/1 nodes are available: insufficient cpu, insufficient memory  

✔ Final Answer:
"0/1 nodes are available: insufficient cpu, insufficient memory"  

---

## 🔹 Task 4: Liveness Probe

### Concept
- Detects stuck container  
- Failure → container restart  

### Example
~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: liveness-pod
spec:
  containers:
    - name: busybox
      image: busybox
      command:
        - sh
        - -c
        - |
          touch /tmp/healthy;
          sleep 30;
          rm /tmp/healthy;
          sleep 600;
      livenessProbe:
        exec:
          command: ["cat", "/tmp/healthy"]
        periodSeconds: 5
        failureThreshold: 3
~~~

### Behavior
- After file deletion → probe fails  
- 3 failures → restart  

✔ Answer:
Container restarts multiple times  

---

## 🔹 Task 5: Readiness Probe

### Concept
- Controls traffic  
- Failure → removed from service  
- NO restart  

### Example
~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-readiness
  labels:
    app: nginx
spec:
  containers:
    - name: nginx
      image: nginx
      readinessProbe:
        httpGet:
          path: /
          port: 80
        periodSeconds: 5
~~~

### Break it
~~~bash
kubectl exec nginx-readiness -- rm /usr/share/nginx/html/index.html
~~~

### Verify
~~~bash
kubectl get endpoints readiness-svc
~~~

👉 Endpoints become empty  
👉 Pod shows 0/1 READY  
👉 RESTARTS = 0  

✔ Final Answer:
NO, container is NOT restarted  

---

## 🔹 Task 6: Startup Probe

### Concept
- Gives time for slow apps  
- Disables liveness & readiness until success  

### Example
~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: startup-pod
spec:
  containers:
    - name: busybox
      image: busybox
      command:
        - sh
        - -c
        - |
          sleep 20;
          touch /tmp/started;
          sleep 600;

      startupProbe:
        exec:
          command: ["cat", "/tmp/started"]
        periodSeconds: 5
        failureThreshold: 12

      livenessProbe:
        exec:
          command: ["cat", "/tmp/started"]
        periodSeconds: 5
~~~

### Behavior
- First 20 sec → no restart  
- After success → liveness starts  

### What if failureThreshold = 2?
- 2 × 5 = 10 sec  
- App needs 20 sec → fails early  

✔ Final Answer:
Container restarts before startup completes  

---

## 🔹 Task 7: Cleanup

~~~bash
kubectl delete pod --all -n dev
kubectl delete svc --all -n dev
~~~

---

## 🔥 Important Summary

### CPU vs Memory
- CPU → throttled  
- Memory → OOMKilled  

### Probes

| Probe | Action |
|------|--------|
| Liveness | Restart container |
| Readiness | Remove from service |
| Startup | Delay other probes |

---

## 🧠 Interview Quick Answers

- OOMKilled exit code → 137  
- Pending reason → insufficient resources  
- Readiness failure → no restart  
- Liveness failure → restart  
- Startup failure → restart (after threshold)  

---

## 📌 Final Notes
- Requests → scheduling  
- Limits → enforcement  
- QoS → resource guarantee level  
- Probes → self-healing mechanism  
