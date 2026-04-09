
# Day 33 – Docker Compose: Multi-Container Basics
## Task 1: Install & Verify

`docker compose --version`

**Output**
```
Docker version 28.2.2, build 28.2.2-0ubuntu1~24.04.1
```

---

## Task 2: Your First Compose File

[docker-compose-file](/2026/day-33/compose-basics/docker-compose.yml%20)

**Command used**
`docker-compose up -d` >`for docker compose v1`

`docker compose up -d` >`for docker compose v1`

`docker-compose stop` >`for docker compose v1`

`docker compose stop` >`for docker compose v1`

---

## Task 3: Two-Container Setup
[docker-compose-file](/2026/day-33/mysql-wordpress/docker-compose.yml)

### Explanation:

Both services are on the same network **mysql_word** (Compose creates it automatically).

MySQL uses a named volume **mysql_db1** for persistence.

WordPress uses **wp_data** volume to store uploaded files and themes.

The depends_on ensures the database starts before WordPress, but doesn’t wait for it to be ready (WordPress will retry).

---

## Task 4: Compose Commands
- Detached start: `docker compose up -d`
- View services: `docker compose ps`
- All logs: `docker compose logs -f`
- Specific logs: `docker compose logs -f wordpress`
- Stop without remove: `docker compose stop`
- Full remove: `docker compose down`
- Rebuild: `docker compose up -d --build` (after Dockerfile changes)

---

## Task 5: Environment Variables
