# Day 36 – Docker Project: Dockerizing a Flask Task Manager App

## What App I Chose and Why

I chose the **Task Manager** app — a Python Flask CRUD application with a SQLite database (migrated to PostgreSQL for Docker Compose).

**Why:** It's a real-world app with a web server, database dependency, and environment configuration — covering all the key Docker concepts: multi-stage builds, networking, volumes, and healthchecks.

**Repo:** https://github.com/kashyapkr/Task-Manager  
**Docker Hub:** https://hub.docker.com/r/akashjaura16/task-manager

---

## Project Structure

```
Task-Manager/
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── .env
├── requirements.txt
├── app.py
└── templates/
```

---

## Dockerfile (with comments)

```dockerfile
# Stage 1: Builder — install dependencies in isolation
FROM python:3.9-slim AS builder

WORKDIR /app

# Copy only requirements first (layer caching — only reinstalls if requirements change)
COPY requirements.txt .

# Install packages system-wide, no cache to keep image small
RUN pip install --no-cache-dir -r requirements.txt


# Stage 2: Production — clean final image
FROM python:3.9-slim AS production

# Create a system group and non-root user for security
# --system = no password, no login shell, UID under 1000
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

WORKDIR /app

# Copy installed packages from builder stage (not the whole builder image)
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy application source code
COPY . .

# Give ownership of app files to non-root user
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

# Document the port the app listens on
EXPOSE 5000

# Start the application
CMD ["python", "app.py"]
```

---

## .dockerignore

```
__pycache__
*.pyc
*.pye
.env
.git
.gitignore
*.md
```

---

## docker-compose.yml

```yaml
services:
  web:
    build: .
    ports:
      - "5000:5000"
    networks:
      - custom_network
    env_file:
      - .env
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:5000"]
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    depends_on:
      - db

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: password
      POSTGRES_DB: tododb
    volumes:
      - db_data:/var/lib/postgresql/data
    networks:
      - custom_network
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "admin", "-d", "tododb"]
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s

volumes:
  db_data:

networks:
  custom_network:
    driver: bridge
```

---

## Environment Variables (.env)

```env
FLASK_APP=app.py
FLASK_ENV=production
PORT=5000
```

---

## Challenges Faced and How I Solved Them

| Challenge | Root Cause | Fix |
|---|---|---|
| `package.json not found` | Running `docker build` from wrong directory | `cd` into repo folder first |
| App not reachable in browser | Flask binding to `127.0.0.1` inside container | Changed to `host='0.0.0.0'` in `app.py` |
| `port already allocated` | Old container still using port 5000 | `docker stop $(docker ps -q)` |
| `-p` and `-d` flag order error | Flags in wrong order | Always use `docker run -d -p` not `-p -d` |
| `No module named flask` | Volume `- .:/app` overwrote installed packages | Removed volume from web service |
| `database "admin" does not exist` | `pg_isready` defaulting to wrong DB name | Added `-d tododb` to healthcheck |
| `healthcheck` key duplicated | Typo in docker-compose.yml | Removed duplicate key |
| `-S` and `-G` flags failing | Alpine flags used on slim (Debian) image | Switched to `--system` and `--ingroup` |
| `COPY . .` missing in Dockerfile | Source code never copied into container | Added `COPY . .` to production stage |

---

## Troubleshooting Checklist (learned today)

```
1. docker ps                    → is container running?
2. docker ps -a                 → did it crash?
3. docker logs <id>             → what error?
4. netstat -ano | findstr :5000 → is port listening?
5. docker exec -it <id> sh      → go inside container
```

---

## Final Image Size

```bash
docker images akashjaura16/task-manager
```
Base image `python:3.9-slim` + app ≈ ~150MB (vs ~1GB with full python image)

---

## How to Run

```bash
# Clone
git clone https://github.com/kashyapkr/Task-Manager
cd Task-Manager

# Run
docker compose up

# Visit
http://localhost:5000
```

### Pull from Docker Hub

```bash
docker pull akashjaura16/task-manager:latest
docker compose up
```

---

## Key Learnings

- **Multi-stage builds** keep final images clean — builder stage installs, production stage runs
- **Non-root users** improve container security — system accounts have no shell or password
- **`host='0.0.0.0'`** is required in Flask for the app to be reachable outside the container
- **YAML indentation** is critical in docker-compose.yml — one wrong space breaks everything
- **`docker system prune -a`** is the fastest way to clean up everything
- **`docker ps -aq`** gives container IDs, **`docker images -q`** gives image IDs — they are different!
