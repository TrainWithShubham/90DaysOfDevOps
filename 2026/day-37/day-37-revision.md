# Day 37 – Docker Revision

## Self-Assessment

Run a container from Docker Hub (interactive + detached) – CAN  
List, stop, remove containers and images – CAN  
Explain image layers and caching – CAN  
Write a Dockerfile from scratch – CAN  
Explain CMD vs ENTRYPOINT – SHAKY (revised today)  
Build and tag a custom image – CAN  
Create and use named volumes – CAN  
Use bind mounts – CAN  
Create custom networks – CAN  
Write docker-compose.yml – CAN  
Use environment variables and .env – CAN  
Write multi-stage Dockerfile – SHAKY (clarified today)  
Push image to Docker Hub – CAN  
Use healthchecks and depends_on – CAN  

---

## Quick-Fire Answers

1. Image vs Container  
An image is a read-only blueprint made of layers.  
A container is a running instance of an image with a writable layer.

2. What happens to container data when removed?  
Data inside container writable layer is deleted unless stored in a named volume or bind mount.

3. How do containers on same network communicate?  
They communicate using container name or service name via Docker’s internal DNS.

4. docker compose down vs docker compose down -v  
down removes containers and networks.  
down -v also removes named volumes.

5. Why multi-stage builds?  
To reduce final image size, remove build tools, improve security, and create production-ready images.

6. COPY vs ADD  
COPY only copies files from host to image.  
ADD can extract tar files and download remote URLs.

7. What does -p 8080:80 mean?  
Maps host port 8080 to container port 80.

8. How to check Docker disk usage?  
docker system df

---

## Topics Revised Today

- Multi-stage build internals
- COPY vs ADD difference
- CMD vs ENTRYPOINT difference
- Docker cleanup commands

---

## Reflection

Today helped consolidate Docker fundamentals.
I identified weak spots in multi-stage theory and Dockerfile instructions and clarified them.
I now feel confident managing containers, images, networks, volumes, and compose setups in a real DevOps environment.
