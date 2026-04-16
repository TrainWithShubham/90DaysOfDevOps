# 🐳 Docker Cheat Sheet
> By Mohammad Adnan Khan | 90DaysOfDevOps Day 37

---

## 📦 Core Concepts

| Concept | Description |
|---|---|
| **Image** | Blueprint/recipe to create containers. Like a class in programming. |
| **Container** | Running instance of an image. Like an object from a class. |
| **Dockerfile** | Instructions to build a Docker image. |
| **Docker Compose** | Tool to run multiple containers together using a YAML file. |
| **Volume** | Persistent storage that survives container restarts/deletions. |
| **Network** | Allows containers to communicate with each other. |
| **Registry** | Storage for Docker images. (Docker Hub is the default) |

---

## 🛠️ Dockerfile Instructions

| Instruction | Purpose | Example |
|---|---|---|
| `FROM` | Set base image | `FROM node:18-alpine` |
| `WORKDIR` | Set working directory inside container | `WORKDIR /app` |
| `COPY` | Copy files from host to container | `COPY package.json .` |
| `RUN` | Execute command during build | `RUN npm install` |
| `EXPOSE` | Document which port container listens on | `EXPOSE 5000` |
| `CMD` | Default command when container starts (overridable) | `CMD ["node","index.js"]` |
| `ENTRYPOINT` | Command that always runs (not overridable) | `ENTRYPOINT ["nginx"]` |
| `ENV` | Set environment variables | `ENV NODE_ENV=production` |
| `ARG` | Build-time variables | `ARG VERSION=1.0` |
| `VOLUME` | Create mount point for volumes | `VOLUME /data` |

---

## ⚡ CMD vs ENTRYPOINT

| | CMD | ENTRYPOINT |
|---|---|---|
| **Can override?** | ✅ Yes easily | ❌ Not easily |
| **Used for** | Default start commands | When container = executable |
| **Override example** | `docker run myapp npm test` | Must use `--entrypoint` flag |
| **Best for** | Web servers, APIs | CLI tools, scripts |

---

## 🏗️ Multi-Stage Build
```dockerfile
# Stage 1 - BUILD (big image, just for building)
FROM node:18-alpine AS BUILD
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Stage 2 - SERVE (tiny image, just for serving)
FROM nginx:alpine
COPY --from=BUILD /app/build /usr/share/nginx/html
EXPOSE 80
```

**Why?**
- Without multi-stage → ~800MB image 😱
- With multi-stage → ~25MB image ✅
- Stage 1 builds, Stage 2 serves. Only Stage 2 ends up in final image!

---

## ⚡ Docker Layer Caching
```dockerfile
# ✅ CORRECT - Cache friendly
COPY package.json .      # Layer 1 - only changes if dependencies change
RUN npm install          # Layer 2 - cached! only reruns if package.json changes
COPY . .                 # Layer 3 - your code changes here

# ❌ WRONG - Slow builds
COPY . .                 # copies everything first
RUN npm install          # reruns every time any file changes!
```

**Rule:** Copy dependency files first → install → copy code!

---

## 🐳 Essential Docker Commands

### Images
```bash
docker build -t myimage .              # Build image from Dockerfile
docker build -t myimage ./folder       # Build from specific folder
docker images                          # List all images
docker rmi myimage                     # Remove image
docker rmi $(docker images -q) -f      # Remove ALL images
docker pull nginx                      # Pull image from Docker Hub
docker push username/myimage           # Push image to Docker Hub
```

### Containers
```bash
docker run myimage                     # Run container
docker run -d myimage                  # Run in background (detached)
docker run -p 3000:80 myimage          # Map port host:container
docker run -e DB_HOST=mysql myimage    # Pass environment variable
docker ps                              # List running containers
docker ps -a                           # List all containers
docker stop container_id               # Stop container
docker rm container_id                 # Remove container
docker logs container_id               # See container logs
docker exec -it container_id sh        # Enter container shell
```

### Docker Compose
```bash
docker-compose up                      # Start all services
docker-compose up -d                   # Start in background
docker-compose down                    # Stop and remove containers
docker-compose down -v                 # Stop, remove containers + volumes
docker-compose logs backend            # See logs of specific service
docker-compose ps                      # List compose services
docker-compose build                   # Build/rebuild services
docker-compose restart                 # Restart all services
```

### Volumes & Networks
```bash
docker volume ls                       # List volumes
docker volume rm volume_name           # Remove volume
docker network ls                      # List networks
docker network inspect network_name    # Inspect network
```

---

## 📝 docker-compose.yml Structure
```yaml
version: "3.8"

services:
  mysql:
    image: mysql:8
    container_name: mysql_app
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: mydb
    volumes:
      - mysql-vol:/var/lib/mysql
      - ./mysql/init.sql:/docker-entrypoint-initdb.d/init.sql
    networks:
      - app-network
    ports:
      - "3306:3306"
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s

  backend:
    build: ./backend
    container_name: app-backend
    environment:
      DB_HOST: mysql
      DB_USER: root
      DB_PASSWORD: password
      DB_NAME: mydb
    networks:
      - app-network
    ports:
      - "5000:5000"
    depends_on:
      mysql:
        condition: service_healthy

  frontend:
    build: ./frontend
    container_name: app-frontend
    ports:
      - "3000:80"
    networks:
      - app-network
    depends_on:
      - backend

networks:
  app-network:
    driver: bridge

volumes:
  mysql-vol:
```

---

## 🌐 Docker Networking

| Network Type | Description | Use Case |
|---|---|---|
| **bridge** | Default. Containers on same host communicate | Most common, local dev |
| **host** | Container shares host network | Performance critical apps |
| **none** | No network | Isolated containers |

**Key Rule:** Containers on same network talk using **service names** not `localhost`!
```yaml
DB_HOST: mysql        # ✅ service name
DB_HOST: localhost    # ❌ looks inside itself!
```

---

## 💾 Docker Volumes

| Type | Description | Example |
|---|---|---|
| **Named Volume** | Managed by Docker, persists data | `mysql-vol:/var/lib/mysql` |
| **Bind Mount** | Maps host path to container path | `./init.sql:/docker-entrypoint-initdb.d/init.sql` |

**When to use volumes:**
- ✅ Databases (MySQL, MongoDB, PostgreSQL)
- ❌ Frontend (static files in image)
- ❌ Backend (stateless, data goes to DB)

---

## 🏥 Healthcheck
```yaml
healthcheck:
  test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
  interval: 10s
  timeout: 5s
  retries: 5
  start_period: 30s
```

**Why?** `depends_on` alone only waits for container to START, not to be READY!

---

## 🔑 Key Concepts to Remember

1. **Image vs Container** → Image is blueprint, Container is running instance
2. **Layer Caching** → Copy dependencies first, then code = faster builds
3. **Multi-stage** → Build in big image, serve in tiny image = smaller final image
4. **DB_HOST = service name** → Each container has its own localhost!
5. **Volumes** → Only for services that write data (databases)
6. **Healthcheck** → Ensures service is READY, not just started
7. **Bridge Network** → Containers communicate using service names as DNS

---

## 🚀 Quick Reference - Todo App
```bash
docker build -t todo-backend ./backend
docker build -t todo-frontend ./frontend
docker-compose up -d
docker ps
docker-compose logs backend
docker-compose down -v
docker rmi $(docker images -q) -f
```

---

*Made with ❤️ during 90DaysOfDevOps Challenge*
*GitHub: [@AddyKhan257](https://github.com/AddyKhan257)*
