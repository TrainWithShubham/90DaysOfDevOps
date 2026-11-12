# Ultimate Docker & Compose Cheat Sheet
Compiled from real-world EC2 deployments, multi-stage builds, and troubleshooting.

## Container Commands
* `docker run -d -p 8080:80 --name web nginx` - Starts a container in detached mode with port mapping.
* `docker ps -a` - Lists all containers (both running and Exited/137).
* `docker stop <container>` - Gracefully shuts down a container (SIGTERM).
* `docker rm -f <container>` - Force deletes a running or stopped container.
* `docker exec -it <container> bash` - Jumps into a running container's shell for live triage.
* `docker logs --tail 20 -f <container>` - Streams the last 20 lines of logs in real-time.

## Image Commands
* `docker build -t my-app:v1 .` - Builds an image from the Dockerfile in the current directory.
* `docker pull <image>` - Fetches an image from Docker Hub to local cache.
* `docker push <user/image:tag>` - Uploads your tagged local image to a Docker Hub registry.
* `docker tag local-image:latest user/repo:v1` - Tags an image properly for pushing to a remote registry.
* `docker images` - Lists all local images and their physical disk sizes.
* `docker rmi -f <image>` - Forcefully removes an image from local storage.

## Volume Commands (Data Persistence)
* `docker volume create <name>` - Creates a persistent named volume.
* `docker volume ls` - Lists all Docker-managed volumes.
* `docker volume inspect <name>` - Shows volume details including the physical mount path on the host.
* `docker volume rm <name>` - Deletes a specific volume.

## Network Commands (Container Communication)
* `docker network create <name>` - Creates a custom bridge network for automatic DNS resolution.
* `docker network ls` - Lists all networks (bridge, host, none, and custom).
* `docker network inspect <name>` - Displays network details including attached containers and internal IPs.
* `docker network connect <network> <container>` - Attaches a running container to a network.

## Docker Compose Commands
* `docker compose up -d --build` - Builds images and spins up the entire stack in the background.
* `docker compose down -v` - Destroys the stack, including networks and named volumes.
* `docker compose ps` - Shows the health and status of all services in the current stack.
* `docker compose logs -f db` - Streams real-time logs for a specific service (like 'db').
* `docker compose config` - Validates the YAML file and verifies .env variable injection.

## Cleanup Commands (Disk Space Savers)
* `docker system df` - Shows exactly how much disk space Docker images, containers, and volumes are eating.
* `docker system prune -a --volumes -f` - The ultimate nuke command: clears all unused containers, images, networks, and volumes.
* `docker builder prune -a -f` - Clears hidden BuildKit cache to prevent "no space left on device" errors.

## Core Dockerfile Instructions
* `FROM` - Defines the base OS image (e.g., node:22-alpine).
* `RUN` - Executes shell commands during the build phase (e.g., npm install).
* `COPY` - Transfers files from the host into the container filesystem.
* `WORKDIR` - Sets the active directory inside the container for subsequent commands.
* `EXPOSE` - Documents the port the container listens on (e.g., 5000).
* `CMD` - The default startup command that can be overridden at runtime.
* `ENTRYPOINT` - The strict startup executable that appends extra runtime arguments instead of being overridden.
