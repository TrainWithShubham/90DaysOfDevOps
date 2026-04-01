# Docker Practice Projects

A collection of four simple web applications across different tech stacks, purpose-built for Docker learning and practice. Each app is a working REST API or UI with real dependency files — no Dockerfiles included, so you can write them yourself!

---

## Projects Overview

| Project       | Language   | Framework       | Port | App Type        |
|---------------|------------|-----------------|------|-----------------|
| `flask-app`   | Python 3.11| Flask 3.0       | 5000 | Task CRUD API   |
| `java-app`    | Java 17    | Spring Boot 3.3 | 8080 | Book CRUD API   |
| `go-app`      | Go 1.22    | stdlib only     | 8080 | Product CRUD API|
| `react-app`   | JavaScript | React 18        | 3000 | Notes UI        |

---

## Project Structure

```
docker-practice/
├── flask-app/
│   ├── app.py
│   ├── requirements.txt
│   └── README.md
│
├── java-app/
│   ├── src/main/java/com/example/bookapi/
│   │   ├── BookApiApplication.java
│   │   ├── Book.java
│   │   └── BookController.java
│   ├── src/main/resources/application.properties
│   ├── pom.xml
│   └── README.md
│
├── go-app/
│   ├── main.go
│   ├── go.mod
│   └── README.md
│
├── react-app/
│   ├── public/index.html
│   ├── src/
│   │   ├── index.js
│   │   └── App.js
│   ├── package.json
│   ├── nginx.conf
│   ├── .env
│   └── README.md
│
└── README.md   ← you are here
```

---

## Docker Concepts to Practice Per App

### 🐍 Flask App — Fundamentals
- `FROM python:3.11-slim`
- `COPY` and `RUN pip install -r requirements.txt`
- `CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:5000"]`
- `EXPOSE 5000`
- Port mapping: `-p 5000:5000`
- Environment variables: `-e FLASK_ENV=production`

### ☕ Java App — Multi-Stage Builds
- Stage 1: `FROM maven:3.9-eclipse-temurin-17 AS builder` → `mvn clean package`
- Stage 2: `FROM eclipse-temurin:17-jre-alpine` → copy JAR from builder
- `ENTRYPOINT ["java", "-jar", "app.jar"]`
- Practice `COPY --from=builder`
- `JAVA_OPTS` env variable for memory tuning

### 🐹 Go App — Minimal Images
- Stage 1: `FROM golang:1.22-alpine AS builder` → `CGO_ENABLED=0 go build -o server .`
- Stage 2: `FROM scratch` or `FROM alpine:3.19`
- Copy only the static binary — no runtime needed!
- See how small the final image is (often < 15MB with scratch)

### ⚛️ React App — Static Asset Serving
- Stage 1: `FROM node:18-alpine AS builder` → `npm install && npm run build`
- Stage 2: `FROM nginx:alpine` → copy `build/` to `/usr/share/nginx/html`
- Use the provided `nginx.conf` for SPA routing
- `EXPOSE 80`
- Understand why Node.js doesn't need to be in the final image

---

## General Docker Commands Reference

```bash
# Build an image
docker build -t my-app:1.0 .

# Run a container
docker run -d -p HOST_PORT:CONTAINER_PORT --name my-container my-app:1.0

# List running containers
docker ps

# View logs
docker logs my-container

# Stop & remove a container
docker stop my-container && docker rm my-container

# List images
docker images

# Remove an image
docker rmi my-app:1.0

# Open a shell inside a running container
docker exec -it my-container sh

# Inspect a container
docker inspect my-container
```

---

## Learning Path

1. **Start with Flask** — simplest to Dockerize, great for learning the basics
2. **Move to Go** — practice multi-stage builds and understand tiny images
3. **Try Java** — more complex multi-stage build, explore JVM in containers
4. **Finish with React** — learn about build artifacts and Nginx serving

Each project folder has its own `README.md` with specific Docker hints and example `curl` commands to test the running container.

---

## Tips

- Always use specific image tags (e.g., `python:3.11-slim`), never `latest` in practice
- Use `.dockerignore` to exclude `node_modules`, `target/`, `__pycache__`, etc.
- Keep images small — prefer `slim` or `alpine` variants
- One process per container is a good rule of thumb
- Use `HEALTHCHECK` in your Dockerfiles to make containers self-aware
