# Day 33 – Docker Compose: Multi-Container Basics

---

## Task 1: Install & Verify Docker Compose

### 1. Check if Docker Compose is available

```bash
docker compose version
```

> Note: Modern Docker uses `docker compose` (space), not `docker-compose` (hyphen).

### 2. Verify version

If not installed:
* Install Docker Desktop (includes Compose), or
* On Linux:
```bash
sudo apt install docker-compose-v2
```
---

## Task 2: Your First Compose File (Nginx)

### 1. Create project folder

```bash
mkdir compose-basics
cd compose-basics
```

### 2. Create `docker-compose.yml`

```yaml
services:
  web:
    image: nginx:latest
    ports:
      - "8080:80"
```

### 3. Start container

```bash
docker compose up
```

### 4. Access in browser

```
http://localhost:8080
```

You should see the default Nginx welcome page.

### 5. Stop and remove

```bash
docker compose down
```

---

## Task 3: Two-Container Setup (WordPress + MySQL)

### 1. Create `docker-compose.yml`

```yaml
services:
  mysql_db:
    image: mysql:8.0
    container_name: wordpress-db
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: rootpass
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wpuser
      MYSQL_PASSWORD: wppass
    volumes:
      - db_data:/var/lib/mysql

  wordpress:
    image: wordpress:latest
    container_name: wordpress-app
    depends_on:
      - mysql_db
    ports:
      - "8081:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wpuser
      WORDPRESS_DB_PASSWORD: wppass
      WORDPRESS_DB_NAME: wordpress

volumes:
  db_data:
```

### Key Concepts

* `mysql_db` is the hostname WordPress uses → **service name = DNS entry**
* `db_data` ensures persistence

---

### 2. Start services

```bash
docker compose up -d
```

### 3. Access WordPress

```
http://localhost:8081
```

Complete setup via browser.

---

### 4. Verify persistence

Stop:

```bash
docker compose down
```

Start again:

```bash
docker compose up -d
```

 Your WordPress site should still be configured — this confirms the volume works.

---

# **Task 4: Compose Commands (Practice + Reference)**

### Start in detached mode

```bash
docker compose up -d
```

### View running services

```bash
docker compose ps
```

### View logs (all services)

```bash
docker compose logs
```

### View logs (specific service)

```bash
docker compose logs wordpress
docker compose logs mysql_db
```

### Follow logs (real-time)

```bash
docker compose logs -f
```

### Stop services (keep containers)

```bash
docker compose stop
```

### Remove everything (containers + networks)

```bash
docker compose down
```

### Remove everything including volumes (⚠ destructive)

```bash
docker compose down -v
```

### Rebuild images

```bash
docker compose up --build
```

---

# **Task 5: Environment Variables**

## Option A: Inline in `docker-compose.yml`

```yaml
environment:
  MYSQL_ROOT_PASSWORD: rootpass
```

---

## Option B: Use `.env` file

### 1. Create `.env`

```
MYSQL_ROOT_PASSWORD=rootpass
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=wppass
```

---

### 2. Reference in `docker-compose.yml`

```yaml
services:
  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
```

---

### 3. Verify variables are picked up

Run:

```bash
docker compose config
```

This resolves and prints the final configuration with substituted values.

You can also inspect inside container:

```bash
docker exec -it wordpress-db env | grep MYSQL
```

---

## What You Should Have Proven

* Compose is installed and working
* You can orchestrate containers declaratively
* Services communicate via internal DNS
* Volumes persist data across restarts
* You can control lifecycle and logs
* You understand environment variable injection

---

