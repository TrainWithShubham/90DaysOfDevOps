# Day 35 – Multi-Stage Builds & Docker Hub

## What I Learned Today

Multi-stage builds help reduce Docker image sizes by separating the build environment from the production environment. Docker Hub is used to store and distribute images.

---

## Task 1: Single Stage Build (The Problem)

### App: Simple Node.js Hello World

```javascript
// index.js
console.log("Hello, World!");

### Single Stage Dockerfile

```dockerfile
FROM ubuntu:latest
RUN apt-get update && apt-get install -y nodejs npm
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "index.js"]
```

### Image Size
```
node-app:latest    ~400-500MB   😬
```

---

## Task 2: Multi-Stage Build (The Fix)

### Multi-Stage Dockerfile

```dockerfile
# STAGE 1: builder
FROM node:20.11.0-alpine3.19 AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# STAGE 2: production
FROM node:20.11.0-alpine3.19 AS production

WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/index.js .
COPY --from=builder /app/package.json .

EXPOSE 3000
CMD ["node", "index.js"]
```

### Image Size Comparison

| Image | Type | Size |
|-------|------|------|
| node-app | Single stage (ubuntu) | ~400MB |
| node-slim | Multi-stage (alpine) | ~49MB |

### Why is multi-stage smaller?
- Stage 1 (builder) is **temporary** — Docker throws it away after build
- Only the files we need are copied into Stage 2
- No npm cache, no dev dependencies, no build tools in final image
- Stage 1 lives in memory during build, then gets deleted automatically 🗑️

---

## Task 3: Push to Docker Hub

```bash
# Login
docker login

# Tag image
docker tag node-slim akashjaura16/node-slim:v1
docker tag node-slim akashjaura16/node-slim:latest

# Push both tags
docker push akashjaura16/node-slim:v1
docker push akashjaura16/node-slim:latest

# Pull to verify
docker pull akashjaura16/node-slim:v1
```

### Docker Hub Repo
🔗 https://hub.docker.com/r/akashjaura16/node-slim

---

## Task 4: Docker Hub Repository & Versioning

### How tagging works
```
akashjaura16/node-slim:v1      → specific version (never changes) 🔒
akashjaura16/node-slim:latest  → pointer to newest (you update manually)
```

### Key Learnings
- `latest` is just a tag name — Docker does NOT auto-update it
- You must manually push `latest` every time you release a new version
- Always push both `:v1` and `:latest` together

```bash
# Every new release:
docker tag node-slim akashjaura16/node-slim:v2
docker push akashjaura16/node-slim:v2

docker tag node-slim akashjaura16/node-slim:latest
docker push akashjaura16/node-slim:latest
```

---

## Task 5: Image Best Practices

### Optimized Dockerfile

```dockerfile
# 1. Specific tag, not latest
FROM node:20.11.0-alpine3.19

WORKDIR /app

COPY package*.json ./

# 3. Combine RUN commands = fewer layers
RUN npm install --omit=dev && \
    npm cache clean --force

COPY . .

# 2. Non-root user for security
RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup

USER appuser

EXPOSE 3000
CMD ["node", "index.js"]
```

### Best Practices Applied

| Practice | Before | After |
|----------|--------|-------|
| Base image | ubuntu:latest | node:20.11.0-alpine3.19 |
| Run as root | yes (dangerous) | no (appuser) |
| RUN layers | multiple | combined with && |
| Tag | latest | specific version pinned |

### What -S means in adduser/addgroup
```
-S = System user/group
   = no login, no password, no home directory
   = perfect for running apps in containers
```

---

## Key Concepts Summary

```
Single stage:    400MB+   (npm cache, dev deps, build tools all included)
Multi-stage:     49MB     (only production code)

Stage 1 = chef who cooks     (does the work, then leaves)
Stage 2 = waiter who serves  (only has what is needed)

WORKDIR = mkdir + cd (sets working directory for all commands)
latest  = just a label, NOT automatic, YOU must update it!
```

---

## Commands Reference

```bash
# Build
docker build -t myapp .

# Check sizes
docker image ls

# Check layers
docker history myapp

# Check who is running inside container
docker run --rm myapp whoami

# Go inside container
docker run -it myapp sh

# Clean up
docker image prune -a
docker system prune

# Tag and push
docker tag myapp username/myapp:v1
docker push username/myapp:v1
```

---

*Part of #90DaysOfDevOps by TrainWithShubham*
*#DevOpsKaJosh #TrainWithShubham*