# Day 34 – Docker Compose: Real-World Multi-Container Apps

## Overview

This document covers the advanced Docker Compose concepts practiced on Day 34, including multi-container app stacks, healthchecks, restart policies, named networks, volumes, labels, and scaling.

---

## Project Structure

```
day-34/
├── docker-compose.yml
├── Dockerfile
├── main.py
└── day-34-compose-advanced.md
```

---

## Final docker-compose.yml

```yaml
services:
  python_app:
    build: .
    labels:
      - com.myapp.name=python-app
      - com.myapp.environment=development
      - com.myapp.version=1.0
    ports:
      - "2000"
    networks:
      - custom_network
    depends_on:
      mysql_db:
        condition: service_healthy

  mysql_db:
    image: mysql:latest
    container_name: MySQL_cont
    labels:
      - com.myapp.name=mysql-db
      - com.myapp.environment=development
      - com.myapp.type=database
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: mydatabase
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 1m30s
      timeout: 30s
      retries: 5
      start_period: 30s
    restart: unless-stopped
    networks:
      - custom_network

  cache_app:
    image: redis:latest
    container_name: Redis_cont
    labels:
      - com.myapp.name=cache-app
      - com.myapp.environment=development
      - com.myapp.type=cache
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    restart: unless-stopped
    networks:
      - custom_network

networks:
  custom_network:
    name: my_network

volumes:
  mysql_data:
    driver: local
  redis_data:
    driver: local
```

---

## Dockerfile

```dockerfile
FROM python:3.9
WORKDIR /app
COPY . .
CMD ["python", "main.py"]
```

---

## main.py

```python
import time

print("Python container started!")
while True:
    print("Running...")
    time.sleep(5)
```

---

## Task Notes

### Task 1: Build Your Own App Stack
Created a 3-service stack with:
- **python_app** – Python 3.9 app built from a custom Dockerfile
- **mysql_db** – MySQL latest as the database
- **cache_app** – Redis latest as the cache

All 3 services communicate over a shared custom network `my_network`.

---

### Task 2: depends_on & Healthchecks

Added a healthcheck to `mysql_db`:
```yaml
healthcheck:
  test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
  interval: 1m30s
  timeout: 30s
  retries: 5
  start_period: 30s
```

| `test` | Command Docker runs to check if MySQL is alive |
| `interval` | How often Docker checks (every 1m 30s) |
| `timeout` | How long to wait for a response (30s) |
| `retries` | How many failures before marking unhealthy (5) |
| `start_period` | Grace period on startup before checks begin (30s) |

Added `depends_on` with `condition: service_healthy` so `python_app` waits for MySQL to be truly ready before starting.

---

### Task 3: Restart Policies

| Policy | Behaviour |
|---|---|
| `no` | Never restarts (default) |
| `always` | Always restarts, even after system reboot |
| `on-failure` | Only restarts if the container exits with an error |
| `unless-stopped` | Always restarts unless manually stopped |

**When to use each:**
- `always` – Critical services that must always be running (e.g. production database)
- `on-failure` – Services that should only restart on crashes, not clean stops
- `unless-stopped` – Best for databases and cache in most cases — respects manual stops
- `no` – Development or one-off containers

**Chosen policy:** `unless-stopped` for both `mysql_db` and `cache_app` because it auto-recovers from crashes and reboots but respects `docker stop`.

---

### Task 4: Custom Dockerfiles in Compose

Used `build: .` in `docker-compose.yml` to build the Python app from the local Dockerfile instead of pulling a pre-built image.

To rebuild after a code change:
```bash
docker compose up --build
```

| Command | Behaviour |
|---|---|
| `docker compose up` | Starts containers using existing images |
| `docker compose up --build` | Rebuilds images first, then starts containers |

---

### Task 5: Named Networks & Volumes

**Networks:**  
Defined an explicit network `custom_network` instead of relying on the Docker Compose default. All services are attached to this network so they can communicate using service names as hostnames.

**Volumes:**  
Named volumes defined for data persistence:
- `mysql_data` – persists MySQL database data at `/var/lib/mysql`
- `redis_data` – persists Redis data at `/data`

**Labels:**  
Added meaningful labels to each service for organisation and filtering:
```yaml
labels:
  - com.myapp.name=python-app
  - com.myapp.environment=development
  - com.myapp.version=1.0
```

View labels in terminal:
```bash
docker inspect Python_cont --format '{{json .Config.Labels}}'
```

Filter containers by label:
```bash
docker ps --filter "label=com.myapp.name=mysql-db"
```

---

### Task 6: Scaling (Bonus)

Scaled the Python app to 3 replicas:
```bash
docker compose up --scale python_app=3
```

This created 3 containers:
```
day-34-python_app-1
day-34-python_app-2
day-34-python_app-3
```

**What breaks with simple scaling:**  
Fixed port mappings like `"2000:2000"` break when scaling because multiple containers cannot bind to the same host port. The fix is to remove the fixed host port and let Docker assign random ports:
```yaml
ports:
  - "2000"   # Docker assigns a random host port to each replica
```

**Why doesn't simple scaling work with port mapping?**  
Each container needs its own unique host port. With `"2000:2000"`, only 1 container can bind to port 2000 on the host. In production, a load balancer like Nginx sits in front and distributes traffic across all replicas — the containers themselves don't need fixed ports.

**Note:** Never scale databases or cache services this way — it causes data conflicts. Only scale stateless services.

---

## Useful Commands

```bash
# Start all services
docker compose up -d

# Start and rebuild images
docker compose up --build

# Scale python app to 3 replicas
docker compose up --scale python_app=3

# Stop all services
docker compose down

# Remove containers and volumes
docker compose down -v

# View running containers
docker ps

# View logs
docker compose logs -f

# Inspect labels
docker inspect MySQL_cont --format '{{json .Config.Labels}}'

# Remove a network manually
docker network rm my_network
```


