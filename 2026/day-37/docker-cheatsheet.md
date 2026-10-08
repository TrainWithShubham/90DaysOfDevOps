# Docker Cheat Sheet

# Run Containers

## Run Container

```docker
docker run nginx
```

Run container.

---

## Run in Background

```docker
docker run -d nginx
```

Run in detached mode.

---

## Interactive Mode

```docker
docker run -it ubuntu bash
```

Open terminal inside container.

---

# Container Commands

## Running Containers

```docker
docker ps
```

Show running containers.

---

## All Containers

```docker
docker ps -a
```

Show all containers.

---

## Stop Container

```docker
docker stop container_name
```

Stop container.

---

## Start Container

```docker
docker start container_name
```

Start container.

---

## Remove Container

```docker
docker rm container_name
```

Delete container.

---

## Container Logs

```docker
docker logs container_name
```

Show logs.

---

## Access Container

```docker
docker exec -it container_name bash
```

Open shell inside container.

---

# Image Commands

## Build Image

```docker
docker build -t my-app .
```

Build image.

---

## List Images

```docker
docker images
```

Show images.

---

## Pull Image

```docker
docker pull nginx
```

Download image.

---

## Push Image

```docker
docker push username/image:v1
```

Push image to Docker Hub.

---

## Tag Image

```docker
docker tag my-app username/my-app:v1
```

Create image tag.

---

## Remove Image

```docker
docker rmi image_name
```

Delete image.

---

# Volume Commands

## Create Volume

```docker
docker volume create my-volume
```

Create volume.

---

## List Volumes

```docker
docker volume ls
```

Show volumes.

---

## Inspect Volume

```docker
docker volume inspect my-volume
```

Check volume details.

---

## Remove Volume

```docker
docker volume rm my-volume
```

Delete volume.

---

# Network Commands

## Create Network

```docker
docker network create my-network
```

Create custom network.

---

## List Networks

```docker
docker network ls
```

Show networks.

---

## Inspect Network

```docker
docker network inspect my-network
```

Check network details.

---

# Docker Compose Commands

## Start Services

```docker
docker compose up
```

Start services.

---

## Build and Start

```docker
docker compose up --build
```

Build and start containers.

---

## Background Mode

```docker
docker compose up -d
```

Run in background.

---

## Stop Services

```docker
docker compose down
```

Stop services.

---

## Remove Volumes Also

```docker
docker compose down -v
```

Stop services and delete volumes.

---

## Compose Logs

```docker
docker compose logs
```

Show compose logs.

---

## Running Compose Containers

```docker
docker compose ps
```

Show compose containers.

---

# Cleanup Commands

## Remove Unused Images

```docker
docker image prune -a
```

Delete unused images.

---

## Full Cleanup

```docker
docker system prune -a
```

Delete unused Docker data.

---

## Check Docker Storage

```docker
docker system df
```

Check Docker disk usage.

---

# Dockerfile Instructions

## FROM

```docker
FROM python:3.12-slim
```

Base image.

---

## WORKDIR

```docker
WORKDIR /app
```

Working directory.

---

## COPY

```docker
COPY . .
```

Copy files.

---

## RUN

```docker
RUN pip install flask
```

Run commands during build.

---

## EXPOSE

```docker
EXPOSE 5000
```

Open port.

---

## CMD

```docker
CMD ["python", "app.py"]
```

Default container command.

---

## ENTRYPOINT

```docker
ENTRYPOINT ["python"]
```

Fixed startup command.

---

# Important Concepts

## Image

Blueprint/template.

---

## Container

Running instance of image.

---

## Volume

Persistent storage.

---

## Network

Allows containers to communicate.

---

## Multi-Stage Build

Reduces image size by removing unnecessary build tools.

---

## .env File

Stores environment variables.

---

## Healthcheck

Checks if container is healthy.

---

# Useful Commands

## Docker Version

```docker
docker version
```

---

## Docker Information

```docker
docker info
```

---

## Resource Usage

```docker
docker stats
```

Check CPU and memory usage.
