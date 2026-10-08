# Docker Compose Notes

## What is Docker Compose?

Docker Compose is a tool used to run multiple Docker containers together using one YAML file.

Instead of writing many `docker run` commands, we write everything inside one file:

```yaml
compose.yaml
```

Then we run:

```bash
docker compose up
```

and all containers start together.

---

# Why We Use Docker Compose

Docker Compose helps us:

- Run multiple containers together
- Manage complete applications
- Connect containers easily
- Save time
- Simplify development

---

# Example

Suppose an application needs:

- Frontend
- Backend
- Database

Docker Compose can run all of them together.

---

# Basic Structure

```yaml
services:
```

All containers are written under `services`.

---

# Simple Example

```yaml
services:
  web:
    image: nginx

    ports:
      - "80:80"

  db:
    image: mysql:8
```

This creates:

- Nginx container
- MySQL container

---

# Important Keywords

## services

Defines containers.

Example:

```yaml
services:
  app:
  db:
```

---

## image

Downloads image from Docker Hub.

Example:

```yaml
image: nginx
```

---

## build

Builds image using Dockerfile.

Example:

```yaml
build: .
```

Meaning:

- Use Dockerfile from current folder

---

## ports

Maps laptop port to container port.

Syntax:

```yaml
ports:
  - "HOST:CONTAINER"
```

Example:

```yaml
ports:
  - "5000:5000"
```

Meaning:

- localhost:5000 connects to container port 5000

---

## container_name

Gives custom container name.

Example:

```yaml
container_name: asma-app
```

---

## environment

Used for environment variables.

Example:

```yaml
environment:
  MYSQL_ROOT_PASSWORD: admin123
```

---

## volumes

Used to save data permanently.

Without volume:

- data deletes when container deletes

With volume:

- data stays safe

Example:

```yaml
volumes:
  - mysql-data:/var/lib/mysql
```

---

## depends_on

Starts containers in order.

Example:

```yaml
depends_on:
  - db
```

Meaning:

- app starts after database container

---

## networks

Containers communicate using service names.

Example:

```text
db
```

NOT:

```text
localhost
```

---

# Full Example

```yaml
services:
  app:
    build: .

    container_name: python-app

    ports:
      - "5000:5000"

    depends_on:
      - db

  db:
    image: mysql:8

    container_name: mysql-db

    environment:
      MYSQL_ROOT_PASSWORD: admin123

    ports:
      - "3306:3306"
```

---

# Common Commands

## Start Containers

```bash
docker compose up
```

---

## Build and Start

```bash
docker compose up --build
```

---

## Run in Background

```bash
docker compose up -d
```

---

## Stop Containers

```bash
docker compose down
```

---

## Check Running Containers

```bash
docker compose ps
```

---

## Check Logs

```bash
docker compose logs
```

---

# Dockerfile vs Docker Compose

| Dockerfile          | Docker Compose            |
| ------------------- | ------------------------- |
| Builds image        | Runs containers           |
| Single container    | Multiple containers       |
| Defines image steps | Defines application stack |

---

# Workflow

1. Create application
2. Write Dockerfile
3. Write compose.yaml
4. Run:

```bash
docker compose up --build
```

5. Application starts successfully

---

# Best Practices

- Use volumes
- Use environment variables
- Use proper container names
- Keep YAML indentation correct

---

# Summary

Docker Compose helps developers and DevOps engineers manage multi-container applications easily using one YAML file.
