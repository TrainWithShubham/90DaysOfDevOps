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

<img width="1275" height="537" alt="image" src="https://github.com/user-attachments/assets/206105b9-33bd-4c2e-8dbe-7618d564cfb1" />

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

---

## Task 4: Set Up Local Kubernetes Cluster

### Tool Chosen: kind (Kubernetes in Docker)

I chose **kind** to create my local Kubernetes cluster.

#### Reason for Choosing kind

- **Lightweight** – Uses Docker containers as nodes instead of full virtual machines.
- **Fast startup** – Cluster creation takes only a few seconds.
- **Low resource usage** – Works well on local laptops with limited CPU and RAM.
- **Good for local practice** – Ideal for learning Kubernetes and running test environments.

Because of these advantages, **kind is very convenient for practicing Kubernetes locally**.

---

### Installing kind (Windows)

I installed **kind manually**, similar to how I installed **kubectl**.

#### Step 1: Download kind
Download `kind.exe` from the official GitHub releases page.

Example:
https://kind.sigs.k8s.io/dl/latest/kind-windows-amd64

Rename the file to:

```
kind.exe
```

Save it in a folder.

Example location:

```
C:\kind\kind.exe
```

---

#### Step 2: Add kind to PATH

1. Open **Environment Variables**
2. Go to **System Variables**
3. Select **Path**
4. Click **Edit**
5. Add the folder path

Example:

```
C:\kind
```

Click **OK** to save.

---

### Create the Kubernetes Cluster

Run:

```
kind create cluster --name devops-cluster
```

---

### Verify the Cluster

Check cluster information:

```
kubectl cluster-info
```

Check nodes:

```
kubectl get nodes
```

Example output:

```
NAME                     STATUS   ROLES           AGE
devops-cluster-control-plane   Ready    control-plane   1m
```

This confirms the Kubernetes cluster is running successfully.

---

### Summary

kind provides a **lightweight, fast, and efficient way to run a Kubernetes cluster locally**, making it ideal for **DevOps practice and learning Kubernetes concepts**.

---

## Task 5: Explore Your Cluster

`kubectl cluster-info`

<img width="988" height="153" alt="image" src="https://github.com/user-attachments/assets/08c5d179-945e-418a-a335-051f523ffeff" />

`kubectl get nodes`

<img width="636" height="162" alt="image" src="https://github.com/user-attachments/assets/b10bf851-24a3-45b7-9c83-37f2a230e840" />

`kubectl describe node <node-name>`

<img width="1487" height="657" alt="image" src="https://github.com/user-attachments/assets/a909ea86-8c60-471f-a689-6d5be51089b7" />

<img width="1357" height="907" alt="image" src="https://github.com/user-attachments/assets/1ce171c2-ef00-453d-bbfb-a316ab769096" />

<img width="835" height="252" alt="image" src="https://github.com/user-attachments/assets/dd6dd605-fdf6-4556-9417-1288b1808ab4" />

`kubectl get namespaces`

<img width="408" height="212" alt="image" src="https://github.com/user-attachments/assets/62dc3314-5016-45c8-a9af-1986e498e5aa" />

`kubectl get pods -A`

<img width="1002" height="601" alt="image" src="https://github.com/user-attachments/assets/c4d5ed4e-ea29-48aa-8774-7ab56eb37c88" />

`kubectl get pods -n kube-system`

<img width="881" height="380" alt="image" src="https://github.com/user-attachments/assets/5c95aa1b-848d-40e8-8d66-0dd15e45a014" />

---

## Task 6: Practice Cluster Lifecycle

<img width="657" height="581" alt="image" src="https://github.com/user-attachments/assets/a6dba0d9-0436-495c-9116-3556386fb437" />

<img width="808" height="837" alt="image" src="https://github.com/user-attachments/assets/33c0ca05-7fb9-4ded-ae16-f889e4765581" />







