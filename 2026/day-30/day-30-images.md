# Day 30 – Docker Images & Container Lifecycle

## Objective
Understand how Docker images and containers work, including image layers, caching, and the full container lifecycle.

---

##  Task 1: Docker Images

### Pull Images
docker pull nginx  
docker pull ubuntu  
docker pull alpine  

### List Images
docker images  

### Observation
- ubuntu → Larger (~70MB+)  
- alpine → Very small (~5MB)  

### Why Alpine is Smaller?
- Minimal Linux distribution  
- No unnecessary packages  
- Optimized for containers  

---

### Inspect an Image
docker inspect nginx  

### Key Info:
- Image ID  
- Layers  
- Environment variables  
- Default commands  
- Metadata  

---

### Remove an Image
docker rmi ubuntu  

---

## Task 2: Image Layers

### View Image History
docker image history nginx  

### What are Layers?
- Each Dockerfile instruction creates a layer  
- Layers are immutable, cached, and reusable  

### Why Some Layers Show 0B?
- Only metadata changes (no file changes)  

### Why Docker Uses Layers?
- Faster builds  
- Efficient storage  
- Easy sharing  

---

## Task 3: Container Lifecycle

### Create Container
docker create --name my-container alpine  

### Start Container
docker start my-container  

### Pause Container
docker pause my-container  

### Unpause Container
docker unpause my-container  

### Stop Container
docker stop my-container  

### Restart Container
docker restart my-container  

### Kill Container
docker kill my-container  

### Remove Container
docker rm my-container  

### Check Status
docker ps -a  

---

## Task 4: Working with Running Containers

### Run Nginx
docker run -d -p 80:80 --name nginx-container nginx  

### View Logs
docker logs nginx-container  

### Real-time Logs
docker logs -f nginx-container  

### Exec into Container
docker exec -it nginx-container /bin/bash  

### Run Command Inside Container
docker exec nginx-container ls /  

### Inspect Container
docker inspect nginx-container  

---

## Task 5: Cleanup

### Stop All Containers
docker stop $(docker ps -q)  

### Remove All Containers
docker rm $(docker ps -a -q)  

### Remove Unused Images
docker image prune -a  

### Check Disk Usage
docker system df  

### Clean Everything
docker system prune -a  

---

##  Key Learnings

- Images = Blueprint  
- Containers = Running Instance  
- Layers = Optimization system  
- Alpine = Lightweight & fast  
- Lifecycle = Create → Start → Stop → Remove  

---

##  Learn in Public

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham