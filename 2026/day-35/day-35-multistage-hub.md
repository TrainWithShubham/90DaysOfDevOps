# Day 35 – Multi-Stage Builds & Docker Hub

## Task 1: The Problem with Large Images

### 1. Simple Node.js App

**app.js**

```javascript
console.log("Hello from Docker!");

```
### 2. Single Stage Dockerfile

Dockerfile
```bash
FROM node:18

WORKDIR /app

COPY app.js .

CMD ["node", "app.js"]

```

### 3. Build the Image

docker build -t large-image-demo .

### 4.Check Image Size

docker images


## Task 2: Multi-Stage Build

### 1. Multi-Stage Dockerfile

**Dockerfile**

```dockerfile
# Stage 1 – Build Stage
FROM node:18 AS builder

WORKDIR /app

COPY app.js .

# Stage 2 – Production Stage
FROM node:18-alpine

WORKDIR /app

COPY --from=builder /app/app.js .

CMD ["node", "app.js"]
```


**Why is the multi-stage image much smaller?**

The multi-stage image is smaller because only the necessary application files are copied into the final image. The build environment, development tools, and unnecessary dependencies used during the build stage are not included in the final stage. This removes extra files and reduces the overall image size, making the image lighter, faster to pull, and more secure.


---


## Task 3: Push to Docker Hub

### 1. Create Docker Hub Account
Create a free account at: https://hub.docker.com  
(If you already have one, skip this step.)

---

### 2. Login from Terminal

```bash
docker login
```



### 3. Tag the Image Properly

docker tag <local-image-name> <yourusername>/<image-name>:<tag>

### 4. Push the Image

docker push omdeshmukh/multistage-image-demo:v1

### 5. Verify by Pulling

docker rmi omdeshmukh/multistage-image-demo:v1


---


## Task 4: Docker Hub Repository

### 1. Check the Pushed Image

Open your repository on Docker Hub:


Here you can see your pushed image and repository details.

---

### 2. Add a Description

Go to the repository page → **Edit Repository** → Add a description.

Example description:

This repository contains a Docker image built using a multi-stage Dockerfile.
The image demonstrates how to reduce image size by separating the build
environment from the runtime environment.


Save the changes.

---

### 3. Explore the Tags Tab

Open the **Tags** tab in the repository.

Example tags:

v1
latest



Tags are used for **versioning Docker images**.

Example:

- `v1` → specific version
- `latest` → default version if no tag is specified

---

### 4. Pull a Specific Tag vs Latest

Pull a specific version:

```bash
docker pull omdeshmukh86/multistage-image-demo:v1
```


Pull latest version:
```bash

docker pull omdeshmukh86/multistage-image-demo:latest
```