# Day 36 – Dockerize a Full Application

# Introduction

Today I created a complete Dockerized Flask application with PostgreSQL database using Docker Compose.

This project helped me understand how real applications run using multiple containers together.

I learned:

* how to Dockerize a Flask app
* how to connect Flask with PostgreSQL
* how to use Docker Compose
* how to use volumes and networks
* how to push images to Docker Hub

---

# Project Used

I created a simple Python Flask application with PostgreSQL database.

The app has:

* Flask backend
* PostgreSQL database
* Dockerfile
* Docker Compose
* Environment variables
* Docker volume
* Custom Docker network

---

# Project Folder Structure

```text
day-36/
├── app/
│   ├── app.py
│   ├── requirements.txt
│   ├── Dockerfile
│   └── .dockerignore
│
├── docker-compose.yml
├── .env
├── README.md
└── day-36-docker-project.md
```

---

# Flask Application

## app.py

```python
from flask import Flask
import psycopg2
import os

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello Asma! Day 36 Dockerized Flask App is running."

@app.route("/db")
def db_check():
    try:
        conn = psycopg2.connect(
            host=os.getenv("DB_HOST"),
            database=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD")
        )
        conn.close()
        return "Database connection successful!"
    except Exception as e:
        return f"Database connection failed: {e}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

---

# requirements.txt

```text
flask==3.0.3
psycopg2-binary==2.9.9
```

---

# Dockerfile

```dockerfile
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN useradd -m appuser

USER appuser

EXPOSE 5000

CMD ["python", "app.py"]
```

---

# Dockerfile Explanation

## FROM python:3.12-slim

Uses lightweight Python image.

Slim images are smaller and faster.

---

## WORKDIR /app

Creates working directory inside container.

---

## COPY requirements.txt .

Copies requirements file into container.

---

## RUN pip install

Installs Flask and PostgreSQL dependencies.

---

## COPY . .

Copies project files into container.

---

## RUN useradd -m appuser

Creates non-root user for better security.

---

## USER appuser

Runs container using non-root user.

---

## EXPOSE 5000

Opens Flask application port.

---

## CMD ["python", "app.py"]

Starts Flask application.

---

# .dockerignore File

```text
__pycache__
*.pyc
.env
.git
.vscode
```

This helps reduce image size by ignoring unnecessary files.

---

# Environment Variables

## .env

```env
DB_HOST=db
DB_NAME=asma_db
DB_USER=asma
DB_PASSWORD=asma123

POSTGRES_DB=asma_db
POSTGRES_USER=asma
POSTGRES_PASSWORD=asma123
```

Environment variables help store configuration separately from code.

---

# Docker Compose File

## docker-compose.yml

```yaml
services:

  app:
    build: ./app

    container_name: day36-flask-app

    ports:
      - "5000:5000"

    env_file:
      - .env

    depends_on:
      db:
        condition: service_healthy

    networks:
      - day36-network

  db:
    image: postgres:16-alpine

    container_name: day36-postgres-db

    env_file:
      - .env

    volumes:
      - day36-postgres-data:/var/lib/postgresql/data

    networks:
      - day36-network

    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U asma -d asma_db"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  day36-postgres-data:

networks:
  day36-network:
    driver: bridge
```

---

# Docker Compose Explanation

## app service

Runs Flask application container.

---

## db service

Runs PostgreSQL database container.

---

## volumes

Used to save database data permanently.

Without volume, database data gets deleted when container is removed.

---

## networks

Creates custom Docker network for container communication.

---

## healthcheck

Checks if PostgreSQL database is healthy before Flask app starts.

---

# Build and Run Project

## Build Project

```bash
docker compose up --build
```

---

## Run in Background

```bash
docker compose up -d
```

---

## Check Running Containers

```bash
docker compose ps
```

---

# Application Testing

## Flask App

```text
http://localhost:5000
```

Output:

```text
Hello Asma! Day 36 Dockerized Flask App is running.
```

---

## Database Connection Test

```text
http://localhost:5000/db
```

Output:

```text
Database connection successful!
```

---

# Docker Hub Push

## Login

```bash
docker login
```

---

## Tag Image

```bash
docker tag day-36-app:latest asmasaiyed104/day-36-flask-app:v1
```

---

## Push Image

```bash
docker push asmasaiyed104/day-36-flask-app:v1
```

---

# Challenges I Faced

## 1. Wrong Folder Structure

Initially my files were in wrong folders.

I fixed the structure and moved:

* docker-compose.yml
* .env

into the correct directory.

---

## 2. requirements.txt Missing

Docker build failed because requirements.txt file was missing.

I created the file and added dependencies.

---

## 3. Typing Mistakes in Dockerfile

I made spelling mistakes like:

* requirement.txt
* no-catch-dir

I corrected them to:

* requirements.txt
* no-cache-dir

---

# What I Learned

Today I learned:

* how to Dockerize a real Flask app
* how to connect Flask with PostgreSQL
* how Docker Compose works
* how containers communicate
* how to use volumes and networks
* how to push images to Docker Hub

---

# Final Result

My Flask application and PostgreSQL database worked successfully together using Docker Compose.

The application was successfully Dockerized and pushed to Docker Hub.

---

# Conclusion

This project gave me real hands-on experience with Docker and Docker Compose.

I now understand how multi-container applications work in real DevOps environments.
