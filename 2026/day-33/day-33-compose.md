# Day 33 – Docker Compose: Multi-Container Basics

## Task 1: Install & Verify

```bash
# Check if Docker Compose is available
docker compose version

# Output:
Docker Compose version v2.x.x
```

---

## Task 2: Your First Compose File

### Create directory and docker-compose.yml
```bash
mkdir -p compose-basics
cd compose-basics
```

### docker-compose.yml
```yaml
version: '3.8'

services:
  nginx:
    image: nginx
    ports:
      - "8080:80"
    container_name: my-nginx
```

### Commands
```bash
# Start the service
docker compose up -d

# Verify it's running
docker compose ps

# Access in browser: http://localhost:8080

# Stop and remove
docker compose down
```

---

## Task 3: Two-Container Setup (WordPress + MySQL)

### docker-compose.yml
```yaml
version: '3.8'

services:
  db:
    image: mysql:8
    container_name: wordpress-db
    environment:
      MYSQL_ROOT_PASSWORD: mysecretpassword
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wpuser
      MYSQL_PASSWORD: wppassword
    volumes:
      - mysql-data:/var/lib/mysql
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 5

  wordpress:
    image: wordpress:latest
    container_name: wordpress-app
    depends_on:
      db:
        condition: service_healthy
    ports:
      - "8080:80"
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wpuser
      WORDPRESS_DB_PASSWORD: wppassword
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - ./wordpress-data:/var/www/html

volumes:
  mysql-data:
```

### Commands
```bash
# Start both services
docker compose up -d

# View services
docker compose ps

# Access WordPress at http://localhost:8080
# Complete WordPress setup wizard
```

### Verify Data Persistence
```bash
# Stop services (but keep volumes)
docker compose down

# Start again
docker compose up -d

# WordPress data persists!
```

---

## Task 4: Compose Commands

| Command | Description |
|---------|-------------|
| `docker compose up -d` | Start in detached mode |
| `docker compose ps` | View running services |
| `docker compose logs` | View all logs |
| `docker compose logs -f` | Follow logs in real-time |
| `docker compose logs nginx` | View specific service logs |
| `docker compose stop` | Stop without removing |
| `docker compose down` | Remove containers and networks |
| `docker compose down -v` | Remove everything including volumes |
| `docker compose build` | Rebuild images after changes |
| `docker compose build --no-cache` | Force rebuild without cache |
| `docker compose restart` | Restart all services |
| `docker compose restart nginx` | Restart specific service |

---

## Task 5: Environment Variables

### Method 1: Direct in docker-compose.yml
```yaml
services:
  app:
    image: myapp
    environment:
      - DB_HOST=localhost
      - DB_PORT=5432
```

### Method 2: Using .env file

#### Create .env file
```bash
# .env
DB_HOST=db
DB_PORT=3306
DB_USER=myuser
DB_PASSWORD=mypassword
```

#### Reference in docker-compose.yml
```yaml
version: '3.8'

services:
  app:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: ${DB_PASSWORD}
      MYSQL_DATABASE: myapp
    env_file:
      - .env
```

### Verify Variables
```bash
# Check environment variables in running container
docker compose exec app env

# Or check specific variable
docker compose exec app printenv DB_HOST
```

---

## Summary

- **Docker Compose** orchestrates multi-container applications with a single YAML file
- **Services** in compose are the DNS names containers use to communicate
- **Volumes** persist data across `compose down` and `compose up`
- **Networks** are automatically created for all services
- **Environment variables** can be set directly or via `.env` file
- **Key commands**: `up`, `down`, `logs`, `ps`, `stop`, `build`

### Common Workflow
```bash
# First time
docker compose up -d

# After edits
docker compose down
docker compose up -d

# Or rebuild without down
docker compose build
docker compose up -d

# View logs
docker compose logs -f
```