# 📝 Day 37 - Docker Revision & Self-Check
> By Mohammad Adnan Khan | 90DaysOfDevOps

---

## ✅ Self-Check Questions & Answers

### Q1: What is the difference between a Docker Image and a Container?

**Answer:**
- **Docker Image** is a blueprint/recipe used to create containers. It is read-only and contains everything needed to run an app — code, runtime, dependencies, and configs. Like a class in programming.
- **Docker Container** is a running instance of an image. It is lightweight because it shares the host OS kernel instead of using a hypervisor like a VM. Like an object created from a class.

> 💡 Key difference: Image = static blueprint. Container = running process.

---

### Q2: What is a Dockerfile? Name 5 instructions with their purpose.

**Answer:**
A Dockerfile is a text file with instructions to build a Docker image step by step.

| Instruction | Purpose |
|---|---|
| `FROM` | Sets the base image (e.g., node:18-alpine) |
| `WORKDIR` | Creates and sets working directory inside container |
| `COPY` | Copies files from host machine into container |
| `RUN` | Executes commands during image build (e.g., npm install) |
| `CMD` | Sets default command to run when container starts |
| `EXPOSE` | Documents which port the container listens on |

---

### Q3: What is Docker Layer Caching? Why do we COPY package.json before COPY . .?

**Answer:**
Docker builds images in layers and caches each layer. If a layer hasn't changed, Docker reuses the cached version instead of rebuilding it.

We copy `package.json` first because:
1. `package.json` contains the list of all dependencies
2. If we `COPY . .` first, any code change triggers `npm install` again (slow!)
3. By copying `package.json` first → `npm install` layer is cached → only reruns when dependencies actually change
4. Then `COPY . .` copies our code changes → much faster builds!
```dockerfile
COPY package.json .   # cached unless dependencies change
RUN npm install       # cached! only reruns if package.json changes
COPY . .              # only this layer rebuilds when code changes
```

---

### Q4: What is the difference between CMD and ENTRYPOINT?

**Answer:**

| | CMD | ENTRYPOINT |
|---|---|---|
| Can override? | ✅ Yes | ❌ No |
| Used for | Default commands, web servers | Executable containers |
| Override how | `docker run myapp npm test` | Must use `--entrypoint` flag |

- **CMD** = a suggestion. "Run this by default but you can change it"
- **ENTRYPOINT** = a rule. "Always run this no matter what"

We used `CMD ["node","index.js"]` in our backend because we want flexibility to override it for debugging.

---

### Q5: What is a Multi-Stage Dockerfile? Why did we use it for frontend?

**Answer:**
A multi-stage Dockerfile uses multiple `FROM` statements. Each `FROM` starts a new stage.

**Why for frontend:**
- Stage 1 uses `node:18-alpine` to BUILD the React app → creates `/app/build` folder with HTML/CSS/JS
- Stage 2 uses `nginx:alpine` to SERVE those built files
- Final image only contains Stage 2 (tiny Nginx + built files)
- Result: ~25MB instead of ~800MB!
```dockerfile
# Stage 1 - Build (thrown away after)
FROM node:18-alpine AS BUILD
RUN npm run build

# Stage 2 - Serve (final image)
FROM nginx:alpine
COPY --from=BUILD /app/build /usr/share/nginx/html
```

---

### Q6: What is Docker Compose and why do we need it?

**Answer:**
Docker Compose is a tool to define and run multi-container applications using a single YAML file (`docker-compose.yml`).

Instead of running 3 separate `docker run` commands for frontend, backend, and MySQL — we write one `docker-compose.yml` and run:
```bash
docker-compose up
```

It handles:
- Building images
- Creating networks
- Setting up volumes
- Passing environment variables
- Managing startup order with `depends_on`

---

### Q7: Why is DB_HOST: mysql and not DB_HOST: localhost?

**Answer:**
Each Docker container has its own isolated network namespace with its own `localhost`. If backend uses `DB_HOST: localhost`, it looks for MySQL **inside itself** — which doesn't exist!

In Docker networks, containers are reachable by their **service name**. Docker acts as a DNS server — `mysql` resolves to the IP of the MySQL container automatically.
```yaml
DB_HOST: mysql      # ✅ finds MySQL container by service name
DB_HOST: localhost  # ❌ looks inside backend container itself!
```

---

### Q8: What is a Docker Volume? Why did only MySQL need one?

**Answer:**
A Docker volume is persistent storage that exists outside the container. Data stored in a volume survives container deletion and restarts.

**Why only MySQL:**
- **MySQL** writes all data (tables, rows) to disk → without volume, deleting container = losing all data forever! ❌
- **Backend** is stateless — processes requests and sends data to MySQL, nothing stored locally ✅
- **Frontend** static files are baked into the image — no dynamic data to persist ✅

> Rule: Any service that writes data to disk needs a volume!

---

### Q9: What does this line do in docker-compose.yml?
```yaml
- ./mysql/init.sql:/docker-entrypoint-initdb.d/init.sql
```

**Answer:**
This is a **bind mount** that maps a local file into a special MySQL folder.

- `./mysql/init.sql` → SQL file on our local machine
- `/docker-entrypoint-initdb.d/` → Special folder inside MySQL container. Any `.sql` file placed here is **automatically executed** by MySQL on first startup.

So when MySQL container starts for the first time:
1. It finds `init.sql` in that special folder
2. Runs it automatically
3. Creates `tododb` database ✅
4. Creates `todos` table ✅
5. Inserts sample data ✅

---

### Q10: What is a Healthcheck in Docker Compose? Why did we add it to MySQL?

**Answer:**
A healthcheck periodically checks if a service is actually ready to accept connections (not just started).
```yaml
healthcheck:
  test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
  interval: 10s
  timeout: 5s
  retries: 5
  start_period: 30s
```

**Why MySQL needs it:**
- `depends_on` alone only waits for the container to START
- MySQL takes time to initialize even after starting
- Without healthcheck → backend tries to connect before MySQL is ready → crash! ❌
- With healthcheck → backend waits until MySQL passes health check → connects successfully ✅

We used `condition: service_healthy` in backend's `depends_on` to ensure proper startup order.

---

## 📊 My Revision Score

| Question | Topic | Score |
|---|---|---|
| Q1 | Image vs Container | ✅ 10/10 |
| Q2 | Dockerfile Instructions | ✅ 10/10 |
| Q3 | Layer Caching | ✅ 9/10 |
| Q4 | CMD vs ENTRYPOINT | ⚠️ 6/10 (forgot details) |
| Q5 | Multi-Stage Build | ✅ 9/10 |
| Q6 | Docker Compose | ✅ 10/10 |
| Q7 | DB_HOST service name | ✅ 10/10 |
| Q8 | Volumes | ✅ 8/10 |
| Q9 | init.sql mount | ✅ 9/10 |
| Q10 | Healthcheck | ✅ 10/10 |

**Overall: 9.1/10** 🔥

---

## 🎯 Key Takeaways from Days 29-36

1. Docker solves "works on my machine" problem by packaging app + environment together
2. Always use Alpine base images for smaller image sizes
3. Layer caching = copy dependencies first, then code
4. Multi-stage builds = build in big image, serve in tiny image
5. Never use localhost for inter-container communication — use service names!
6. Volumes = only for stateful services (databases)
7. Healthchecks = ensure services are READY not just started
8. docker-compose = one command to rule them all 🔥

---

## 🔗 References
- GitHub: [AddyKhan257/To-Do-App](https://github.com/AddyKhan257/To-Do-App)
- Docker Hub: [mohammadadnankhan](https://hub.docker.com/u/mohammadadnankhan)
- LinkedIn: [Mohammad Adnan Khan](https://www.linkedin.com/in/mohammad-adnan-khan-8099802b1)

---

*Day 37 of 90DaysOfDevOps Challenge*
*#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham*
