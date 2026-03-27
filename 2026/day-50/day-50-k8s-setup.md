## Day 50 – Kubernetes Architecture and Cluster Setup
Challenge Tasks
Task 1: Recall the Kubernetes Story
<p>
Kubernetes was created to manage containers at scale. Docker can run containers on a single machine, but when applications grow and need to run across multiple servers, Docker alone is not enough. Kubernetes solves this by automating deployment, scaling, networking, and management of containers.</p>

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
| Component             | Description                                              | Key Responsibility                                                                     |
| --------------------- | -------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| **Kubelet**           | Agent running on each worker node                        | Ensures containers (pods) are running as expected and communicates with the API server |
| **Container Runtime** | Software that runs containers (e.g., containerd, Docker) | Pulls images and runs containers inside pods                                           |
| **Kube Proxy**        | Network component on each node                           | Manages networking rules and enables communication between services and pods           |

<hr>
 ## Cluster Setup

<ul>Tool Used
<li>Kind (Kubernetes IN Docker)</li>
<li>Steps for Setting up</li>
</ul>

### Task 3: Install kubectl
# macOS
brew install kubectl
brew install docker --cask docker

<img width="1280" height="800" alt="Screenshot 2026-03-27 at 10 50 29 PM" src="https://github.com/user-attachments/assets/4a830a2c-f05c-473e-9b3d-69892d6ef209" />
<br>
#### Step 3: Create Kubernetes Cluster


[Kind-config](./kind-config.yml)

[screenshot](../screenshot/)
 
<hr>


<br>
### Step 4: Verify Cluster
kubectl get nodes
### Task 5: Explore Your Cluster
# See cluster info
kubectl cluster-info

# List all nodes
kubectl get nodes

# Get detailed info about your node
kubectl describe node <node-name>

# List all namespaces
kubectl get namespaces

### See ALL pods running in the cluster (across all namespaces)

kubectl get pods -A

[screenshot](screenshot/cluster.pdf)
Look at the pods running in the kube-system namespace:

kubectl get pods -n kube-system

[screenshot](screenshot/explorepod.pdf)

<hr>
#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham



















