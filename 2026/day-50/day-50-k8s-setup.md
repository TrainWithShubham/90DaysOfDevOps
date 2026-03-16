# Kubernetes Architecture and Cluster Setup

## Kubernetes Story – Basics

### 1. Why was Kubernetes created?

Kubernetes was created to **automate the deployment, scaling, and management of containerized applications**.

While Docker allows us to **build and run containers**, it does not provide a solution to **manage containers at scale across multiple servers**.

Kubernetes solves several key problems in containerized environments:

- Container orchestration
- Automatic scaling of applications
- Load balancing
- Self-healing (restarting failed containers)
- Rolling updates and rollbacks
- Managing containers across multiple machines (clusters)

In simple terms:

Docker = Run containers  
Kubernetes = Manage containers at scale

---

### 2. Who created Kubernetes and what inspired it?

Kubernetes was originally developed by **Google** and released as an open-source project in **2014**.

It was inspired by **Google's internal container management system called Borg**, which Google used for many years to run large-scale applications in its infrastructure.

Later, Google donated Kubernetes to the **Cloud Native Computing Foundation (CNCF)** to support community-driven development.

---

### 3. What does the name Kubernetes mean?

The word **Kubernetes** comes from Greek and means **"Helmsman" or "Pilot"**, which refers to a person who **steers a ship**.

This represents how Kubernetes **steers and manages containerized applications**.

Kubernetes is commonly abbreviated as **K8s**:

K = first letter  
8 = number of letters between K and S  
S = last letter

---

## Task 2: Draw the Kubernetes Architecture

### Architecture Diagram




### Kubernetes Pod Creation Flow

#### What happens when you run `kubectl apply -f pod.yaml`?

1. **kubectl sends request to API Server**
   - kubectl reads the YAML file.
   - It sends a REST API request to the Kubernetes **API Server**.

2. **API Server validates the request**
   - Authentication
   - Authorization
   - YAML validation

3. **Pod spec stored in etcd**
   - API Server stores the Pod definition in **etcd**.
   - Pod status becomes **Pending**.

4. **Scheduler selects a worker node**
   - Scheduler watches the API Server for pods without a node.
   - It checks available nodes (CPU, memory, etc.).
   - Chooses the best **worker node**.

5. **API Server updates Pod with selected node**
   - Scheduler informs API Server about the chosen node.
   - API Server updates this in **etcd**.

6. **Kubelet detects the Pod**
   - Kubelet on the worker node watches the API Server.
   - When it sees a pod assigned to its node, it starts processing it.

7. **Container runtime starts the container**
   - Kubelet instructs the container runtime (containerd/CRI-O).
   - Image is pulled.
   - Container is started.

8. **Pod status updated**
   - Kubelet sends status back to API Server.
   - Pod becomes **Running**.

#### Flow Summary

kubectl → API Server → etcd → Scheduler → API Server → Kubelet → Container Runtime → Running Pod

---

# What happens if the API Server goes down?

#### What stops working
- kubectl commands
- Creating new pods
- Scheduling pods
- Scaling deployments
- Cluster management

#### What keeps working
- Already running pods continue running
- Applications keep serving traffic

Reason: containers are already running on worker nodes.

---

### What happens if a Worker Node goes down?

1. **Heartbeat stops**
   - Kubelet normally sends heartbeats to the API Server.

2. **Node marked NotReady**
   - If heartbeat stops, Kubernetes marks the node **NotReady**.

3. **Pods on that node become unreachable**

4. **Pods recreated on other nodes**
   - If pods belong to a **Deployment / ReplicaSet / StatefulSet**, Kubernetes automatically creates new pods on healthy nodes.

Note:
- If it is a **standalone Pod**, Kubernetes will NOT recreate it.

---

## Task3: Install kubectl (Windows)

kubectl is the command-line tool used to interact with a Kubernetes cluster.

### Method Used: Manual Installation

#### Step 1: Download kubectl
Download `kubectl.exe` from the official Kubernetes website.

Example download link:
https://dl.k8s.io/release/v1.29.0/bin/windows/amd64/kubectl.exe

Save the file on your system.

Example location:
C:\kubectl\kubectl.exe

---

#### Step 2: Add kubectl to PATH

1. Open **Environment Variables**
2. Go to **System Variables**
3. Find and select **Path**
4. Click **Edit**
5. Add the folder path where kubectl.exe is stored

Example:
C:\kubectl

Click **OK** and save.

---

#### Step 3: Verify Installation

Open a new terminal (PowerShell or CMD) and run:

```
kubectl version --client
```

Example Output:

```
Client Version: v1.29.x
```

This confirms kubectl is installed successfully.

---

### What kubectl does

kubectl allows you to:
- Deploy applications
- Inspect cluster resources
- Manage pods, services, and deployments
- Debug Kubernetes workloads
