# Day 30 – Docker Images & Container Lifecycle

## Task 1: Docker Images

### 1. Pull Images from Docker Hub

First, download the required images from Docker Hub.

Command:

docker pull nginx  
docker pull ubuntu  
docker pull alpine  

These commands download the images to your local machine.

After pulling, Docker stores these images locally so they can be used to create containers.

---

### 2. List All Images on Your Machine

To see all downloaded images, run:

docker images

Example output:

REPOSITORY    TAG       IMAGE ID       CREATED        SIZE  
nginx         latest    xxxxxxxxxxxx   x days ago     ~190MB  
ubuntu        latest    xxxxxxxxxxxx   x days ago     ~77MB  
alpine        latest    xxxxxxxxxxxx   x days ago     ~7MB  

This command shows:

- Repository name
- Tag (version)
- Image ID
- Creation time
- Image size

---

### 3. Compare Ubuntu vs Alpine Image

Ubuntu Image:
- Size is larger
- Contains many default packages
- Good for general-purpose environments

Alpine Image:
- Very lightweight Linux distribution
- Minimal packages included
- Designed for containers

Why Alpine is smaller?

Alpine uses a lightweight system and minimal dependencies, which reduces the image size significantly.

Example sizes:

Ubuntu → ~77MB  
Alpine → ~7MB  

This makes Alpine faster to download and start.

---

### 4. Inspect a Docker Image

You can inspect an image to see detailed information.

Command:

docker inspect nginx

This command shows:

- Image ID
- Architecture
- OS type
- Environment variables
- Layers
- Configuration
- Creation time

It returns detailed JSON information about the image.

---

### 5. Remove an Image

If you no longer need an image, you can remove it.

Command:

docker rmi image_name

Example:

docker rmi ubuntu

Important:
You cannot remove an image if a container is currently using it.

In that case, stop and remove the container first.

---

### Summary

In this task you learned:

- How to pull images from Docker Hub
- How to list images on your system
- The difference between Ubuntu and Alpine images
- How to inspect image details
- How to remove unused images




## Task 2: Image Layers

### 1. View Image Layer History

Docker images are built in **multiple layers**.  
You can see these layers using the following command:

docker image history nginx


This command shows the **history of layers used to build the image**.

Each row represents **one image layer** created during the image build process.

---

### 2. Understanding Layer Sizes

You may notice that:

- Some layers show **actual sizes** (for example 40MB).
- Some layers show **0B**.

Reason:

Layers with sizes contain **real filesystem changes** such as:

- Installing packages
- Copying files
- Adding dependencies

Layers with **0B** usually represent **metadata changes**, such as:

- CMD instruction
- WORKDIR instruction
- EXPOSE instruction

These instructions modify configuration but **do not add files**, so they show **0B**.

---

### 3. What Are Docker Layers?

A **Docker layer** is a read-only filesystem change created by each instruction in a Dockerfile.

For example:

FROM ubuntu
RUN apt-get update
RUN apt-get install nginx
COPY . /app

Each instruction creates **one new layer**.

Layers are stacked on top of each other to form the final Docker image.

---

### 4. Why Docker Uses Layers

Docker uses layers for **efficiency and speed**.

Benefits of layers:

1. **Faster builds**  
   Docker reuses cached layers if nothing has changed.

2. **Smaller downloads**  
   Only changed layers need to be downloaded.

3. **Image sharing**  
   Multiple images can share the same base layers.

Example:

Two images using **ubuntu** will reuse the same base layers instead of downloading them again.

---

### Summary

In this task you learned:

- How to check image layers using `docker image history`
- Each instruction in a Dockerfile creates a **layer**
- Some layers show **0B** because they only change metadata
- Docker layers help with **caching, faster builds, and storage efficiency**




## Task 3: Container Lifecycle

In this task we will practice the **complete lifecycle of a Docker container** and observe how the container state changes.

You can check the container status anytime using:

docker ps -a

This command shows all containers and their current state.

---

## 1. Create a Container (Without Starting It)

First create a container but do not start it.

docker create --name my-nginx nginx

Now check the container state:

docker ps -a

You will see the status as:

Created

This means the container exists but is not running yet.

---

## 2. Start the Container

Start the container using:

docker start my-nginx

Check the status again:

docker ps -a

Now the container state will show:

Up (Running)

This means the container is currently running.

---

## 3. Pause the Container

Pausing a container temporarily suspends its processes.

docker pause my-nginx

Check the status:

docker ps -a

State will show:

Paused

This means the container is frozen but still exists.

---

## 4. Unpause the Container

Resume the container again.

docker unpause my-nginx

Check the status again:

docker ps -a

State will return to:

Up (Running)

---

## 5. Stop the Container

Stop the container gracefully.

docker stop my-nginx

Check the status:

docker ps -a

State will show:

Exited

This means the container has stopped.

---

## 6. Restart the Container

Restart the container.

docker restart my-nginx

Check the status again:

docker ps -a

The container will go back to:

Up (Running)

---

## 7. Kill the Container

Kill stops the container immediately without graceful shutdown.

docker kill my-nginx

Check the status:

docker ps -a

State will again show:

Exited

---

## 8. Remove the Container

Finally remove the container from your system.

docker rm my-nginx

Now check containers:

docker ps -a

The container will no longer appear in the list.

---

## Summary

In this task you practiced the full container lifecycle:

Create → Start → Pause → Unpause → Stop → Restart → Kill → Remove

You also learned how to check container states using:

docker ps -a

Understanding the container lifecycle is important when managing applications in Docker environments.




## Task 4: Working with Running Containers

In this task we will learn how to interact with a **running Docker container**.

We will run an **Nginx container** and explore different Docker commands to view logs, access the container, and inspect its details.

---

### 1. Run an Nginx Container in Detached Mode

Run the container in **detached mode** so it runs in the background.

docker run -d --name my-nginx -p 8080:80 nginx

Explanation:

- `-d` → Runs the container in background (detached mode)
- `--name my-nginx` → Assigns a name to the container
- `-p 8080:80` → Maps port 8080 on host to port 80 inside container
- `nginx` → Image used to create the container

You can verify it using:

docker ps

---

### 2. View Container Logs

To see the logs generated by the container:

docker logs my-nginx

Logs show the output produced by the containerized application.

For Nginx, logs usually show **server startup information and HTTP requests**.

---

### 3. View Real-Time Logs (Follow Mode)

To watch logs in **real time**, use the follow option.

docker logs -f my-nginx

This continuously streams logs as they are generated.

Press **Ctrl + C** to stop viewing logs.

---

### 4. Exec into the Container

You can open a shell inside the running container.

docker exec -it my-nginx /bin/bash

If bash is not available, use:

docker exec -it my-nginx /bin/sh

Now you are inside the container filesystem.

You can explore using commands like:

ls  
cd /  
cat /etc/os-release  

To exit the container shell:

exit

---

### 5. Run a Single Command Inside the Container

Instead of entering the container shell, you can run a single command.

Example:

docker exec my-nginx ls /

This will list the files in the root directory of the container.

---

### 6. Inspect the Container

Docker inspect shows detailed information about the container.

docker inspect my-nginx

This command displays information in **JSON format**.

You can find details such as:

- Container ID
- Network settings
- IP address
- Port mappings
- Mounted volumes
- Environment variables

Example fields you may notice:

NetworkSettings → Shows the container IP address  
HostConfig → Shows port mappings  
Mounts → Shows attached volumes

---

### Summary

In this task you learned how to interact with running containers:

- Run containers in **detached mode**
- View container **logs**
- Stream **real-time logs**
- Use **docker exec** to access a container
- Run commands inside a container
- Inspect container configuration and network details




## Task 5: Cleanup

In this task we will learn how to **clean up Docker resources** such as containers and images.

Cleaning unused resources helps free up **disk space** and keeps the Docker environment organized.

---

### 1. Stop All Running Containers in One Command

To stop all running containers at once:

docker stop $(docker ps -q)

Explanation:

- `docker ps -q` → Lists only the IDs of running containers
- `docker stop` → Stops those containers

This command stops **all currently running containers**.

---

### 2. Remove All Stopped Containers

Once containers are stopped, they remain on the system in **Exited state**.

To remove all stopped containers:

docker container prune

Docker will ask for confirmation before deleting them.

This command removes **all containers that are not running**.

---

### 3. Remove Unused Images

To remove unused Docker images:

docker image prune

This removes **dangling images** (images not used by any container).

To remove **all unused images**, run:

docker image prune -a

This helps free significant disk space.

---

### 4. Check Docker Disk Usage

To see how much disk space Docker is using:

docker system df


This command helps you understand:

- Disk space used by **images**
- Space used by **containers**
- Storage used by **volumes**
- Build cache usage

---

### Summary

In this task you learned how to:

- Stop all running containers at once
- Remove stopped containers
- Delete unused Docker images
- Check Docker disk usage

Regular cleanup helps keep Docker environments **efficient and clutter-free**.








