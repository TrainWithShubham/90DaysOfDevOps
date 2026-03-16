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


