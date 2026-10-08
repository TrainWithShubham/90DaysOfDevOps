# Day 30 – Docker Images & Container Lifecycle

## Docker Images

Today I worked with Docker images and container lifecycle.

First, I pulled images from Docker Hub:

```bash id="jlwm01"
docker pull nginx
docker pull ubuntu
docker pull alpine
```

Then I listed all images:

```bash id="jlwm02"
docker images
```

I observed:

- nginx image was bigger
- ubuntu image medium size
- alpine image very small

---

# Ubuntu vs Alpine

Ubuntu image contains:

- more packages
- more tools
- full Linux environment

That is why Ubuntu image size is larger.

Alpine image is:

- lightweight
- minimal Linux distribution
- used for smaller production Docker images

Alpine image size was around:

```text id="jlwm03"
3.8 MB
```

while Ubuntu was much bigger.

---

# Docker Inspect

I inspected images using:

```bash id="jlwm04"
docker inspect nginx
docker inspect ubuntu
docker inspect alpine
```

From inspect output I learned:

- image ID
- environment variables
- exposed ports
- entrypoint
- default command
- architecture
- image layers
- image size

Example:
Nginx image exposed:

```text id="jlwm05"
80/tcp
```

because nginx runs on port 80.

---

# Docker Image History

I checked image layers using:

```bash id="jlwm06"
docker image history nginx
```

I learned:

- Docker images are made of layers
- each Dockerfile instruction creates a layer
- some layers show MB size
- some layers show 0B

0B layers usually contain metadata changes like:

- ENV
- CMD
- LABEL
- ENTRYPOINT

---

# Why Docker Uses Layers

Docker uses layers for:

- caching
- faster builds
- storage optimization

If only one layer changes, Docker rebuilds only that layer instead of rebuilding the entire image.

This improves CI/CD performance.

---

# Container Lifecycle

I practiced full container lifecycle.

---

## Create Container

```bash id="jlwm07"
docker create --name lifecycle-nginx nginx
```

This created the container without starting it.

Container state:

```text id="jlwm08"
Created
```

---

## Start Container

```bash id="jlwm09"
docker start lifecycle-nginx
```

Docker:

- mounted image layers
- attached network
- started nginx process

Container became:

```text id="jlwm10"
Running
```

---

## Pause Container

```bash id="jlwm11"
docker pause lifecycle-nginx
```

This temporarily froze container processes.

Container state:

```text id="jlwm12"
Paused
```

---

## Unpause Container

```bash id="jlwm13"
docker unpause lifecycle-nginx
```

This resumed frozen processes.

---

## Stop Container

```bash id="jlwm14"
docker stop lifecycle-nginx
```

Docker performed graceful shutdown using:

```text id="jlwm15"
SIGTERM
```

Container state became:

```text id="jlwm16"
Exited
```

---

## Restart Container

```bash id="jlwm17"
docker restart lifecycle-nginx
```

Docker:

- stopped container
- started it again

---

## Kill Container

```bash id="jlwm18"
docker kill lifecycle-nginx
```

Docker forcefully terminated the container using:

```text id="jlwm19"
SIGKILL
```

Unlike stop, kill does not wait for graceful shutdown.

---

## Remove Container

```bash id="jlwm20"
docker rm lifecycle-nginx
```

This deleted the container completely.

---

# Working with Running Containers

I started nginx container in detached mode:

```bash id="jlwm21"
docker run -d -p 8080:80 --name asma-nginx nginx
```

I accessed nginx in browser:

```text id="jlwm22"
http://localhost:8080
```

---

# View Logs

```bash id="jlwm23"
docker logs asma-nginx
```

For real-time logs:

```bash id="jlwm24"
docker logs -f asma-nginx
```

---

# Exec Into Container

```bash id="jlwm25"
docker exec -it asma-nginx bash
```

I explored container filesystem using:

- pwd
- ls
- cd

---

# Run Single Command Inside Container

```bash id="jlwm26"
docker exec asma-nginx ls /
```

This executed command inside running container without entering interactive shell.

---

# Inspect Running Container

```bash id="jlwm27"
docker inspect asma-nginx
```

I found:

- container IP address
- port mappings
- mounts
- network settings

---

# Cleanup Commands

Stop all running containers:

```bash id="jlwm28"
docker stop $(docker ps -q)
```

Remove stopped containers:

```bash id="jlwm29"
docker container prune
```

Remove unused images:

```bash id="jlwm30"
docker image prune -a
```

Check Docker disk usage:

```bash id="jlwm31"
docker system df
```

---

# What I Learned

Today I learned:

- difference between images and containers
- Docker image layers
- caching
- container lifecycle
- logs and exec
- inspect command
- cleanup commands

I also understood how Docker internally manages containers and processes.
