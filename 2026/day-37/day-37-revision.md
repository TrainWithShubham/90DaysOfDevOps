# Day 37 – Docker Revision & Cheat Sheet

---

## Self-Assessment Checklist
Mark yourself honestly — **can do**, **shaky**, or **haven't done**:

- [x] Run Docker containers in interactive and detached modes
- [x] List, stop, and remove containers and images
- [x] Explain Docker image layers and build cache
- [x] Write a Dockerfile using `FROM`, `RUN`, `COPY`, `WORKDIR`, and `CMD`
- [x] Explain the difference between `CMD` and `ENTRYPOINT`
- [x] Build and tag custom Docker images
- [x] Create and manage Docker volumes
- [x] Use bind mounts for local development
- [x] Create custom Docker networks and connect containers
- [x] Build multi-container applications with Docker Compose
- [x] Configure environment variables using `.env` files
- [x] Write multi-stage Dockerfiles
- [x] Push Docker images to Docker Hub
- [x] Configure health checks and service dependencies

---

## Docker Quick-Fire Questions

### 1. What is the difference between an image and a container?
- **Image** = A read-only blueprint used to create containers.
- **Container** = A running instance of a Docker image.

---

### 2. What happens to data inside a container when you remove it?
- Container data is deleted when the container is removed unless it is stored in a Docker Volume.
- To keep data, use **Docker Volumes**.

---

### 3. How do two containers on the same custom network communicate?
- They communicate using their **container names (or service names in Docker Compose)**.
- Docker provides built-in DNS for name resolution.

**Example:**
```bash
mongodb:27017
```

---

### 4. What does `docker compose down -v` do differently from `docker compose down`?

| Command | What it does |
|---------|--------------|
| `docker compose down` | Stops and removes containers and networks |
| `docker compose down -v` | Stops and removes containers, networks, and **volumes** (deletes stored data) |

---

### 5. Why are multi-stage builds useful?
- Create **smaller and more secure** Docker images.
- Remove unnecessary build dependencies.
- Improve build performance and deployment speed.

---

### 6. What is the difference between `COPY` and `ADD`?

| `COPY` | `ADD` |
|--------|-------|
| Copies local files only | Copies files and can extract `.tar` archives or download from URLs |
| Simple and recommended | Has extra features |

> **Best Practice:** Use `COPY` unless you specifically need `ADD`.

---

### 7. What does `-p 8080:80` mean?

It maps:

- **8080** → Port on your computer (Host)
- **80** → Port inside the container

```
Browser → localhost:8080 → Container:80
```

---

### 8. How do you check how much disk space Docker is using?

```bash
docker system df
```

For detailed usage:

```bash
docker system df -v
```

---

## Docker Command Cheat Sheet

As part of today's revision, I created a comprehensive Docker Command Cheat Sheet covering:

- **Container commands** — run, ps, stop, rm, exec, logs
- **Image commands** — build, pull, push, tag, ls, rm
- **Volume commands** — create, ls, inspect, rm
- **Network commands** — create, ls, inspect, connect
- **Compose commands** — up, down, ps, logs, build
- **Cleanup commands** — prune, system df
- **Dockerfile instructions** — FROM, RUN, COPY, WORKDIR, EXPOSE, CMD, ENTRYPOINT

Docker-CMD-List :- [Docker-Notest.yml](Docker-Notest.yml)
---

## Revisited Topics

### CMD vs ENTRYPOINT

| CMD | ENTRYPOINT |
|------|------------|
| Provides default arguments. | Defines the main executable. |
| Can be overridden easily. | Runs every time unless explicitly overridden. |

---

### `docker system prune`

Removes unused containers, networks, dangling images, and build cache.

> **Note:** `docker system prune -a --volumes` also removes unused images and volumes.

---

## Key Takeaways

- Revised Docker fundamentals, architecture, and core concepts.
- Practiced common Docker interview questions and reviewed key concepts.
- Strengthened understanding of Docker Compose, networking, volumes, Dockerfiles, and multi-stage builds.
- Created a comprehensive Docker Command Cheat Sheet for quick reference and future DevOps projects.