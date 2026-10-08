# Docker Deep Revision Notes

# What is Docker?

Docker is a containerization platform.

It helps developers package:

- application
- libraries
- dependencies
- configuration

inside one container.

Because of Docker:

- application works same everywhere
- no dependency issues
- easy deployment
- fast setup

---

# Problem Before Docker

Before Docker:

- application worked on one system
- failed on another system
- different library versions
- difficult setup
- manual installation

Example:

Developer laptop:

```text
Python 3.12
```

Server:

```text
Python 3.8
```

Application may fail.

Docker solves this problem.

---

# What is an Image?

Image is a blueprint/template.

Image contains:

- application code
- dependencies
- libraries
- runtime
- commands

Image is READ ONLY.

Example:

- nginx image
- python image
- mysql image

---

# What is a Container?

Container is a running instance of an image.

Example:

```docker id="d101"
docker run nginx
```

What happens internally:

1. Docker checks local image
2. If image missing → pulls from Docker Hub
3. Creates writable container layer
4. Starts container process
5. Application starts

---

# Difference Between Image and Container

| Image               | Container           |
| ------------------- | ------------------- |
| Blueprint           | Running application |
| Read only           | Writable            |
| Static              | Dynamic             |
| Cannot run directly | Runs application    |

---

# Docker Architecture

Docker has:

- Docker Client
- Docker Daemon
- Docker Registry

---

# Docker Client

Commands we type:

```docker id="d102"
docker ps
```

Client sends request to Docker daemon.

---

# Docker Daemon

Main Docker engine.

Responsible for:

- building images
- running containers
- managing networks
- managing volumes

---

# Docker Registry

Stores images.

Example:

- Docker Hub

---

# Docker Workflow

```text id="d103"
Dockerfile → Docker Image → Docker Container
```

---

# What is Dockerfile?

Dockerfile is a text file used to create Docker images.

Contains instructions.

Example:

```dockerfile id="d104"
FROM python:3.12-slim

WORKDIR /app

COPY . .

RUN pip install flask

CMD ["python", "app.py"]
```

---

# FROM

```dockerfile id="d105"
FROM python:3.12-slim
```

Purpose:

- selects base image

Internally:

1. Docker downloads base image
2. Creates image layers

---

# Why Slim or Alpine Images?

Smaller size:

- less storage
- faster download
- less vulnerabilities

Example:

- Ubuntu → large
- Alpine → very small

---

# WORKDIR

```dockerfile id="d106"
WORKDIR /app
```

Purpose:

- sets working directory

Internally:

- creates folder if missing
- all next commands run inside folder

---

# COPY

```dockerfile id="d107"
COPY . .
```

Purpose:

- copies files into container

Internally:

- Docker copies local files
- creates new image layer

---

# RUN

```dockerfile id="d108"
RUN pip install flask
```

Purpose:

- executes commands during image build

Internally:

1. temporary container starts
2. command executes
3. changes saved into new image layer
4. temporary container removed

---

# Image Layers

Every Dockerfile instruction creates a layer.

Example:

```dockerfile id="d109"
FROM python
COPY . .
RUN pip install flask
```

Layers:

1. Python layer
2. Copy layer
3. Pip install layer

Benefits:

- faster builds
- caching
- layer reuse

---

# Docker Cache

Docker reuses unchanged layers.

Example:
If only app code changes:

- dependencies layer reused
- build becomes faster

---

# EXPOSE

```dockerfile id="d110"
EXPOSE 5000
```

Purpose:

- documents application port

Does NOT automatically publish port.

---

# CMD

```dockerfile id="d111"
CMD ["python", "app.py"]
```

Purpose:

- default startup command

Can be overridden.

Example:

```docker id="d112"
docker run image_name ls
```

Overrides CMD.

---

# ENTRYPOINT

```dockerfile id="d113"
ENTRYPOINT ["python"]
```

Purpose:

- fixed startup command

More strict than CMD.

---

# CMD vs ENTRYPOINT

| CMD              | ENTRYPOINT            |
| ---------------- | --------------------- |
| Default command  | Fixed command         |
| Easy to override | Difficult to override |

---

# Build Docker Image

```docker id="d114"
docker build -t my-app .
```

Internally:

1. Docker reads Dockerfile
2. Executes instructions one by one
3. Creates layers
4. Builds final image

---

# Docker Run

```docker id="d115"
docker run nginx
```

Internally:

1. creates container
2. creates writable layer
3. assigns network
4. starts process

---

# Detached Mode

```docker id="d116"
docker run -d nginx
```

Container runs in background.

---

# Interactive Mode

```docker id="d117"
docker run -it ubuntu bash
```

Purpose:

- open shell inside container

Flags:

- `-i` → interactive
- `-t` → terminal

---

# Port Mapping

```docker id="d118"
-p 8080:80
```

Meaning:

- localhost port 8080
- forwards traffic to container port 80

Flow:

```text id="d119"
Browser → Host Port → Container Port
```

---

# Docker Volumes

Problem:
Container data deletes when container removed.

Solution:
Volumes.

---

# Volume Example

```docker id="d120"
docker volume create my-volume
```

Purpose:

- persistent storage

Used for:

- databases
- logs
- application data

---

# Bind Mount

```docker id="d121"
-v $(pwd):/app
```

Purpose:

- connects local folder to container folder

Changes sync instantly.

Mostly used in development.

---

# Docker Networks

Purpose:

- container communication

Without network:
containers isolated.

---

# Custom Network

```docker id="d122"
docker network create my-network
```

Containers communicate using:

- service names
- container names

Example:

```text id="d123"
db
```

instead of localhost.

---

# Docker Compose

Purpose:
Run multiple containers together.

Example:

- app
- database
- redis

all inside one file.

---

# docker-compose.yml

Written in YAML format.

Example:

```yaml id="d124"
services:
  app:
  db:
```

---

# Docker Compose Up

```docker id="d125"
docker compose up
```

Internally:

1. reads compose file
2. creates network
3. creates volumes
4. builds images
5. starts containers

---

# Docker Compose Down

```docker id="d126"
docker compose down
```

Stops and removes:

- containers
- networks

---

# Docker Compose Down -v

```docker id="d127"
docker compose down -v
```

Also removes volumes.

Database data deleted.

---

# Environment Variables

Stored in:

```text id="d128"
.env
```

Purpose:

- separate config from code
- secure configuration

Example:

- passwords
- database names
- ports

---

# Healthcheck

Purpose:
checks if container healthy.

Example:
database ready before app starts.

---

# depends_on

Controls startup order.

Example:
app waits for database.

---

# Multi-Stage Build

Purpose:
reduce image size.

Example flow:

```text id="d129"
Builder Stage → Runtime Stage
```

Internally:

- build tools removed
- only final application copied

Benefits:

- smaller image
- secure image
- faster deployment

---

# Docker Hub

Purpose:
store and share images.

Like GitHub for Docker images.

---

# Tag Image

```docker id="d130"
docker tag my-app username/my-app:v1
```

Purpose:
gives proper repository name.

---

# Push Image

```docker id="d131"
docker push username/my-app:v1
```

Uploads image to Docker Hub.

---

# Pull Image

```docker id="d132"
docker pull nginx
```

Downloads image locally.

---

# Cleanup Commands

## Remove Unused Images

```docker id="d133"
docker image prune -a
```

---

## Full Cleanup

```docker id="d134"
docker system prune -a
```

Deletes:

- unused images
- stopped containers
- unused networks
- cache

---

# Check Docker Storage

```docker id="d135"
docker system df
```

Shows:

- image usage
- container usage
- cache usage

---

# Why Docker is Important in DevOps

Docker helps:

- consistency
- fast deployment
- scalability
- microservices
- CI/CD pipelines
- cloud deployments

Used with:

- Kubernetes
- Jenkins
- GitHub Actions
- AWS
- Azure

---

# Final Revision Summary

Today I revised:

- Docker architecture
- Images
- Containers
- Dockerfile
- Layers
- Cache
- Networks
- Volumes
- Compose
- Multi-stage builds
- Docker Hub
- Cleanup
- Healthchecks

---

# Conclusion

Docker simplifies application deployment by packaging everything into containers.

It helps developers and DevOps engineers build portable, lightweight, and consistent applications across environments.
