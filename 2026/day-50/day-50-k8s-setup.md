# Why was Kubernetes created?

Kubernetes was created because managing thousands of containers across many servers manually is very difficult. If a container or server fails, Kubernetes automatically restarts containers, schedules them on healthy servers, scales applications based on demand, and manages networking. It also works with persistent storage so application data is not lost when a container is recreated.

# Who created Kubernetes and what inspired it?

Kubernetes was created by Google. It was inspired by Google's internal container management system called Borg. Later, Google donated Kubernetes to the Cloud Native Computing Foundation (CNCF), where it became an open-source project.

# What does Kubernetes mean?

Kubernetes is a Greek word that means "helmsman" or "captain." Just like a captain manages many ships, Kubernetes manages many containers.

# Why can't we just use Docker?

Docker is used to create and run containers. Kubernetes is used to manage containers across multiple machines. It automatically handles deployment, scaling, networking, load balancing, self-healing, and high availability.

# Which part actually runs the application

The Worker Nodes run the application. The Control Plane manages the cluster and tells the Worker Nodes what to do.

# What is Control Plane?

he Control Plane is the brain of the Kubernetes cluster. It receives requests from users through the API Server, stores the cluster state in etcd, schedules Pods, and makes sure the cluster stays in the desired state. It manages the entire cluster but does not run application containers.

# What is Worker Node?

A Worker Node is the machine where Pods and containers actually run. Each Worker Node contains kubelet, kube-proxy, and a container runtime like containerd. The Worker Node follows instructions from the Control Plane to run and manage applications.

# What is the API Server?

The API Server is the front door of the Kubernetes cluster. It receives all requests from users and Kubernetes components, validates them, stores the cluster state in etcd, and coordinates communication between all cluster components.

# What happens if etcd is lost?

etcd stores the entire Kubernetes cluster state. If etcd is lost, Kubernetes forgets its configuration, Deployments, Services, Secrets, ConfigMaps, and other resources. Running Pods may continue working for some time, but the Control Plane cannot properly manage the cluster. That is why etcd backups are very important.

# Why do we use Namespaces?

Namespaces are used to logically separate resources inside a Kubernetes cluster. They help organize applications, avoid naming conflicts, and make it easier to manage access and resources for different teams or environments.

# Why do we use Deployments instead of ReplicaSets?

We use Deployments because they provide rolling updates, rollbacks, scaling, and manage ReplicaSets automatically. ReplicaSets only ensure the required number of Pods are running.

# Day 50 – Kubernetes Architecture and Cluster Setup

## Kubernetes History

Kubernetes was created to manage many containers running on multiple servers. Docker can run containers, but it cannot manage containers across many servers easily.

Kubernetes was created by Google and inspired by Google's Borg system.

The word **Kubernetes** means **Captain** in Greek.

---

# Kubernetes Architecture

## Control Plane

- API Server – Receives all requests from kubectl.
- etcd – Stores all cluster information.
- Scheduler – Selects the best node for a Pod.
- Controller Manager – Keeps the cluster in the desired state.

## Worker Node

- kubelet – Manages Pods on the node.
- kube-proxy – Handles Pod networking.
- containerd – Runs containers.

### Request Flow

```
kubectl
   ↓
API Server
   ↓
etcd
   ↓
Controller Manager
   ↓
ReplicaSet
   ↓
Scheduler
   ↓
API Server
   ↓
kubelet
   ↓
containerd
   ↓
Running Pod
```

---

# What happens when I run kubectl apply?

1. kubectl sends the request to the API Server.
2. API Server stores the desired state in etcd.
3. Controller Manager creates the required resources.
4. Scheduler selects the best Worker Node.
5. kubelet starts the Pod.
6. containerd runs the container.
7. Pod becomes Running.

---

# What happens if the API Server goes down?

- kubectl cannot communicate with the cluster.
- No new resources can be created.
- Existing Pods continue running.

---

# What happens if a Worker Node goes down?

- Kubernetes detects the failure.
- Scheduler chooses another healthy node (if available).
- ReplicaSet creates new Pods.

---

# Local Kubernetes Cluster

Tool Used: **Kind**

Why I chose Kind:

- Easy to install.
- Uses Docker.
- Fast to create a cluster.
- Good for learning Kubernetes.

---

# Commands I Used

kubectl version --client

kind version

kubectl cluster-info

kubectl get nodes

kubectl get namespaces

kubectl get pods -A

kubectl describe node tws-cluster-control-plane

kind get clusters

kind delete cluster --name tws-cluster

kind create cluster --name tws-cluster

kubectl get nodes

kubectl config current-context

kubectl config get-contexts

kubectl config view

---

# kube-system Pods

| Pod                     | Purpose                      |
| ----------------------- | ---------------------------- |
| kube-apiserver          | Receives Kubernetes requests |
| etcd                    | Stores cluster data          |
| kube-scheduler          | Selects the best node        |
| kube-controller-manager | Maintains desired state      |
| CoreDNS                 | DNS for Pods                 |
| kube-proxy              | Handles networking           |
| kindnet                 | Creates Pod network          |

---

# kubeconfig

A kubeconfig file stores cluster connection details.

Default location:

~/.kube/config

It contains:

- Cluster information
- User information
- Contexts

---

---

## Kubernetes System Pods

---

# What I Learned

- Kubernetes manages containers across multiple servers.
- API Server is the main entry point.
- etcd stores cluster information.
- Scheduler selects the best node.
- Controller Manager keeps the cluster healthy.
- kubelet manages Pods.
- containerd runs containers.
- Kind is a simple local Kubernetes cluster.
- kubectl is the command-line tool used to manage Kubernetes.
