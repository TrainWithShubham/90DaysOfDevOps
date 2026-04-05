# Day 29 – Docker Basics

## Task 1: What is Docker?

### What is a Container?

A **container** is a lightweight, isolated environment that packages an application along with all its dependencies, libraries, and configuration files. This ensures the app runs consistently regardless of where it's deployed — your laptop, a server, or the cloud.

Containers solve the classic *"it works on my machine"* problem by bundling everything the app needs into a single portable unit.

---

### Containers vs Virtual Machines

| Feature | Virtual Machine (VM) | Docker Container |
|---|---|---|
| Isolation | Full OS per VM | Shares host OS kernel |
| Startup time | Minutes | Seconds |
| Resource usage | Heavy (CPU/RAM per VM) | Lightweight |
| Requires hypervisor? | Yes (e.g. VMware, Hyper-V) | No |
| Portability | Lower | High |

**Key difference:** VMs need a **hypervisor** that allocates dedicated CPU, RAM, and storage to each virtual machine — this leads to high resource utilisation. Docker containers share the host OS kernel, skipping the hypervisor entirely, making them much faster and more efficient.

---

### Docker Architecture

- **Client** — the CLI you type commands into (`docker run`)
- **Daemon** — background service that does the actual work
- **Images** — blueprints for containers
- **Containers** — running instances of an image
- **Registry** — Docker Hub, where images are stored and pulled from

## Task 2: Install Docker & Run hello-world

### Verify Installation
```powershell
docker --version
docker info
```

### Run hello-world
```powershell
docker run hello-world
```

**What happened behind the scenes:**
1. Docker client contacted the Docker daemon
2. Daemon checked locally — image `hello-world` not found
3. Daemon pulled the image from Docker Hub
4. Daemon created a new container from the image
5. Container ran and streamed output back to the terminal

---

## Task 3: Run Real Containers

### Run Nginx (with port mapping)
```powershell
# Detached mode, port mapped, custom name
docker run -d -p 8080:80 --name my-nginx nginx
```
Access in browser: `http://localhost:8080`

### Run Ubuntu in Interactive Mode
```powershell
docker run -it ubuntu bash
```
Explore inside the container:
```bash
ls
cat /etc/os-release
whoami
exit
```

### List Running Containers
```powershell
docker ps
```

### List All Containers (including stopped)
```powershell
docker ps -a
```

### Stop and Remove a Container
```powershell
docker stop my-nginx
docker rm my-nginx
```

---

## Task 4: Explore Docker Features

### Detached Mode
```powershell
docker run -d nginx
```
Runs the container in the background — terminal is free immediately. Without `-d`, the terminal is attached to the container's output.

### Custom Name + Port Mapping
```powershell
docker run -d -p 9090:80 --name webserver nginx
```

### Check Logs
```powershell
docker logs webserver
docker logs -f webserver   # Follow live logs
```

### Execute Command Inside Running Container
```powershell
docker exec -it webserver bash
```

---

## Commands Cheat Sheet

| Command | Description |
|---|---|
| `docker run <image>` | Create and start a container |
| `docker run -d` | Detached (background) mode |
| `docker run -it` | Interactive + TTY mode |
| `docker run -p host:container` | Port mapping |
| `docker run --name <n>` | Custom container name |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers |
| `docker stop <name/id>` | Stop a container |
| `docker rm <name/id>` | Remove a container |
| `docker logs <name/id>` | View container logs |
| `docker exec -it <n> bash` | Shell into container |
| `docker images` | List local images |
| `docker pull <image>` | Pull image from registry |


---

*Day 29 of #90DaysOfDevOps | #DevOpsKaJosh | #TrainWithShubham*