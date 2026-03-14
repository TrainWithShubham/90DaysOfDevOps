# 🐳 Docker Quick-Fire Questions – Revision

These are quick revision questions to test understanding of core Docker concepts.

---

# 1️⃣ What is the difference between an image and a container?

**Docker Image**  
A **read-only template** used to create containers.

**Docker Container**  
A **running instance of a Docker image**.

### Example

- Image = Blueprint 📦  
- Container = Running application 🚀  

```bash
docker run nginx
```

Here **nginx** is the image and the **running instance is the container**.

---

# 2️⃣ What happens to data inside a container when you remove it?

When a container is removed, **all data inside the container is deleted**.

Data is **not persistent** unless you use:

- Volumes
- Bind mounts

### Example

Remove container

```bash
docker rm mycontainer
```

Preserve data using volume

```bash
docker run -v myvolume:/data nginx
```

---

# 3️⃣ How do two containers on the same custom network communicate?

Containers on the same **custom Docker network communicate using container names as hostnames**.

### Example

```bash
docker network create mynet

docker run -d --name web --network mynet nginx

docker run -it --name client --network mynet ubuntu bash
```

Inside the **client container**

```bash
ping web
```

Docker provides **automatic DNS resolution**.

---

# 4️⃣ What does `docker compose down -v` do differently from `docker compose down`?

### `docker compose down`

- Stops containers  
- Removes containers  
- Removes networks  

### `docker compose down -v`

- Stops containers  
- Removes containers  
- Removes networks  
- **Removes volumes (data deleted)**  

```bash
docker compose down -v
```

⚠️ This **deletes persistent data stored in volumes**.

---

# 5️⃣ Why are multi-stage builds useful?

Multi-stage builds help to:

- Reduce image size
- Remove unnecessary build tools
- Improve security
- Make production images lighter

### Example

```dockerfile
FROM node:18 as builder

WORKDIR /app
COPY . .
RUN npm install

FROM node:18-alpine

COPY --from=builder /app /app
CMD ["node","app.js"]
```

### Result

- Builder tools removed
- Final image much smaller

---

# 6️⃣ What is the difference between `COPY` and `ADD`?

| Feature | COPY | ADD |
|------|------|------|
| Basic file copy | ✅ | ✅ |
| Extract tar files | ❌ | ✅ |
| Download from URL | ❌ | ✅ |
| Recommended for most cases | ✅ | ❌ |

### COPY Example

```dockerfile
COPY app.py /app/
```

### ADD Example

```dockerfile
ADD file.tar.gz /app/
```

✅ **Best practice:** Use `COPY` unless ADD features are required.

---

# 7️⃣ What does `-p 8080:80` mean?

It maps **host port → container port**

```
host_port : container_port
```

### Example

```bash
docker run -p 8080:80 nginx
```

### Meaning

- Access application at **localhost:8080**
- Traffic is forwarded to **container port 80**

### Flow

```
Browser → localhost:8080 → container:80
```

---

# 8️⃣ How do you check how much disk space Docker is using?

Use the command:

```bash
docker system df
```

This shows:

- Images size
- Containers size
- Volumes size
- Build cache

### Example Output

```
TYPE            TOTAL     ACTIVE     SIZE
Images          5         3          2.3GB
Containers      4         2          500MB
Volumes         3         2          1.2GB
```

### Clean unused Docker resources

```bash
docker system prune
```

---

# 📚 Summary

This quick revision covers:

- Docker Images vs Containers
- Data persistence
- Networking
- Docker Compose
- Multi-stage builds
- COPY vs ADD
- Port mapping
- Docker disk usage