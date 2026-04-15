### Day 51 – Kubernetes Manifests and Your First Pods

### Task 1: Create Your First Pod (Nginx)
Create a file called nginx-pod.yaml:
📄 View Screenshot: [Nginx file](nginx-pod.yml)

kubectl apply -f nginx-pod.yaml
##### Verify:

kubectl get pods
kubectl get pods -o wide
Wait until the STATUS shows Running. Then explore:

#### Detailed info about the pod
kubectl describe pod nginx-pod

#### Read the logs
kubectl logs nginx-pod

##### Get a shell inside the container
kubectl exec -it nginx-pod -- /bin/bash

#### Inside the container, run:
curl localhost:80
exit
📄 View Screenshot: [Nginx file](nginx-status.pdf)

### Task 2: Create a Custom Pod (BusyBox)
Write a new manifest busybox-pod.yaml from scratch (do not copy-paste the nginx one):
 [Nginx file](busyboxpod.yml)
 
kubectl apply -f busybox-pod.yaml
kubectl get pods
kubectl logs busybox-pod





