# Day 33 – Docker Compose: Multi-Container Basics

---

## Task 2: Your First Compose File

### Create Folder
mkdir compose-basics
cd compose-basics

### docker-compose.yml

version: "3.8"

services:
  nginx:
    image: nginx:latest
    container_name: compose-nginx
    ports:
      - "8080:80"

### Start
docker compose up

### Access
http://localhost:8080

### Stop
docker compose down

---


# Day 33 – Docker Compose

## Task 4: Compose Commands
```bash
Command	Purpose
docker compose up -d	Start services in background
docker compose ps	Show running services
docker compose logs	View logs of all services
docker compose logs <service>	View logs of a specific service
docker compose stop	Stop services without removing
docker compose down	Remove containers and network
docker compose up --build	Rebuild images and start service
```
