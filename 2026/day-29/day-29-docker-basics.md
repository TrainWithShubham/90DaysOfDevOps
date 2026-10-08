What is Docker?

Docker is a containerization platform used to package applications with all dependencies together so the application runs the same everywhere.

For example, sometimes a Java app works on my laptop but fails on another machine because Java version or dependencies are different. Docker solves this issue by packaging everything together inside a container.

What is a Container?

A container is a lightweight isolated environment where an application runs.

It contains:

Application code
Required libraries
Dependencies
Runtime

Containers are fast because they share the host operating system kernel instead of installing a full OS.

Why Do We Need Containers?

Before Docker, developers faced many issues like:

Application works on developer machine but not in production
Dependency conflicts
Environment mismatch

Docker helps by creating the same environment everywhere.

Example:
If I run a Python app in Docker on Windows, the same container can run on Linux server without changing anything.

Containers vs Virtual Machines

The main difference is:

Virtual Machine contains:

Full operating system
Application
Libraries

Container contains only:

Application
Dependencies

Containers share the host OS kernel, so they are lightweight and start very fast compared to VMs.

VMs use more RAM and storage, while containers are smaller and faster.

Docker Architecture

Docker architecture mainly has 4 parts:

Docker Client

This is where we type commands like:

docker run nginx
Docker Daemon

Docker daemon runs in the background and manages:

Images
Containers
Networks
Volumes
Docker Images

Docker image is like a template.

Example:

Ubuntu image
Nginx image
Python image
Docker Container

Container is a running instance of an image.

Example:

docker run nginx

This creates and starts an Nginx container.

Docker Registry

Docker Hub is a registry where Docker images are stored.

We can:

Pull images
Push images
My First Docker Container

To test Docker installation:

docker run hello-world

What happens:

Docker checks local machine for image
If image not found, it downloads from Docker Hub
Docker creates container
Container runs and displays output
Running Nginx Container
docker run -d -p 8080:80 nginx

Explanation:

-d means detached mode
-p means port mapping
8080 is host port
80 is container port

Then I can access Nginx in browser using:

http://localhost:8080
Interactive Ubuntu Container
docker run -it ubuntu

This opens Ubuntu container like a mini Linux machine.

I can run commands like:

ls
pwd
apt update

Exit:

exit
Useful Docker Commands
List Running Containers
docker ps
List All Containers
docker ps -a
Stop Container
docker stop container_id
Remove Container
docker rm container_id
Detached Mode
docker run -d nginx

Detached mode runs the container in background.

Without -d, terminal stays busy.

Custom Container Name
docker run -d --name my-nginx nginx

This helps because instead of random container names, I can easily identify containers.

Check Logs
docker logs my-nginx

Used for troubleshooting and debugging.

Execute Command Inside Container
docker exec -it my-nginx bash

This opens terminal inside running container.

Why Docker is Important in DevOps

Docker is widely used in DevOps because:

Same environment everywhere
Faster deployment
Easy scaling
Works with Kubernetes
Useful in CI/CD pipelines
Supports microservices architecture

Almost every modern cloud and DevOps project uses Docker.
