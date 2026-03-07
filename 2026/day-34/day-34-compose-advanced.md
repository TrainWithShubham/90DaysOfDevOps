# Day 34 – Docker Compose: Real-World Multi-Container Apps

## Task 1: Build Your Own App Stack

In this task, we created a **3-service application stack** using Docker Compose.

The stack includes:

- **Web Application** → HTML, CSS, JavaScript served using Nginx
- **Database** → MySQL
- **Cache** → Redis

Docker Compose allows these services to run together and communicate using Docker's internal network.

---

# 1. Project Structure

```
day-34-compose-app/

docker-compose.yml
Dockerfile
index.html
style.css
script.js
```

This structure contains the frontend files, Dockerfile, and Docker Compose configuration.

---

# 2. HTML Web Page

File: **index.html**

```html
<!DOCTYPE html>
<html>
<head>
    <title>Docker Compose App</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<h1>Welcome to Docker Compose App 🚀</h1>
<p>This webpage is running inside a Docker container.</p>

<button onclick="visit()">Click Me</button>
<p id="counter"></p>

<script src="script.js"></script>

</body>
</html>
```

---

# 3. CSS Styling

File: **style.css**

```css
body {
    font-family: Arial;
    text-align: center;
    margin-top: 100px;
}

h1 {
    color: #2c3e50;
}

button {
    padding: 10px 20px;
    font-size: 16px;
}
```

---

# 4. JavaScript File

File: **script.js**

```javascript
let count = 0;

function visit() {
    count++;
    document.getElementById("counter").innerText =
        "Button clicked " + count + " times.";
}
```

This JavaScript simulates a **simple counter interaction**.

---

# 5. Dockerfile (Web Application)

We use **Nginx** to serve the static HTML, CSS, and JavaScript files.

```dockerfile
FROM nginx:latest

COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/
COPY script.js /usr/share/nginx/html/

EXPOSE 80
```

Explanation:

- **FROM nginx:latest** → Base web server image
- **COPY** → Copies website files to nginx directory
- **EXPOSE 80** → Web server port

---

# 6. Docker Compose Configuration

Create the **docker-compose.yml** file.

```yaml
version: "3.9"

services:

  web:
    build: .
    ports:
      - "8080:80"
    depends_on:
      - db
      - redis
    restart: always

  db:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: appdb
    volumes:
      - db-data:/var/lib/mysql
    restart: always

  redis:
    image: redis:7
    restart: always

volumes:
  db-data:
```

Explanation:

- **web** → Static website served with Nginx
- **db** → MySQL database container
- **redis** → Redis cache container
- **depends_on** → Ensures services start in order
- **volumes** → Stores database data permanently

---

# 7. Run the Application

Start all services using Docker Compose.

```bash
docker compose up --build
```

This command will:

- Build the web application image
- Start MySQL container
- Start Redis container
- Run the entire stack

---

# 8. Verify Running Containers

Check running containers.

```bash
docker ps
```

Expected containers:

```
web
db
redis
```

---

# 9. Access the Application

Open your browser and visit:

```
http://localhost:8080
```

You should see the **Docker Compose web page** running from the container.

---

# Summary

In this task we learned:

- Creating a **multi-container architecture**
- Running **HTML, CSS, JavaScript app in Docker**
- Using **Docker Compose to manage services**
- Running **MySQL database container**
- Running **Redis cache container**
- Connecting multiple services using **Docker networking**




---




## Task 2: depends_on & Healthchecks

In this task, we improved the Docker Compose setup by adding **service dependencies and health checks**.

This ensures that the **web application starts only after the database is fully ready**, not just when the container starts.

---

# 1. Update docker-compose.yml

We add:

- `depends_on`
- `healthcheck`
- `condition: service_healthy`

```yaml
version: "3.9"

services:

  web:
    build: .
    ports:
      - "8080:80"
    depends_on:
      db:
        condition: service_healthy
    restart: always

  db:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: appdb
    volumes:
      - db-data:/var/lib/mysql
    restart: always

    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      retries: 5
      timeout: 5s
      start_period: 10s

  redis:
    image: redis:7
    restart: always

volumes:
  db-data:
```

---

# 2. Explanation

### depends_on

```
depends_on:
  db:
    condition: service_healthy
```

This ensures that the **web container waits until the database is healthy** before starting.

Without this, the application might try to connect to the database before it is ready.

---

### Healthcheck

```
healthcheck:
  test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
```

This command checks whether **MySQL is responding properly**.

Docker will mark the container as **healthy only if the command succeeds**.

---

### Healthcheck Parameters

| Parameter | Meaning |
|-----------|--------|
| interval | Time between checks |
| retries | Number of attempts before failure |
| timeout | Maximum time allowed for a check |
| start_period | Time given before health checks begin |

---

# 3. Test the Setup

First stop all containers.

```bash
docker compose down
```

Start everything again.

```bash
docker compose up --build
```

---

# 4. Expected Behavior

When running the stack:

1. Docker starts the **database container**
2. Docker runs the **healthcheck**
3. When the database becomes **healthy**
4. Then the **web container starts**

This ensures proper service startup order.

---

# Summary

In this task we learned:

- How to use **depends_on**
- How to configure **Docker healthchecks**
- How to ensure services start **only when dependencies are ready**
- How to create a more **production-ready Docker Compose setup**




## Task 3: Restart Policies

In this task, we explored **Docker restart policies**.  
Restart policies help containers automatically restart when they stop or crash.

This is useful for keeping important services like **databases and APIs running continuously**.

---

# 1. Add Restart Policy to Database

We updated the `docker-compose.yml` file to include the restart policy for the database service.

```yaml
version: "3.9"

services:

  web:
    build: .
    ports:
      - "8080:80"
    depends_on:
      db:
        condition: service_healthy

  db:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: appdb
    volumes:
      - db-data:/var/lib/mysql
    restart: always

    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      retries: 5
      timeout: 5s
      start_period: 10s

  redis:
    image: redis:7
    restart: always

volumes:
  db-data:
```

Here we added:

```
restart: always
```

to ensure the **database container automatically restarts if it stops**.

---

# 2. Test Restart Policy

First start the containers.

```bash
docker compose up -d
```

Check running containers.

```bash
docker ps
```

---

# 3. Manually Kill the Database Container

Find the database container name.

Example:

```
day-34-compose-app-db-1
```

Kill the container manually.

```bash
docker kill day-34-compose-app-db-1
```

Now check containers again.

```bash
docker ps
```

You will notice that **Docker automatically restarts the database container** because of the `restart: always` policy.

---

# 4. Using restart: on-failure

Another restart policy is:

```
restart: on-failure
```

Example:

```yaml
db:
  image: mysql:8
  restart: on-failure
```

This means the container will **restart only if it stops due to an error**.

If the container is stopped manually, it will **not restart automatically**.

---

# 5. Difference Between Restart Policies

| Restart Policy | Behavior |
|----------------|---------|
| always | Container always restarts if it stops |
| on-failure | Container restarts only if it crashes |
| no | Container does not restart automatically |
| unless-stopped | Restarts unless manually stopped |

---

# When to Use Each Restart Policy

### restart: always
Used for **critical services** that must always run.

Examples:
- Databases
- Web servers
- APIs
- Background workers

---

### restart: on-failure
Used for **jobs or services that may crash and need retrying**.

Examples:
- Batch processing
- Worker containers
- Data processing jobs

---

# Summary

In this task we learned:

- How to configure **Docker restart policies**
- How containers **automatically recover from failures**
- The difference between **always** and **on-failure**
- How restart policies improve **reliability in production systems**


---


## Task 4: Custom Dockerfiles in Compose

In this task, we learned how to build a custom image using a Dockerfile instead of using a pre-built image.

This gives us full control over the application environment and is commonly used in real-world DevOps projects.

---

# 1. Use build: in docker-compose.yml

Instead of using:

```
image: nginx
```

We use:

```yaml
services:

  web:
    build: .
    ports:
      - "8080:80"
    depends_on:
      db:
        condition: service_healthy
```

The `build: .` instruction tells Docker Compose to:

- Look for a Dockerfile in the current directory
- Build a custom image
- Use that image for the container

---

# 2. Example Dockerfile

```dockerfile
FROM nginx:latest

COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/
COPY script.js /usr/share/nginx/html/

EXPOSE 80
```

This Dockerfile builds a custom image that serves our HTML, CSS, and JavaScript files.

---

# 3. Make a Code Change

Edit the `index.html` file.

Example change:

Before:

```
<h1>Welcome to Docker Compose App 🚀</h1>
```

After:

```
<h1>Docker Compose Custom Build Working ✅</h1>
```

Save the file.

---

# 4. Rebuild and Restart with One Command

Run:

```bash
docker compose up --build -d
```

This command will:

- Rebuild the Docker image
- Recreate the container
- Restart services automatically

---

# 5. Verify the Change

Open your browser:

```
http://localhost:8080
```

You should now see the updated heading.

This confirms that:

- Docker rebuilt the image
- The new code is running inside the container

---

# Why This Is Important

Using `build:` is important because:

- It allows custom application environments
- You control dependencies
- It is required in real production projects
- It supports CI/CD pipelines

---

# Summary

In this task we learned:

- How to build a custom image using `build:`
- How Docker Compose builds images automatically
- How to apply code changes
- How to rebuild and restart using one command
- Why custom Dockerfiles are essential in real-world DevOps

---


## Task 5: Named Networks & Volumes

In this task, we improved our Docker Compose setup by explicitly defining **custom networks**, **named volumes**, and **service labels**.

These features help organize services better and make the system closer to a **production-ready architecture**.

---

# 1. Define Custom Network

Instead of relying on Docker's default network, we create our own network.

Custom networks help control how services communicate with each other.

Example:

```yaml
networks:
  app-network:
```

All services will connect to this network.

---

# 2. Define Named Volume for Database

Named volumes are used to **persist database data** even if containers are removed.

Example:

```yaml
volumes:
  db-data:
```

This ensures MySQL data is stored safely outside the container filesystem.

---

# 3. Updated docker-compose.yml

```yaml
version: "3.9"

services:

  web:
    build: .
    ports:
      - "8080:80"
    depends_on:
      db:
        condition: service_healthy
    networks:
      - app-network
    labels:
      project: "day34-devops"
      service: "web-app"

  db:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: appdb
    volumes:
      - db-data:/var/lib/mysql
    restart: always
    networks:
      - app-network
    labels:
      project: "day34-devops"
      service: "database"

    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      retries: 5
      timeout: 5s
      start_period: 10s

  redis:
    image: redis:7
    restart: always
    networks:
      - app-network
    labels:
      project: "day34-devops"
      service: "cache"

networks:
  app-network:

volumes:
  db-data:
```

---

# 4. Explanation

### Custom Network

```
networks:
  app-network:
```

- Creates a dedicated network for the application
- Allows services to communicate securely
- Improves network organization

---

### Named Volume

```
volumes:
  db-data:
```

- Stores database data outside the container
- Prevents data loss when containers are deleted

---

### Labels

```
labels:
  project: "day34-devops"
  service: "web-app"
```

Labels help with:

- Service organization
- Monitoring tools
- Container management
- CI/CD pipelines

---

# 5. Verify Networks and Volumes

Check networks:

```bash
docker network ls
```

Check volumes:

```bash
docker volume ls
```

Inspect containers:

```bash
docker inspect container_name
```

---

# Summary

In this task we learned:

- How to create **custom Docker networks**
- How to use **named volumes for persistent storage**
- How to add **labels to services**
- How these features improve **container organization and production readiness**



---


## Task 6: Scaling (Bonus)

In this task, we explored how to scale services in Docker Compose by running multiple replicas of the same container.

Scaling helps distribute load across multiple instances of an application.

---

# 1. Scale the Web Application

Docker Compose allows scaling using the `--scale` flag.

Command:

```bash
docker compose up --scale web=3 -d
```

This command will start **3 replicas of the web application container**.

Example containers created:

```
day-34-compose-app-web-1
day-34-compose-app-web-2
day-34-compose-app-web-3
```

---

# 2. What Happens?

Docker successfully starts multiple web containers.

You can verify using:

```bash
docker ps
```

You will see multiple web containers running along with the database and Redis containers.

However, there is a problem when accessing the application.

---

# 3. What Breaks?

If the service has a **port mapping like this**:

```
ports:
  - "8080:80"
```

Only **one container can bind to port 8080 on the host**.

When Docker tries to start additional containers, it cannot map the same host port again.

This creates a **port conflict**, which prevents proper scaling.

---

# 4. Why Simple Scaling Doesn't Work With Port Mapping

Port mapping connects a **host port** to a **container port**.

Example:

```
Host Port → Container Port
8080 → 80
```

If multiple containers try to use the same host port (8080), Docker cannot assign it to more than one container.

Therefore, simple scaling with port mapping does not work.

---

# 5. How Scaling Works in Real Systems

In real-world architectures, scaling is usually handled using:

- **Load balancers**
- **Reverse proxies (Nginx / Traefik)**
- **Kubernetes services**

These tools distribute incoming traffic across multiple containers instead of binding them to the same host port.

---

# Summary

In this task we learned:

- How to scale containers using `docker compose --scale`
- How Docker creates multiple container replicas
- Why port conflicts happen when scaling services
- Why load balancers are required for scalable systems
```