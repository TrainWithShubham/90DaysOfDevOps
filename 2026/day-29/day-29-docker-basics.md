# Day 29 – Docker Basics

## What is Docker
Docker is a container platform used to package applications with their dependencies.

## Containers vs Virtual Machines
Containers share host OS while VMs run full OS.

## Docker Architecture
Docker Client → Docker Daemon → Images → Containers → Registry

## Commands Practiced

docker run hello-world

docker run -d -p 8080:80 nginx

docker run -it ubuntu

docker ps

docker ps -a

docker stop <container>

docker rm <container>

docker logs <container>

docker exec -it <container> bash
<img width="1173" height="305" alt="image" src="https://github.com/user-attachments/assets/09a38803-ed01-4438-af7e-a20974c8bec5" />

