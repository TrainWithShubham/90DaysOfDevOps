# Day 60 – Kubernetes Capstone (WordPress + MySQL)

## Objective
Deploy a real-world **WordPress + MySQL** application on Kubernetes using the core concepts learned during Days 52–60.

## Architecture

```text
Browser
   |
kubectl port-forward
   |
WordPress NodePort Service
   |
WordPress Deployment (2 Replicas)
   |
ConfigMap + Secret
   |
MySQL Headless Service
   |
MySQL StatefulSet
   |
Persistent Volume Claim (1Gi)
```

## Kubernetes Resources Used

- Namespace
- Secret
- ConfigMap
- Headless Service
- StatefulSet
- Persistent Volume Claim (PVC)
- Deployment
- NodePort Service
- Resource Requests & Limits
- Liveness Probe
- Readiness Probe
- Horizontal Pod Autoscaler (HPA)

## Implementation Summary

### Task 1 – Namespace
- Created `capstone` namespace.
- Set it as the default namespace.

### Task 2 – MySQL
- Created MySQL Secret.
- Created Headless Service.
- Deployed MySQL StatefulSet.
- Attached a 1Gi PVC.
- Verified the `wordpress` database using:
```bash
kubectl exec -it mysql-0 -- mysql -u wpuser -pwordpress123 -e "SHOW DATABASES;"
```

### Task 3 – WordPress
- Created ConfigMap.
- Created Deployment with 2 replicas.
- Added CPU/Memory requests and limits.
- Configured liveness and readiness probes.

### Task 4 – Expose Application
- Created NodePort Service.
- Accessed WordPress with:
```bash
kubectl port-forward svc/wordpress 8080:80
```
- Completed the WordPress installation.

### Task 5 – Self-Healing & Persistence
- Deleted a WordPress pod and Kubernetes recreated it automatically.
- Deleted the MySQL pod and StatefulSet recreated it.
- PVC remained bound and data persisted.

### Task 6 – HPA
Configured:
- Min Pods: 2
- Max Pods: 10
- CPU Target: 50%

Verified:
```
cpu: 1% / 50%
```

## Concept Mapping

| Concept | Day |
|---|---:|
| Namespace | 52 |
| Deployment | 52 |
| Service | 53 |
| Secret | 54 |
| ConfigMap | 54 |
| Persistent Volume | 55 |
| StatefulSet | 56 |
| Resource Limits | 57 |
| Liveness & Readiness Probes | 57 |
| HPA | 58 |
| Helm | 59 |
| Capstone | 60 |

## Results

- Namespace created successfully.
- MySQL StatefulSet running.
- PVC Bound.
- WordPress running with two replicas.
- NodePort Service working.
- WordPress installed successfully.
- Blog post created.
- Self-healing verified.
- Persistent storage verified.
- HPA configured successfully.

## Reflection

This capstone project combined all major Kubernetes concepts into one real-world application. I learned how Deployments, StatefulSets, Services, ConfigMaps, Secrets, PVCs, probes, and autoscaling work together. The most valuable lesson was seeing Kubernetes automatically recover failed pods while preserving application data through persistent storage.

## Conclusion

The WordPress + MySQL application was successfully deployed and tested using Kubernetes best practices including StatefulSets, Deployments, Secrets, ConfigMaps, Services, Persistent Storage, Health Probes, Resource Management, and Horizontal Pod Autoscaling.
