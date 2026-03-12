# Day 30 – Docker Images & Container Lifecycle

## Docker Images

Images are templates used to create containers.

Pulled images:
- nginx
- ubuntu
- alpine

Alpine is much smaller because it is a minimal Linux distribution.

---

## Image Layers

Docker images consist of multiple read-only layers.

Benefits of layers:

- Faster image builds
- Layer caching
- Reduced storage usage

---

## Container Lifecycle

States of a container:

Created → Running → Paused → Stopped → Removed

Commands practiced:

docker create  
docker start  
docker pause  
docker unpause  
docker stop  
docker restart  
docker kill  
docker rm  

---

## Working with Containers

Commands used:

docker logs  
docker logs -f  
docker exec  
docker inspect  

---

## Cleanup Commands

docker stop $(docker ps -q)

docker container prune

docker image prune

docker system df
