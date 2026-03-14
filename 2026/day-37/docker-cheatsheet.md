# Docker Cheat Sheet
Practical commands for daily DevOps usage

---

## Container Commands

```code
docker run -it image_name – Run container in interactive terminal mode
docker run -d image_name – Run container in detached (background) mode
docker ps – List running containers
docker ps -a – List all containers (including stopped)
docker stop container_name – Stop a running container
docker rm container_name – Remove a stopped container
docker exec -it container_name bash – Open interactive shell inside running container
docker logs container_name – View container logs
docker logs -f container_name – Follow live container logs
docker inspect container_name – Show detailed container configuration (JSON)
```

---

## Image Commands

```code
docker build -t image_name:tag . – Build image from Dockerfile in current directory
docker pull image_name:tag – Pull image from Docker Hub
docker push image_name:tag – Push image to Docker Hub
docker images – List local images
docker rmi image_name:tag – Remove an image
docker tag source_image:tag new_image:tag – Create a new tag for an image
docker history image_name:tag – Show image layer history
docker inspect image_name:tag – Show detailed image metadata (JSON)
```

---

## Volume Commands

```code
docker volume create volume_name – Create a named volume
docker volume ls – List all volumes
docker volume inspect volume_name – Show detailed volume metadata (JSON)
docker volume rm volume_name – Remove a volume
docker volume prune – Remove all unused (dangling) volumes
```

---

## Network Commands

```code
docker network create network_name – Create a custom bridge network
docker network ls – List all Docker networks
docker network inspect network_name – Show detailed network configuration (JSON)
docker network connect network_name container_name – Connect a container to a network
docker network rm network_name – Remove a Docker network
```

---

## Compose Commands

```code
docker compose up – Create and start all services defined in docker-compose.yml
docker compose up -d – Start services in detached (background) mode
docker compose down – Stop and remove containers, networks created by Compose
docker compose ps – List running services
docker compose logs – View logs of all services
docker compose build – Build images defined in docker-compose.yml
docker compose restart – Restart all services
```

---

## Cleanup Commands

```code
docker system df – Show Docker disk usage (images, containers, volumes, build cache)
docker system prune – Remove unused containers, networks, dangling images, and build cache
docker container prune – Remove all stopped containers
docker image prune – Remove dangling images
docker builder prune – Remove unused build cache (intermediate build layers)
```

---

## Dockerfile Instructions

```code
FROM – Set the base image for the build (starting point of image)
RUN – Execute commands during build time (creates new image layer)
COPY – Copy files from host machine into the image
WORKDIR – Set working directory inside the image for subsequent instructions
EXPOSE – Document which port the container listens on (does not publish it)
CMD – Default command executed when container starts (can be overridden)
ENTRYPOINT – Define main executable for the container (harder to override)
ENV – Set environment variables inside the image
ARG – Define build-time variables used during image build only
```
---
