## Day 50 – Kubernetes Architecture and Cluster Setup
Challenge Tasks
Task 1: Recall the Kubernetes Story
Before touching a terminal, write down from memory:

Why was Kubernetes created? What problem does it solve that Docker alone cannot?
Who created Kubernetes and what was it inspired by?
What does the name "Kubernetes" mean?
Do not look anything up yet. Write what you remember from the session, then verify against the official docs.
<hr>
Kubernetes was created to manage containers at scale. Docker can run containers on a single machine, but when applications grow and need to run across multiple servers, Docker alone is not enough. Kubernetes solves this by automating deployment, scaling, networking, and management of containers.
<hr>
## Task2:  Kubernetes Architecture
Kubernetes consists of two main components:
<ul>
<li>Control Plane</li>
<li>API Server – Handles all requests</li>
<li>Scheduler – Assigns pods to nodes</li>
<li>Controller Manager – Maintains desired state
</li>
<li>etcd – Stores cluster data</li>
</ul>
<hr>
<img width="1200" height="400" alt="image" src="https://github.com/user-attachments/assets/947f8231-28bc-467a-b71c-51e6a1c151ed" />
</li>
<li>
Worker Node
Kubelet – Manages containers
Container Runtime – Runs containers
Kube Proxy – Handles networking
</li>
<hr>
### Cluster Setup
Tool Used
Kind (Kubernetes IN Docker)
Steps for Setting up
Install Kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
Create Cluster
kind create cluster --name day50-cluster
Verify Cluster
kubectl get nodes






