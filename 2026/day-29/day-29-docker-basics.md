90 Days of DevOps
Day 29
Introduction to Docker
Containers, Architecture & First Deployments
#DevOpsKaJosh  |  #TrainWithShubham
Task 1: What is Docker?

What is a Container?
A container is a lightweight, standalone, executable package that includes everything needed to run a piece of software: the code, runtime, system tools, libraries, and settings. Containers isolate software from its environment and ensure it works uniformly across different stages of deployment.

Why do we need containers?
•	Eliminate the "it works on my machine" problem
•	Pack dependencies alongside the app — no version conflicts
•	Spin up or tear down environments in seconds
•	Run dozens of isolated apps on one host without full OS overhead
•	Enable consistent CI/CD pipelines from dev to production

Containers vs Virtual Machines
Feature	Container	Virtual Machine
OS	Shares host OS kernel	Full guest OS per VM
Startup time	Milliseconds	Minutes
Size	Megabytes	Gigabytes
Isolation	Process-level	Hardware-level (hypervisor)
Performance	Near-native	Slight overhead
Portability	High — runs anywhere Docker runs	Lower — image tied to hypervisor
Use case	Microservices, CI/CD, cloud-native	Full OS isolation, legacy apps

Docker Architecture
Docker uses a client-server architecture. Here is how each component fits together:

•	Docker Client — The CLI tool you interact with (docker run, docker ps, etc.). Sends commands to the Docker daemon via REST API.
•	Docker Daemon (dockerd) — The background service that actually manages images, containers, networks, and volumes. Listens for API requests.
•	Docker Images — Read-only templates used to create containers. Built using a Dockerfile and stored locally or in a registry.
•	Docker Containers — Running instances of images. Each container is isolated with its own filesystem, networking, and process space.
•	Docker Registry — A storage and distribution system for images. Docker Hub is the default public registry. Private registries (ECR, GCR, Harbor) are also common.

Flow: You (Docker Client) → docker run nginx → Docker Daemon → checks local images → pulls from Docker Hub → creates & starts Container

Task 2: Install Docker

Installation Steps
1.	Update package index and install prerequisites
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

2.	Add Docker's official GPG key and repository
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

3.	Install Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

4.	Verify the installation
docker --version
docker info

Run Hello World Container
docker run hello-world

What happens under the hood when you run this command:
•	Docker Client sends the request to Docker Daemon
•	Daemon checks if the hello-world image exists locally — it doesn't
•	Daemon pulls hello-world from Docker Hub (public registry)
•	Daemon creates a container from the image
•	Container runs, prints the welcome message, then exits

Task 3: Run Real Containers

1. Run Nginx Web Server
docker run -d -p 8080:80 --name my-nginx nginx
Open your browser and navigate to http://localhost:8080 — you should see the Nginx welcome page.

2. Run Ubuntu in Interactive Mode
docker run -it --name ubuntu-explore ubuntu bash
You are now inside a full Ubuntu container. Explore it like a mini Linux machine:
cat /etc/os-release   # Check the OS version
ls /                  # Browse the filesystem
apt-get update        # Update package lists
exit                  # Leave the container

3. List Running Containers
docker ps

4. List ALL Containers (including stopped)
docker ps -a

5. Stop and Remove a Container
docker stop my-nginx
docker rm my-nginx

Task 4: Explore Docker Features

1. Detached Mode
Detached mode (-d) runs the container in the background. Your terminal is immediately freed up — you don't see live output. The container keeps running even after you close the terminal session.
docker run -d nginx

2. Custom Container Name
docker run -d --name webserver nginx
Naming containers makes them easier to reference instead of using long container IDs.

3. Port Mapping
Format: -p <host_port>:<container_port>
docker run -d -p 9090:80 --name port-demo nginx
Container port 80 (Nginx inside) is mapped to host port 9090. Access it at http://localhost:9090.

4. Check Logs
docker logs webserver
docker logs -f webserver   # Follow / stream live logs

5. Execute a Command Inside a Running Container
docker exec -it webserver bash
docker exec webserver ls /etc/nginx   # Run a single command

Docker Command Quick Reference

Command	Description
docker run	Create and start a container from an image
docker run -d	Run container in detached (background) mode
docker run -it	Run container in interactive mode with terminal
docker run -p h:c	Map host port h to container port c
docker run --name	Assign a custom name to the container
docker ps	List currently running containers
docker ps -a	List all containers (running + stopped)
docker stop <name>	Gracefully stop a running container
docker rm <name>	Remove a stopped container
docker logs <name>	View output logs of a container
docker logs -f	Stream/follow logs in real time
docker exec -it	Open interactive shell inside running container
docker images	List locally available images
docker pull <image>	Download image from registry without running
docker rmi <image>	Remove a local image

Why This Matters for DevOps

Docker is the foundation of modern software deployment. Here is why every DevOps engineer must know it:

•	CI/CD Pipelines — Every pipeline stage (build, test, deploy) runs inside containers for consistency
•	Kubernetes — K8s orchestrates Docker containers at scale; you cannot use K8s without understanding Docker
•	Microservices — Each service runs in its own container, independently deployable and scalable
•	Environment Parity — Dev, staging, and prod environments are identical because they use the same image
•	Infrastructure as Code — Dockerfiles define infrastructure declaratively, version-controlled alongside code

Today's Key Takeaway
Containers package your app and its dependencies into a portable, isolated unit. Docker makes creating, running, and managing containers simple. Every modern deployment — from a startup to Netflix — relies on this technology.

Day 29 Complete 
#90DaysOfDevOps  |  #DevOpsKaJosh  |  #TrainWithShubham
Happy Learning!  —  TrainWithShubham
