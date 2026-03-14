# Docker Cheat Sheet

## 1. Basic Docker Commands

### Check Docker Version
docker --version

### Run Container (Interactive)
docker run -it ubuntu bash

### Run Container (Detached)
docker run -d nginx

### List Running Containers
docker ps

### List All Containers
docker ps -a

### Stop Container
docker stop <container_id>

### Remove Container
docker rm <container_id>

### Remove Image
docker rmi <image_id>

---

## 2. Docker Images

### Pull Image from Docker Hub
docker pull nginx

### List Images
docker images

### Build Image from Dockerfile
docker build -t myapp:1.0 .

### Tag Image
docker tag myapp:1.0 username/myapp:1.0

---

## 3. Dockerfile Basics

Example Dockerfile:

FROM node:18

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

CMD ["node", "app.js"]

---

## 4. CMD vs ENTRYPOINT

CMD
- Provides default command
- Can be overridden

ENTRYPOINT
- Fixed command
- Used when container should always run specific command

Example:

ENTRYPOINT ["python"]
CMD ["app.py"]

---

## 5. Volumes

Create Named Volume

docker volume create myvolume

Run container with volume

docker run -v myvolume:/data nginx

List volumes

docker volume ls

---

## 6. Bind Mount

Mount local folder into container

docker run -v $(pwd):/app nginx

---

## 7. Docker Networks

Create network

docker network create mynetwork

Run container in network

docker run -d --network mynetwork nginx

List networks

docker network ls

---

## 8. Docker Compose

Example docker-compose.yml

version: "3"

services:

  web:
    image: nginx
    ports:
      - "8080:80"

  db:
    image: mysql
    environment:
      MYSQL_ROOT_PASSWORD: password

Run compose

docker compose up -d

Stop compose

docker compose down

---

## 9. Environment Variables

.env file

DB_USER=root  
DB_PASS=1234

Use in compose

environment:
  - DB_USER=${DB_USER}

---

## 10. Multi-Stage Build

Example:

FROM node:18 as builder
WORKDIR /app
COPY . .
RUN npm install

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app .
CMD ["node", "app.js"]

Purpose:
- Reduce image size
- Separate build and runtime environments

---

## 11. Push Image to Docker Hub

Login

docker login

Push image

docker push username/myapp:1.0

---

## 12. Healthcheck

Example

healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost"]
  interval: 30s
  timeout: 10s
  retries: 3

---

## 13. depends_on

Used in docker-compose

services:

  web:
    depends_on:
      - db

  db:
    image: mysql