# Day 32 – Docker Volumes & Networking

## Task 1: The Problem - Data Persistence Without Volumes

**Experiment:**
- Ran a PostgreSQL container
- Created a database and inserted some test data
- Stopped and removed the container
- Ran a new container with the same image

**Result:** Data was **NOT** persisted.

**Why?**  
Containers are ephemeral by design. When a container is removed, all its data (including databases, logs, files) is deleted. This is because container storage is tied to the container's writable layer, which only exists while the container runs.

---

## Task 2: Named Volumes

### Creating a Named Volume
```bash
docker volume create my-postgres-data
```

### Running PostgreSQL with the Volume
```bash
docker run -d \
  --name postgres-container \
  -e POSTGRES_PASSWORD=mysecretpassword \
  -v my-postgres-data:/var/lib/postgresql/data \
  postgres
```

### Verification Commands
```bash
docker volume ls
docker volume inspect my-postgres-data
```

### Testing Persistence
1. Connected to PostgreSQL and created a test database with data
2. Stopped and removed the container: `docker rm -f postgres-container`
3. Ran a new container with the same volume
4. **Data was still there!**

**Why it works:** Named volumes persist independently of containers. The volume outlives any single container, so data persists across container lifecycles.

---

## Task 3: Bind Mounts

### Setup
1. Created a folder on host: `mkdir -p ~/nginx-html`
2. Created `index.html` inside with some content

### Running Nginx with Bind Mount
```bash
docker run -d \
  --name nginx-bind \
  -p 8080:80 \
  -v ~/nginx-html:/usr/share/nginx/html \
  nginx
```

### Testing
- Accessed `http://localhost:8080` - page loaded
- Edited `index.html` on host, refreshed browser - **changes appeared immediately**

### Named Volumes vs Bind Mounts

| Aspect | Named Volumes | Bind Mounts |
|--------|---------------|-------------|
| Location | Docker-managed (`/var/lib/docker/volumes/`) | Host filesystem (any path) |
| Use Case | Database storage, app data | Development, config files |
| Host Access | Limited (Docker controls) | Full host access |
| Persistence | Survives container removal | Tied to host directory |
| Performance | Optimized for containers | Slightly slower (host I/O) |

---

## Task 4: Docker Networking Basics

### List All Networks
```bash
docker network ls
```

### Inspect Default Bridge
```bash
docker network inspect bridge
```

### Testing Communication on Default Bridge
```bash
# Run two containers on default bridge
docker run -d --name container1 nginx
docker run -d --name container2 alpine

# Try pinging by name
docker exec container1 ping -c 3 container2  # FAILS - default bridge doesn't support DNS

# Try pinging by IP
docker exec container1 ping -c 3 <container2-IP>  # WORKS - they're on same subnet
```

**Result:**
- By **name**: NO - containers cannot resolve each other's names on default bridge
- By **IP**: YES - containers can communicate by IP address

---

## Task 5: Custom Networks

### Create Custom Bridge Network
```bash
docker network create my-app-net
```

### Run Containers on Custom Network
```bash
docker run -d --name web --network my-app-net nginx
docker run -d --name app --network my-app-net alpine
```

### Test Communication
```bash
docker exec web ping -c 3 app  # WORKS!
```

**Why does custom networking allow name-based communication?**
- Custom bridge networks have a built-in **embedded DNS server**
- Docker automatically assigns DNS entries for each container using its name
- Containers can resolve each other by service name (container name)
- This is essential for service discovery in multi-container applications

---

## Task 6: Put It Together

### Create the Setup
```bash
# Create custom network
docker network create fullstack-net

# Run database with volume and network
docker run -d \
  --name mysql-db \
  -e MYSQL_ROOT_PASSWORD=password \
  -e MYSQL_DATABASE=testdb \
  -v mysql-data:/var/lib/mysql \
  --network fullstack-net \
  mysql:8

# Run app container on same network
docker run -d \
  --name my-app \
  --network fullstack-net \
  nginx
```

### Verify Communication
```bash
docker exec my-app ping -c 1 mysql-db  # SUCCESS!
```

**Result:** The app container successfully reached the database using the container name (`mysql-db`). This demonstrates:
1. Custom networking provides DNS-based service discovery
2. Named volumes persist database data
3. Containers can communicate by name without knowing IP addresses

---

## Summary

- **Volumes** solve data persistence - named volumes survive container removal
- **Bind mounts** map host directories into containers - great for development
- **Default bridge** allows IP-based communication only
- **Custom networks** provide DNS-based service discovery - containers can reach each other by name
- Combining volumes + custom networks = production-ready multi-container setup