# Day 29 – Introduction to Dockers
---

# Task 1: What is Docker?

## 1. What is a Container and Why Do We Need Them?

### What is a Container?

A **container** is a lightweight, standalone, executable software package that includes:

* Application code
* Runtime environment
* System tools
* Libraries
* Dependencies
* Configuration

It runs in isolation using the host OS kernel via **OS-level virtualization**.

### Why Do We Need Containers?

Before containers:

* Applications worked on one machine but failed on another.
* Dependency conflicts were common.
* Environment inconsistencies broke deployments.

Containers solve:

| Problem                     | How Containers Help           |
| --------------------------- | ----------------------------- |
| “Works on my machine” issue | Package entire environment    |
| Dependency conflicts        | Isolated runtime environments |
| Slow deployments            | Lightweight startup           |
| Resource waste              | Share host OS kernel          |

They enable:

* Consistent dev → test → prod environments
* Microservices architecture
* CI/CD automation
* Cloud-native deployments

---

## 2. Containers vs Virtual Machines — what's the real difference?

| Feature             | Containers        | Virtual Machines    |
| ------------------- | ----------------- | ------------------- |
| Virtualization Type | OS-level          | Hardware-level      |
| OS                  | Share host kernel | Each VM has full OS |
| Size                | MBs               | GBs                 |
| Startup Time        | Seconds           | Minutes             |
| Resource Usage      | Lightweight       | Heavy               |
| Isolation           | Process-level     | Full machine-level  |

### Architecture Difference

|**Virtual Machine:**|**Container:**|
|--------------------|--------------|
|Hardware|Hardware|
|   ↓|   ↓|
|Hypervisor|  Host OS|
|   ↓|   ↓|
|Guest OS|Container Runtime (Docker)|
|   ↓|   ↓|
|Application| Application|

-----
### Key Insight:

Containers virtualize the **OS**, VMs virtualize the **hardware**.

---

## 3. Docker Architecture

Docker follows a **client-server architecture**.

### Core Components

### 1 Docker Client

* CLI (`docker` command)
* Sends commands to Docker Daemon

Example:

```
docker run nginx
```

---

### 2 Docker Daemon (`dockerd`)

* Background service
* Builds images
* Runs containers
* Manages networks and volumes

---

### 3 Docker Images

* Read-only templates
* Blueprint for containers
* Built from Dockerfile

---

### 4 Docker Containers

* Running instances of images
* Writable layer added on top

---

### 5 Docker Registry

* Stores images
* Default: Docker Hub
* Can be private (ECR, GCR, etc.)

---

## Docker Architecture (In My Words)

When you run:

```
docker run nginx
```

Here’s what happens:

1. Docker Client sends request to Docker Daemon.
2. Daemon checks if nginx image exists locally.
3. If not, it pulls image from Docker Hub (registry).
4. Daemon creates container from image.
5. Container runs as isolated process on host OS.

### Visual Flow

```
[User]
   ↓
Docker CLI
   ↓
Docker Daemon
   ↓
Image (local or pulled from registry)
   ↓
Container (running process)
```

Or conceptually:

```
Registry → Image → Container → Running Application
```

---

# Task 2: Install Docker

*(Commands for Ubuntu/Linux.)*

## Install Docker

```bash
sudo apt update
sudo apt install docker.io -y
```

Enable & start:

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

---

## Verify Installation

```bash
docker --version
```

You should see:

```
Docker version XX.X.X
```

---

## Run Hello World

```bash
docker run hello-world
```

### What Just Happened?

1. Client contacted daemon.
2. Image not found locally.
3. Pulled from Docker Hub.
4. Created container.
5. Executed hello-world binary.
6. Printed confirmation message.
7. Container exited.

This demonstrates:

* Image pull
* Container creation
* Execution lifecycle

---

# Task 3: Run Real Containers

---

## 1 Run an Nginx container and access it in your browser.

```bash
docker run -d -p 8080:80 nginx
```

Explanation:

* `-d` → detached mode
* `-p 8080:80` → map host port 8080 to container port 80

Open browser:

```
http://localhost:8080
```

You should see Nginx welcome page.

---

## 2 Run an Ubuntu container in interactive mode — explore it like a mini Linux machine.

```bash
docker run -it ubuntu
```

Flags:

* `-i` → interactive
* `-t` → pseudo-TTY terminal

You are now inside a minimal Linux environment.

Try:

```bash
ls
pwd
apt update
whoami
```

Exit:

```bash
exit
```

Container stops.

---

## 3 List All Running Containers

```bash
docker ps
```

---

## 4 List all containers (including stopped ones).

```bash
docker ps -a
```

---

## 5 Stop a Container

```bash
docker stop <container_id>
```

---

## 6 Remove a Container

```bash
docker rm <container_id>
```

---

# Task 4: Explore Advanced Options

---

## 1 Run a container in detached mode — what's different?

```bash
docker run -d nginx
```

Difference:

* Runs in background
* Terminal is free immediately
* Container keeps running

Without `-d`, logs stream in terminal.

---

## 2 Give a container a custom name.

```bash
docker run -d --name my-nginx nginx
```

Now you can reference it as:

```bash
docker stop my-nginx
```

Instead of container ID.

---

## 3 Map a port from the container to your host.

```bash
docker run -d -p 3000:80 nginx
```

Meaning:

```
Host:3000 → Container:80
```

Access:

```
http://localhost:3000
```

---

## 4 Check logs of a running container.

```bash
docker logs my-nginx
```

Add follow mode:

```bash
docker logs -f my-nginx
```

---

## 5 Run Command Inside Running Container.

```bash
docker exec -it my-nginx /bin/bash
```

This attaches a shell inside the running container.

You can inspect:

```bash
ls /usr/share/nginx/html
```

Exit:

```bash
exit
```

Container continues running.

---
# Final Mental Model

Think in layers:

```
Dockerfile → Image → Container → Running Process
```

And system flow:

```
Developer → Docker CLI → Docker Daemon → Registry → Container → Application
```




