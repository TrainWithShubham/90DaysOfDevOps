# Docker Basics - Challenge Tasks

## Task 1: What is Docker?

### What is Docker?

Docker is a platform used to **build, package, and run applications inside containers**.  
It helps developers make sure their application works the same way on any machine such as a laptop, server, or cloud.

Docker packages the application along with all its dependencies, libraries, and configurations into a **container**.

---

# 1. What is a Container?

A **container** is a lightweight environment that contains everything needed to run an application.

It includes:
- Application code
- Runtime
- Libraries
- System tools
- Dependencies

Containers run on the **host operating system** but remain **isolated from other containers**.

### Why Do We Need Containers?

Containers solve several common problems in software development.

**1. Consistency**

Applications run the same everywhere.

Example:

Developer Laptop → Testing Server → Production Server

Without containers, applications may fail due to:
- Different OS
- Different library versions
- Missing dependencies

Containers remove these problems.

**2. Fast Deployment**

Containers start in seconds because they share the host operating system.

**3. Isolation**

Each container runs independently.  
If one container crashes, other containers are not affected.

**4. Easy Scaling**

We can easily run multiple containers of the same application.

Example:

1 container → 10 containers → 100 containers

---

# 2. Containers vs Virtual Machines

| Feature | Containers | Virtual Machines |
|-------|------------|----------------|
| OS | Share host OS | Each VM has its own OS |
| Size | Small (MBs) | Large (GBs) |
| Startup Time | Seconds | Minutes |
| Performance | Faster | Slower |
| Resource Usage | Low | High |

### Virtual Machine Architecture

```
Hardware
   │
Hypervisor
   │
Guest OS
   │
Application
```

### Container Architecture

```
Hardware
   │
Host OS
   │
Docker Engine
   │
Containers
   │
Applications
```

---

# 3. Docker Architecture

Docker uses a **client-server architecture**.

Main components:

### 1. Docker Client

Docker Client is the tool used by users to interact with Docker.

Example commands:

```
docker build
docker pull
docker run
docker push
```

The client sends commands to the **Docker Daemon**.

---

### 2. Docker Daemon (dockerd)

Docker daemon is the main engine that runs Docker.

It is responsible for:

- Building Docker images
- Running containers
- Managing networks
- Managing volumes

---

### 3. Docker Images

A **Docker Image** is a template used to create containers.

It contains:
- Application code
- Dependencies
- Libraries
- Runtime environment

Example images:

- nginx
- python
- node

---

### 4. Docker Containers

A **container** is a running instance of a Docker image.

Example:

```
Docker Image → Docker Container
nginx image → running nginx container
```

You can run multiple containers from the same image.

---

### 5. Docker Registry

A **Docker Registry** is a place where Docker images are stored.

Examples:

- Docker Hub
- AWS Elastic Container Registry (ECR)
- Google Container Registry (GCR)

Example command:

```
docker pull nginx
```

This command downloads the nginx image from **Docker Hub**.

---

# Docker Architecture Workflow

Simple workflow of Docker:

```
Developer
   │
   │ docker run nginx
   ▼
Docker Client
   ▼
Docker Daemon
   ▼
Docker Registry (Docker Hub)
   ▼
Docker Image
   ▼
Docker Container (Running Application)
```

---

# Conclusion

Docker helps developers package applications into containers so they can run **consistently across different environments**.  
Containers are lightweight, fast, and easier to manage compared to traditional virtual machines.






# Task 2: Install Docker

In this task, we install Docker, verify the installation, and run the **hello-world container** to check if Docker is working correctly.

---

# 1. Install Docker

Docker can be installed on Linux, Windows, or Mac.  
Below are the steps for **Ubuntu/Linux (commonly used in DevOps and cloud servers like AWS EC2).**

### Step 1: Update the system

```bash
sudo apt update
```

### Step 2: Install Docker

```bash
sudo apt install docker.io -y
```

### Step 3: Start Docker service

```bash
sudo systemctl start docker
```

### Step 4: Enable Docker service

```bash
sudo systemctl enable docker
```

---

# 2. Verify Docker Installation

Check if Docker is installed correctly.

```bash
docker --version
```

Example Output:

```
Docker version 28.2.2, build xxxxxxx
```

You can also check the Docker service status.

```bash
sudo systemctl status docker
```

If Docker is running, it will show:

```
active (running)
```

---

# 3. Run the hello-world Container

Run the following command:

```bash
sudo docker run hello-world
```

Docker will perform these steps automatically:

1. Docker client contacts the Docker daemon
2. Docker daemon pulls the **hello-world image** from Docker Hub
3. Docker creates a new container
4. The container runs and prints a message

---

# 4. Output of hello-world Container

Example output:

```
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
1. The Docker client contacted the Docker daemon.
2. The Docker daemon pulled the "hello-world" image from Docker Hub.
3. The Docker daemon created a new container from that image.
4. The Docker daemon ran the container which prints this message.
```

---

# What Just Happened?

When we ran the command:

```bash
docker run hello-world
```

Docker performed the following actions:

1. Checked if the **hello-world image** exists locally.
2. If not found, it **downloaded the image from Docker Hub**.
3. Created a **container from that image**.
4. Ran the container.
5. The container printed a confirmation message.

---

# Conclusion

Running the **hello-world container** confirms that:

- Docker is installed successfully
- Docker daemon is running
- Docker can pull images from Docker Hub
- Docker can create and run containerss





# Task 3: Run Real Containers

In this task, we will run real Docker containers and learn basic container management commands.

---

# 1. Run an Nginx Container

Nginx is a popular web server. We will run it inside a Docker container.

### Command

```bash
docker run -d -p 8080:80 nginx
```

### Explanation

- `docker run` → Creates and starts a container
- `-d` → Runs container in detached mode (background)
- `-p 8080:80` → Maps port 8080 (host) to port 80 (container)
- `nginx` → Docker image name

### Access in Browser

Open your browser and visit:

```
http://localhost:8080
```

You should see the **Nginx welcome page**, which means the container is running successfully.

---

# 2. Run an Ubuntu Container in Interactive Mode

We can run an Ubuntu container and use it like a small Linux machine.

### Command

```bash
docker run -it ubuntu
```

### Explanation

- `-i` → Interactive mode
- `-t` → Allocates a terminal
- `ubuntu` → Ubuntu Docker image

Now you will enter inside the container terminal.

Example commands to try inside the container:

```bash
ls
pwd
whoami
apt update
```

To exit the container:

```bash
exit
```

---

# 3. List All Running Containers

To see running containers:

```bash
docker ps
```

Example output:

```
CONTAINER ID   IMAGE   COMMAND   STATUS   PORTS   NAMES
```

This shows containers that are currently running.

---

# 4. List All Containers (Including Stopped Ones)

To see all containers:

```bash
docker ps -a
```

This command shows:

- Running containers
- Stopped containers
- Container IDs
- Container names
- Status

---

# 5. Stop a Container

First check running containers:

```bash
docker ps
```

Stop the container using its **Container ID**:

```bash
docker stop <container_id>
```

Example:

```bash
docker stop 8a7b2c3d4e
```

---

# 6. Remove a Container

To delete a container:

```bash
docker rm <container_id>
```

Example:

```bash
docker rm 8a7b2c3d4e
```

---

# Summary of Commands

| Command | Description |
|------|------|
| `docker run -d -p 8080:80 nginx` | Run Nginx container |
| `docker run -it ubuntu` | Run Ubuntu container interactively |
| `docker ps` | Show running containers |
| `docker ps -a` | Show all containers |
| `docker stop <id>` | Stop container |
| `docker rm <id>` | Remove container |

---

# Conclusion

In this task we learned how to:

- Run an **Nginx web server container**
- Use an **Ubuntu container as a mini Linux environment**
- View running and stopped containers
- Stop and remove containers

These are the basic commands used to manage Docker containers in real DevOps workflows.



# Task 4: Explore Docker Containers

In this task, we explore some important Docker commands used in real DevOps workflows such as running containers in detached mode, naming containers, port mapping, checking logs, and executing commands inside running containers.

---

# 1. Run a Container in Detached Mode

A container normally runs in the foreground. If we want it to run in the **background**, we use **detached mode**.

### Command

```bash
docker run -d nginx
```

### Explanation

- `-d` → Runs the container in the background (detached mode)
- `nginx` → Docker image

### What is Different?

When running in **detached mode**:

- The terminal is free to use
- The container runs in the background
- You only see the **container ID**

Example output:

```
3f8d2a1c4e5b...
```

---

# 2. Give a Container a Custom Name

Docker automatically assigns random names to containers, but we can set our own name.

### Command

```bash
docker run -d --name my-nginx nginx
```

### Explanation

- `--name my-nginx` → Assigns a custom container name

Now the container name will be **my-nginx** instead of a random name.

---

# 3. Map a Port from Container to Host

Port mapping allows us to access applications running inside containers from our local machine.

### Command

```bash
docker run -d -p 8080:80 nginx
```

### Explanation

- `-p` → Port mapping
- `8080` → Host port
- `80` → Container port

Now you can access the Nginx server in your browser:

```
http://localhost:8080
```

---

# 4. Check Logs of a Running Container

Logs help us see what is happening inside a container.

### Command

```bash
docker logs <container_name_or_id>
```

Example:

```bash
docker logs my-nginx
```

This shows output generated by the container.

---

# 5. Run a Command Inside a Running Container

We can execute commands inside a running container using `docker exec`.

### Command

```bash
docker exec -it my-nginx /bin/bash
```

### Explanation

- `exec` → Run command inside container
- `-it` → Interactive terminal
- `/bin/bash` → Start bash shell

Now you are inside the container and can run Linux commands like:

```bash
ls
pwd
whoami
```

To exit:

```bash
exit
```

---

# Summary of Commands

| Command | Description |
|------|------|
| `docker run -d nginx` | Run container in detached mode |
| `docker run -d --name my-nginx nginx` | Run container with custom name |
| `docker run -d -p 8080:80 nginx` | Map container port to host |
| `docker logs <container>` | View container logs |
| `docker exec -it <container> /bin/bash` | Run command inside container |

---

# Conclusion

In this task we learned how to:

- Run containers in **detached mode**
- Assign **custom names** to containers
- **Map ports** between host and container
- View **container logs**
- Execute commands **inside running containers**

These commands are essential for managing containers in Docker.