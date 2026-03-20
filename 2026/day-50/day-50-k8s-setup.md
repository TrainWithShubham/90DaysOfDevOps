# Kubernetes Architecture and Cluster Setup

## Task 1: Recall the Kubernetes Story

### Why was Kubernetes created? What problem does it solve that Docker alone cannot?

**Answer:**

Kubernetes was created to manage containerized applications at scale.

Earlier, teams manually duplicated applications across multiple servers to handle increasing traffic. This approach became difficult to manage, error-prone, and inefficient.

Docker provides **containerization**, but it does not handle:
- Automatic scaling  
- Load balancing  
- Self-healing (restarting failed containers)  
- Deployment management  

Kubernetes solves these problems by providing:
- **Auto-scaling**
- **Self-healing**
- **Service discovery**
- **Rolling updates and rollbacks**

---

### Who created Kubernetes and what was it inspired by?

**Answer:**

Kubernetes was created by **Google**.

It was inspired by Google’s internal system called **Borg**, which was used to manage containers at a massive scale.

---

### What does the name "Kubernetes" mean?

**Answer:**

"Kubernetes" means **“helmsman” or “ship pilot”**, referring to someone who steers and manages a ship.

---

## Task 2: Kubernetes Architecture Diagram

```plaintext
                 +----------------------+
                 |    Control Plane     |
                 |   (Master Node)      |
                 +----------------------+
                 |  API Server          |
                 |  etcd (database)     |
                 |  Scheduler           |
                 |  Controller Manager  |
                 +----------+-----------+
                            |
                            | (kubectl / API calls)
                            |
    -----------------------------------------------------
    |                        |                         |
+----------------+  +----------------+  +----------------+
|  Worker Node 1 |  |  Worker Node 2 |  |  Worker Node N |
+----------------+  +----------------+  +----------------+
| kubelet        |  | kubelet        |  | kubelet        |
| kube-proxy     |  | kube-proxy     |  | kube-proxy     |
| Container Run. |  | Container Run. |  | Container Run. |
| (Pods)         |  | (Pods)         |  | (Pods)         |
+----------------+  +----------------+  +----------------+
```

---

## What happens when you run `kubectl apply -f pod.yaml`?

**Answer:**

The process starts from your local machine. The `kubectl` tool reads the YAML file and converts it into a JSON request. It then sends this request to the Kubernetes **API Server**, which acts as the entry point of the cluster.

Once the request reaches the API Server, it performs **authentication and authorization** to verify permissions. Then it validates the YAML configuration.

If everything is valid, the API Server stores the **desired state** of the Pod in **etcd**, the cluster’s database. At this point, Kubernetes knows that a Pod should exist.

The **Scheduler** continuously watches for Pods without assigned nodes. It selects the best worker node based on available resources and constraints, then updates the API Server with this decision.

The **kubelet** on the selected worker node detects the assigned Pod, retrieves its specification from the API Server, and starts the process of running it.

The kubelet communicates with the **container runtime** (such as Docker or containerd), which pulls the required image and starts the container.

Meanwhile, **kube-proxy** configures networking so that the Pod can communicate with other services.

Finally, the Pod enters the **Running** state, and the application becomes available.

---

## What happens if the API Server goes down?

**Answer:**

The API Server is the central control point of Kubernetes. If it goes down, the cluster becomes **unmanageable**, but not immediately unavailable.

You cannot run any `kubectl` commands because all communication goes through the API Server. No new Pods can be created, and no updates or scaling operations can occur.

However, **already running Pods continue to run normally**, because worker nodes and kubelet operate independently once containers are started.

Over time, issues arise:
- Failed Pods are not recreated  
- No scheduling of new Pods  
- No state reconciliation  

So, the system keeps running but loses its ability to **self-heal and adapt**.

---

## What happens if a Worker Node goes down?

**Answer:**

When a worker node goes down, the API Server detects that it is no longer responding and marks it as **NotReady**.
All Pods running on that node become unavailable. This creates a mismatch between the **desired state** and the **actual state**.
The **Controller Manager** detects this mismatch and initiates corrective action by creating replacement Pods.
The **Scheduler** assigns these new Pods to healthy worker nodes.
The kubelet on those nodes starts the containers using the container runtime.
This process is known as **self-healing**.


---

## Task 3: Install kubectl   
kubectl is the CLI tool you will use to talk to your Kubernetes cluster.

<img width="1627" height="363" alt="image" src="https://github.com/user-attachments/assets/520cb14c-7a64-4ddd-8078-8f2e667f14ef" />

## Task 4: Set Up Your Local Cluster
<img width="1047" height="336" alt="image" src="https://github.com/user-attachments/assets/df621fc3-fa2b-4aa7-bd3b-e728803c2280" />
<img width="1257" height="654" alt="image" src="https://github.com/user-attachments/assets/2b5fe3c2-a4f2-4b9f-be76-05c3ca9b7fe3" />



## Task 5: Explore Your Cluster
<img width="1184" height="387" alt="image" src="https://github.com/user-attachments/assets/d64a0874-6a5c-44bc-bc05-2e11a5b39e0e" />
<img width="1354" height="645" alt="image" src="https://github.com/user-attachments/assets/9d08fef3-f8dc-4300-8a09-7a4cf0ef691d" />
<img width="1643" height="640" alt="image" src="https://github.com/user-attachments/assets/d4327a99-8aef-43c4-847b-cbde8ade5cd3" />
<img width="1226" height="617" alt="image" src="https://github.com/user-attachments/assets/a40491e1-eebe-41eb-9263-e6ee68cd3471" />

## Task 6: Practice Cluster Lifecycle
<img width="1093" height="445" alt="image" src="https://github.com/user-attachments/assets/a0f770e1-01c7-4b58-8598-8e7091ca9904" />
<img width="951" height="484" alt="image" src="https://github.com/user-attachments/assets/cab21d8e-699d-4520-ba23-58724cb9b129" />

What is a kubeconfig? Where is it stored on your machine?

Ans: A kubeconfig file is a configuration file used by kubectl (the Kubernetes CLI) to connect to a Kubernetes cluster.  
It contains:
   - Cluster details → API server endpoint (URL)
   - User credentials → certificates, tokens, etc.
   - Context → which cluster + user combination to use

By default, kubeconfig is stored at:

  ``` ~/.kube/config ```  
Explanation:  
```~``` → your home directory  
```.kube``` → hidden folder  
```config``` → the kubeconfig file  
## What I learn
- Architecture Diagram
- History of Kubernetes
- Basic Command of Kubernetes











