---

# Docker Compose: Real-World Multi-Container Apps

---

---

## Task 1: 🚀 3-Tier Flask Application Stack using Docker Compose on AWS (t3.micro)

---

### 📌 Project Overview

In this project, I built and deployed a lightweight 3-tier application stack on an AWS EC2 `t3.micro` instance using Docker and Docker Compose.

The stack consists of:

- 🌐 Flask Web Application  
- 🐘 PostgreSQL Database  
- 🔴 Redis Cache  

All services are containerized and connected using Docker Compose networking.

---

### 🧱 1️⃣ Application Layer – Flask App

I wrote a simple Flask application that:

- Reads environment variables  
- Connects to PostgreSQL  
- Connects to Redis  
- Displays connection status in the browser  

The app listens on:

    http://<EC2-PUBLIC-IP>:5000

---

### 🐳 2️⃣ Dockerfile – Building the App Image

I created a custom Dockerfile to containerize the Flask application.

### 🔹 Base Image

    FROM python:3.12-alpine

- Lightweight Alpine image  
- Optimized for low-memory AWS t3.micro  

---

#### 🔹 Working Directory

    WORKDIR /app

Sets the working directory inside the container.

---

#### 🔹 Install System Dependencies

    RUN apk add --no-cache gcc musl-dev postgresql-dev

Required to compile `psycopg2` (PostgreSQL driver).

---

#### 🔹 Install Python Dependencies

    COPY requirements.txt .
    RUN pip install --no-cache-dir -r requirements.txt

Dependencies include:

- Flask  
- psycopg2-binary  
- redis  

---

#### 🔹 Copy Application Code

    COPY app.py .

---

#### 🔹 Expose Port & Run App

    EXPOSE 5000
    CMD ["python", "app.py"]

This runs the Flask application when the container starts.

---

### ⚙️ 3️⃣ Docker Compose – Orchestration Layer

I created a `docker-compose.yml` file defining three services:

---

#### 🐘 Database Service (PostgreSQL)

- Image: `postgres:16-alpine`  
- Restart policy: `always`  
- Environment variables loaded from `.env`  
- Named volume for data persistence  

    database:
      image: postgres:16-alpine
      restart: always
      environment:
        POSTGRES_DB: ${POSTGRES_DB}
        POSTGRES_USER: ${POSTGRES_USER}
        POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      volumes:
        - postgres-data:/var/lib/postgresql/data

---

#### 🔴 Redis Service

- Image: `redis:alpine`  
- Restart policy: `always`  

    redis:
      image: redis:alpine
      restart: always

---

#### 🌐 Web Service (Flask)

- Built from local Dockerfile (`build: ./app`)  
- Restart policy: `always`  
- Port mapping: `5000:5000`  
- `depends_on` for startup order  
- Environment variables for internal service communication  

    web:
      build: ./app
      restart: always
      ports:
        - "5000:5000"
      depends_on:
        - database
        - redis
      environment:
        DB_HOST: database
        DB_NAME: ${POSTGRES_DB}
        DB_USER: ${POSTGRES_USER}
        DB_PASSWORD: ${POSTGRES_PASSWORD}
        REDIS_HOST: redis

---

### 📁 Environment Variables (.env)

Created a `.env` file in the root directory (same location as docker-compose.yml):

    POSTGRES_DB=flaskdb
    POSTGRES_USER=flaskuser
    POSTGRES_PASSWORD=Flask@123

This ensures:

- Clean separation of configuration  
- No hardcoded secrets in compose file  
- Easier environment switching  

---

### 🔗 Internal Networking

Docker Compose automatically creates a default network.

Service names act as DNS hostnames:

- `database` → PostgreSQL container  
- `redis` → Redis container  

Flask connects using:

    DB_HOST=database
    REDIS_HOST=redis

Not `localhost`.

---

### 💾 Data Persistence

A named volume is used:

    volumes:
      postgres-data:

PostgreSQL data is stored in:

    /var/lib/postgresql/data

This ensures:

- Data is not lost after container restart  
- Safe persistence across deployments  

---

### 🏗 Final Architecture

    Browser
       ↓
    Flask (web container)
       ↓
    PostgreSQL (database container)
       ↓
    Redis (cache container)

---

### 🎯 Key Learnings

- Difference between Dockerfile and Docker Compose  
- How to build custom application images  
- How container networking works (service-name DNS)  
- Importance of environment variables  
- Named volumes for persistence  
- Deploying containerized apps on AWS EC2  
- Lightweight optimization for t3.micro  

---

### 🚀 Result

Successfully deployed a working 3-tier application stack on AWS t3.micro with:

- Application container  
- Database container  
- Cache container  
- Persistent storage  
- Proper networking  
- Production-style configuration management  

---

## Task 2: depends_on & Healthchecks

---

### 🔄 Adding Healthcheck and Conditional Startup in Docker Compose

### 📌 Overview

We enhanced the existing docker-compose.yml file to ensure that the web application starts only after the database is truly ready, not just started.

This prevents race conditions where the web app attempts to connect to the database before it is ready to accept connections.

---

### 🐘 1️⃣ Added Healthcheck to Database Service

We added a healthcheck block inside the database service.

The healthcheck:

- Uses pg_isready to check if PostgreSQL is accepting connections
- Runs every 5 seconds
- Waits up to 3 seconds for each attempt
- Retries 5 times before marking the container as unhealthy

#### Example Configuration

    database:
      image: postgres:16-alpine
      restart: always
      environment:
        POSTGRES_DB: ${POSTGRES_DB}
        POSTGRES_USER: ${POSTGRES_USER}
        POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      volumes:
        - postgres-data:/var/lib/postgresql/data
      healthcheck:
        test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
        interval: 5s
        timeout: 3s
        retries: 5

#### What This Does

- Verifies database readiness using pg_isready
- Ensures the container is not just running, but actually ready to accept connections
- Prevents dependent services from starting too early

---

### 🌐 2️⃣ Updated Web Service depends_on

Previously, the configuration only ensured startup order:

    depends_on:
      - database
      - redis

This only guaranteed that containers start in sequence, not that the database is ready.

We updated it to:

    depends_on:
      database:
        condition: service_healthy
      redis:
        condition: service_started

#### What This Achieves

- The web service waits until:
  - The database service is marked as healthy
  - The Redis service has at least started
- Prevents startup race conditions
- Avoids connection errors during initialization

---

### 🚀 Final Result

With this configuration:

- PostgreSQL starts
- Healthcheck verifies readiness
- Once the database becomes healthy, the web service starts
- Redis only needs to be started, not fully health-verified
- The web application no longer fails due to early database connection attempts

---

### 🎯 Key Learning

- depends_on alone ensures only startup order
- Healthchecks ensure true service readiness
- condition: service_healthy makes dependent services wait properly
- This improves reliability and mimics production-grade behavior

---

### 🧠 Important Note

This configuration controls startup behavior only.

If PostgreSQL becomes unhealthy after the web service has already started:

- Docker Compose will not automatically stop the web service
- The web application must handle runtime failures independently
- Full runtime orchestration requires tools like Kubernetes

## Task 3: Docker Restart Policies – Practical Task Documentation

### 📌 Objective

In this task, I practiced and tested Docker restart policies in a 3-tier application stack (Flask + PostgreSQL + Redis) running on AWS EC2 (t3.micro).

The goal was to:

- Configure restart policies (`always` and `on-failure`)
- Simulate container crashes
- Observe restart behavior
- Compare differences between restart strategies
- Understand production implications

---

### 🧱 Restart Policy Configuration

Updated `docker-compose.yml` with controlled restart behavior:

    version: '3.6'
    services:
      database:
        image: postgres:16-alpine
        restart: on-failure:5
        environment:
          POSTGRES_DB: ${POSTGRES_DB}
          POSTGRES_USER: ${POSTGRES_USER}
          POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
        volumes:
          - postgres-data:/var/lib/postgresql/data
        healthcheck:
          test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
          interval: 5s
          timeout: 3s
          retries: 5

      redis:
        image: redis:alpine
        restart: on-failure:5

      web:
        build: ./app
        restart: on-failure:5
        ports:
          - "5000:5000"
        depends_on:
          database:
            condition: service_healthy
          redis:
            condition: service_started
        environment:
          DB_HOST: database
          DB_NAME: ${POSTGRES_DB}
          DB_USER: ${POSTGRES_USER}
          DB_PASSWORD: ${POSTGRES_PASSWORD}
          REDIS_HOST: redis

    volumes:
      postgres-data:

---

### 🧪 Testing restart: always

When using:

    restart: always

#### Test Steps
```bash
    docker-compose up -d
    docker exec -it flask-stack_database_1 sh
    kill 1
```

#### Observed Behavior

- Container crashed
- Docker restarted it automatically
- Healthcheck executed again
- Container returned to healthy state
- This continued indefinitely if the crash repeated

#### Risk

If container crashes every few seconds:

- Infinite restart loop
- CPU spikes
- Log growth increases
- System instability on small instances like t3.micro

---

### 🧪 Testing restart: on-failure:5

When using:

    restart: on-failure:5

#### Test Steps

    docker-compose up -d
    docker exec -it flask-stack_database_1 sh
    kill 1

Repeated crash simulation multiple times.

#### Observed Behavior

- Container restarted after crash
- After 5 failed restart attempts:
  - Docker stopped retrying
  - Container remained in Exited state

Verification:

    docker ps -a

This prevented infinite crash loops.

---

#3## 🔍 Behavior Comparison

| Scenario | restart: always | restart: on-failure |
|-----------|-----------------|---------------------|
| Container crashes | Restarts | Restarts |
| Manual docker stop | Does NOT restart | Does NOT restart |
| Docker daemon restart | Restarts | Does NOT restart |
| Restart attempt limit | Unlimited | Configurable |
| Crash loop protection | No | Yes |

---

#### 🧠 Production Recommendations

Use `restart: always` for:

- Databases
- Web servers
- Critical infrastructure services

Use `restart: on-failure` for:

- Background workers
- Batch jobs
- Controlled retry systems

---

#### ⚠️ Important Observation

If the database reaches maximum restart attempts (5) and remains stopped:

- Web container continues running
- Redis container continues running
- Application becomes partially unavailable
- Web shows database connection errors

Docker Compose does not stop dependent services once they are already running.

---

#### 🎯 Key Learnings

- Restart policies apply at container creation time.
- restart: always ensures maximum availability but risks infinite loops.
- restart: on-failure allows controlled retries.
- Healthchecks manage readiness.
- Restart policies manage crash recovery.
- Proper restart configuration improves system stability and production reliability.

---

## Task 4: Custom Dockerfiles in Compose

---

### 🎯 Objective

Build a custom Docker image using a Dockerfile inside docker-compose.yml with the `build:` directive.  
Make a code change and rebuild + restart using a single command.

---

### 📁 Project Structure

compose-build-demo/
├── Dockerfile  
├── docker-compose.yml  
└── index.html  

---

### 📝 Step 1: Application File (index.html)

<!DOCTYPE html>
<html>
<head>
    <title>Compose Build Demo</title>
</head>
<body>
    <h1>Hello Shivkumar 🚀</h1>
    <p>This container was built using Docker Compose build feature.</p>
</body>
</html>

---

#3# 🐳 Step 2: Dockerfile

FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY index.html .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

---

### ⚙️ Step 3: docker-compose.yml

version: '3.8'

services:
  web:
    build: .
    container_name: compose-web
    ports:
      - "80:80"

---

### ▶️ Step 4: Build and Start (Single Command)

docker compose up --build -d

This command:
- Builds the image from Dockerfile
- Creates the container
- Starts the container
- Runs in detached mode

---

### 🔍 Verify Running Container

docker ps

---

### 🔄 Step 5: Make Code Change

Modify index.html:

<h1>Hello DevOps World 🌍</h1>

---

### ♻️ Rebuild and Restart

docker compose up --build -d

Docker Compose automatically:
- Detects changes
- Rebuilds the image
- Recreates the container
- Restarts the service

---

### ✅ Task Completed

✔ Used custom Dockerfile in Compose  
✔ Built image using build:  
✔ Modified application code  
✔ Rebuilt and restarted using one command  
✔ Successfully ran container  

---

## Task 5: Named Networks & Volumes

---

### 🎯 Objective

Enhance a multi-container Flask application by:

- Defining explicit named networks instead of relying on the default network
- Defining named volumes for database persistence
- Adding labels to services for better organization and metadata tagging

---

### 📁 Application Overview

Services used:

- web → Flask application (built using Dockerfile)
- database → PostgreSQL
- redis → Redis cache

Infrastructure components added:

- Named Network → backend-network
- Named Volume → postgres-data

---

### 🌐 1️⃣ Explicit Named Network

Defined a custom network:

    networks:
      backend-network:
        driver: bridge

Attached all services to the network:

    networks:
      - backend-network

#### Why Explicit Networks?

- Provides architectural clarity
- Controls inter-service communication
- Simplifies troubleshooting and inspection
- Enables multi-network isolation if required
- Follows production best practices

---

### 💾 2️⃣ Named Volume for Database

Defined a named volume:

    volumes:
      postgres-data:

Attached it to PostgreSQL:

    volumes:
      - postgres-data:/var/lib/postgresql/data

#### Why Named Volumes?

- Ensures database data persistence
- Prevents data loss when containers are recreated
- Separates container lifecycle from data lifecycle
- Essential for production database deployments

---

### 🏷 3️⃣ Service Labels

Added labels to each service for better organization.

Database:

    labels:
      project: "flask-app"
      tier: "database"
      env: "dev"

Redis:

    labels:
      project: "flask-app"
      tier: "cache"
      env: "dev"

Web:

    labels:
      project: "flask-app"
      tier: "backend"
      env: "dev"

#### Why Labels?

- Adds metadata to containers
- Enables filtering and grouping
- Useful for monitoring and logging tools
- Helps in orchestration environments
- Improves large-scale project management

---

### 🔄 Deployment Commands

Clean deployment:

    docker compose down -v
    docker compose up -d --build

---

### 🔍 Verification Commands

Check networks:

    docker network ls
    docker network inspect backend-network

Check volumes:

    docker volume ls
    docker volume inspect postgres-data

Check labels:

    docker inspect <container_name>

---

### 🏗 Final Architecture

web  
 └── backend-network  
       ├── database  
       └── redis  

Database data stored in:  
postgres-data (named volume)

---

### 🎯 Key Learning Outcomes

- Explicit networks improve control and visibility
- Named volumes protect stateful service data
- Labels enhance service organization
- Production-style multi-container architecture implemented
- Verified using Docker CLI commands

---

### ✅ Task Completed

✔ Explicit named network defined  
✔ Named database volume configured  
✔ Services attached to custom network  
✔ Labels added for organization  
✔ Deployment and verification successful  
✔ Production-ready Docker Compose structure achieved  

---

## Task 6: Scaling (Bonus)

---

### 🎯 Objective

- Scale the `web` service to multiple replicas using:
  
      docker-compose up -d --scale web=3

- Observe what happens
- Identify what breaks
- Understand why simple scaling does not work with port mapping
- Fix scaling using reverse proxy
- Stress test system limits

---

### 🧪 Step 1: Initial Scaling Attempt (With Port Mapping)

Original configuration in `web` service:

    ports:
      - "5000:5000"

Command executed:

    docker-compose up -d --scale web=3

#### ❌ What Happened

Docker produced error:

    Bind for 0.0.0.0:5000 failed: port is already allocated

#### 🔎 Why It Broke

- Each replica tried to bind to host port 5000
- Only ONE container can bind to a specific host port
- Host ports must be unique
- Multiple replicas cannot share the same host port

#### 🧠 Key Learning

Simple scaling fails when fixed host port mapping is used.

---

#### 🛠 Step 2: Proper Scaling Architecture (Reverse Proxy Pattern)

#### Fix Applied

1. Removed port mapping from `web` service.
2. Added an `nginx` reverse proxy service.
3. Exposed port 80 only on nginx.
4. Kept web containers internal within custom network.

Updated architecture:

Client → Nginx (port 80 exposed)
            ↓
       Multiple Flask web containers
            ↓
       Database + Redis

Now only nginx binds to host port.

---

### 🚀 Step 3: Scaling After Fix

Command executed:

    docker-compose up -d --scale web=3

#### ✅ Result

- No port conflict
- Multiple web containers started successfully
- Nginx handled internal load balancing
- Scaling worked correctly

---

### 🔥 Step 4: Stress Test (Scaled to 15 Replicas)

Command executed:

    docker-compose up -d --scale web=15

#### 📊 Observations

- CPU usage remained ~1%
- Memory usage increased to 850+ MB
- System became unresponsive
- SSH interaction stopped
- Instance required reboot

---

### 🧠 Root Cause Analysis

The system was memory-bound, not CPU-bound.

Each Flask container consumed memory even when idle.

Approximate memory breakdown:

- Flask container (each) ≈ 40–80 MB
- 15 containers ≈ 600–900 MB
- Postgres ≈ 100–150 MB
- Redis ≈ 20–50 MB
- Nginx ≈ 10–20 MB
- OS + Docker ≈ 150–250 MB

Total memory exceeded available RAM (~1GB).

Linux likely triggered OOM (Out Of Memory) behavior, causing system freeze.

---

### 🔄 Recovery Process

Since system became unresponsive:

- EC2 instance was rebooted from AWS Console
- Containers were cleaned up
- Memory returned to normal
- System restored to healthy state

---

### 🎯 Why Simple Scaling Doesn't Work With Port Mapping

Because:

- Host ports must be unique.
- Multiple replicas attempt to bind to the same host port.
- Docker Compose (non-swarm mode) does not provide built-in load balancing.
- Fixed host port mapping prevents horizontal scaling.

Proper scaling requires:

- Internal-only services
- Reverse proxy or load balancer
- Orchestration system (Swarm/Kubernetes)

---

### 🧠 Major Learnings

- Containers are lightweight, not free.
- Horizontal scaling increases memory usage linearly.
- CPU usage does not necessarily increase without traffic.
- Memory exhaustion can freeze entire host.
- Scaling must match infrastructure capacity.
- Reverse proxy pattern enables safe scaling.
- Capacity planning is essential in production environments.

---

### 🏁 Final Outcome

✔ Identified scaling limitation with port mapping  
✔ Implemented reverse proxy architecture  
✔ Successfully scaled web replicas  
✔ Stress-tested system capacity  
✔ Observed memory-bound crash scenario  
✔ Recovered instance safely  
✔ Gained real-world infrastructure awareness  

---

### 🚀 Conclusion

This task demonstrated practical horizontal scaling, infrastructure limitations, and production-grade architectural patterns.

The experiment provided hands-on understanding of:

- Docker networking
- Port binding constraints
- Resource exhaustion behavior
- Reverse proxy based scaling
- Real-world DevOps troubleshooting

---