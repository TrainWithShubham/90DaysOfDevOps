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
<img width="1170" height="664" alt="image" src="https://github.com/user-attachments/assets/31c6a47d-737f-4a18-b370-f3d8fe6856c9" />

## Task 5: Explore Your Cluster

<img width="1170" height="664" alt="image" src="https://github.com/user-attachments/assets/87962f5c-3452-4709-af6a-dc8e21c3454b" />
<img width="1219" height="602" alt="image" src="https://github.com/user-attachments/assets/72202555-04a7-4115-8b74-747e9753c51d" />
<img width="1211" height="666" alt="image" src="https://github.com/user-attachments/assets/4c02bc21-6872-4090-b336-295d08db36cd" />
<img width="1216" height="669" alt="image" src="https://github.com/user-attachments/assets/4e020ec3-53c1-42cf-bd54-630bbbe0bbb3" />
<img width="1189" height="664" alt="image" src="https://github.com/user-attachments/assets/7daf9fdd-5375-45de-b13e-ab5d8c3275dd" />
<img width="1225" height="666" alt="image" src="https://github.com/user-attachments/assets/0725e674-31e8-4ce6-b60c-0a370488ef6e" />
<img width="1215" height="641" alt="image" src="https://github.com/user-attachments/assets/a04c19c1-2581-49a9-a527-2129daee3307" />


## What I learn
- Architecture Diagram
- History of Kubernetes











