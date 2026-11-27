# Week 5: Docker Basics & Advanced Challenge

# Task 1: Introduction and Conceptual Understanding

- In your `solution.md`, provide a brief explanation of Docker’s purpose in modern DevOps.

---

## 1. Purpose of Docker in Modern DevOps 🐳

Docker helps applications run consistently on different computers and servers.

Imagine you develop an application on your laptop. It works perfectly, but when you run it on another computer or server, it fails because some software or dependencies are missing.

Docker solves this problem by packaging the application and everything it needs into a container.

### Why Do We Use Docker?

- **Same Environment:** The application can run consistently on your laptop, testing server, and production server.
- **Easy Deployment:** You can move and run your application on another server more easily.
- **Saves Time:** You don't need to install and configure all the application dependencies manually on every server.
- **Faster Delivery:** Docker helps DevOps teams automate application building, testing, and deployment.
- **Less Resource Usage:** Containers generally use fewer resources than virtual machines.

### Simple Real-Life Example

Imagine you pack your clothes, shoes, and other necessary items into a suitcase before travelling.

Wherever you go, you have everything you need in one place.

Docker works similarly:

- **Application:** Your clothes.
- **Dependencies:** Your shoes and other necessary items.
- **Docker Container:** Your suitcase.
- **Different Servers:** Different destinations.

You can take your suitcase to different places without collecting all your belongings again.

Similarly, Docker packages an application and its dependencies so it can run in different supported environments.

---

- Compare **Virtualization vs. Containerization** and explain why containerization is the preferred approach for microservices and CI/CD pipelines.

---

## 2. Virtualization vs. Containerization

### 2.1 What Is Virtualization?

Virtualization means creating multiple virtual computers on one physical computer.

Each virtual computer, called a **Virtual Machine (VM)**, typically has its own operating system.

**Example:**

Imagine one physical computer running three virtual machines:

- VM 1 runs Linux.
- VM 2 runs Windows.
- VM 3 runs Linux.

Each VM has its own operating system, which requires additional resources.

Think of virtualization as three separate houses, each with its own facilities.

### 2.2 What Is Containerization?

Containerization means packaging an application and everything it needs to run into a container.

Containers share the host operating system's kernel, so they generally use fewer resources than virtual machines.

**Example:**

Imagine a computer running three containers:

- Container 1 runs a Python application.
- Container 2 runs a Java application.
- Container 3 runs a Node.js application.

Each container has its own application environment, but they share the host kernel.

Think of containerization as three apartments in one building. Each apartment has its own living space, but they share the building's infrastructure.

### 2.3 Comparison: Virtualization vs. Containerization

| Virtualization | Containerization |
|---|---|
| Creates virtual computers. | Packages applications into containers. |
| Each VM typically has its own operating system. | Containers share the host OS kernel. |
| Uses more resources in many typical setups. | Generally uses fewer resources. |
| Usually takes longer to start. | Usually starts faster. |
| Useful for running different operating systems. | Useful for deploying applications quickly. |

**Conclusion:** Virtualization is useful for creating separate virtual computers, while containerization is useful for packaging and deploying applications efficiently.

---

## 3. Why Is Containerization Preferred for Microservices?

Microservices architecture means dividing a large application into smaller, independent services.

For example, an online shopping application might have:

- User Service
- Payment Service
- Product Service
- Order Service

Using containers, we can package each service separately.

### Why Is This Useful?

- **Independent Deployment:** We can update the payment service without redeploying the entire application.
- **Easy Scaling:** If the payment service receives more traffic, we can run additional instances of that service.
- **Less Resource Usage:** Containers generally require fewer resources than running a separate VM for every service.
- **Flexibility:** Different services can use different programming languages and dependencies.

### Example: Microservices Architecture

```text
          E-Commerce Application
                    |
        +-----------+-----------+
        |           |           |
        v           v           v
   User Service  Product     Payment
   Container     Container   Container
        |           |           |
        +-----------+-----------+
                    |
               Order Service
                 Container
```

**Conclusion:** Containerization is well suited to microservices because it makes individual services easier to package, deploy, and scale independently.

---

## 4. Why Is Containerization Preferred for CI/CD?

CI/CD automates the process of building, testing, and deploying applications.

Suppose a developer writes new code. A typical workflow looks like this:

### CI/CD Workflow

```text
Developer Writes Code
         |
         v
Code Is Pushed to Git
         |
         v
CI/CD Pipeline Starts
         |
         v
Docker Builds an Image
         |
         v
Application Is Tested
         |
         v
Image Is Pushed to a Registry
         |
         v
Image Is Deployed to a Server
         |
         v
Application Runs in a Container
```

### Benefits of Docker in CI/CD

- **Consistency:** The application can run consistently in testing and production.
- **Faster Deployment:** The prepared image can be deployed without reinstalling all application dependencies.
- **Easy Rollback:** If a new version fails, the team can redeploy a previous image.
- **Automation:** Tools such as Jenkins and GitHub Actions can automate building, testing, and deploying applications.
- **Portability:** The same image can be deployed across compatible environments.

### Example of Docker in CI/CD

Imagine a developer updates an application and pushes the code to GitHub.

1. GitHub Actions or Jenkins detects the code change.
2. The CI/CD pipeline builds a Docker image.
3. Automated tests check whether the application works correctly.
4. The image is pushed to a container registry.
5. The deployment process pulls the image and runs it on the target server.

This process reduces manual work and makes application delivery more consistent.

**Conclusion:** Containerization is preferred for CI/CD because it provides a consistent, portable application package that can be built, tested, and deployed through automation.

---

## 5. Final Summary

| Concept | Purpose |
|---|---|
| Docker | Packages applications and their dependencies into containers. |
| Virtualization | Creates virtual computers that typically run separate operating systems. |
| Containerization | Runs isolated applications while sharing the host OS kernel. |
| Microservices | Allows applications to be divided into smaller, independent services. |
| CI/CD | Automates application building, testing, and deployment. |

### Key Takeaway

Docker plays an important role in modern DevOps by making applications easier to package, test, deploy, and run consistently across different environments.

Containerization is particularly useful for microservices and CI/CD pipelines because it supports independent deployment, efficient resource usage, portability, and automation.

---

# Task 2: Create a Dockerfile for a Sample Java Project

This project demonstrates how to containerize a simple Java application using Docker. The application prints random quotes to the terminal and can be extended to handle web requests.

## 1. Project Overview

The goal of this project is to:

- Create a simple Java application.
- Write a Dockerfile to containerize the application.
- Build a Docker image.
- Run the application inside a Docker container.
- Verify the container status and application logs.

## 2. Project Structure

Organize your project files as follows:

```text
java-app/
├── src/
│   └── Main.java
├── Dockerfile
└── README.md
```

## 3. Create the Dockerfile

Create a file named `Dockerfile` in the root directory of your project.

```dockerfile
# Use the official Eclipse Temurin Java 21 JDK image
FROM eclipse-temurin:21-jdk

# Set the working directory
WORKDIR /app

# Copy the Java source file into the container
COPY src/Main.java .

# Compile the Java application
RUN javac Main.java

# Start the Java application
CMD ["java", "Main"]
```

### Explanation

- `FROM eclipse-temurin:21-jdk`: Uses Java 21 as the base image.
- `WORKDIR /app`: Sets `/app` as the working directory inside the container.
- `COPY src/Main.java .`: Copies the Java source file into the container.
- `RUN javac Main.java`: Compiles the Java application.
- `CMD ["java", "Main"]`: Executes the compiled Java application when the container starts.

**Note:** The Dockerfile above is suitable for a terminal-based application that prints quotes. If your application runs a web server, you must configure the application to listen on a port and expose that port as needed.

## 4. Build the Docker Image

Open a terminal in the root directory of your project and execute:

```bash
docker build -t rachitthakur/java-app:latest .
```

- `docker build`: Builds a Docker image.
- `-t rachitthakur/java-app:latest`: Assigns a name and tag to the image.
- `.`: Specifies the current directory as the build context.

### Docker Build Screenshot

![Docker Build Process](images/Screenshot29.png)

## 5. Run the Docker Container

Run the application in detached mode using the following command:

```bash
docker run -d rachitthakur/java-app:latest
```

**Note:** Since this sample application prints quotes to the terminal, you do not need to map any ports. Port mapping is required only if the application runs a network service, such as a web server.

### Running Container Screenshot

![Running Docker Container](images/Screenshot30.png)

The app is also running on the localhost.

![Localhost Verification](images/Screenshot31.png)
## 6. Verify the Application

### Check Container Status

Execute the following command to list running containers:

```bash
docker ps
```

To view all containers, including stopped ones, use:

```bash
docker ps -a
```

### Container Status Screenshot

![Docker PS Output](images/Screenshot32.png)

### Check Application Logs

View the application's output using:

```bash
docker logs <container_id>
```

The logs should display the quotes printed by the Java application.

### Docker Logs Screenshot

![Docker Logs Output](images/Screenshot33.png)


## 7. Stop and Remove the Container

To stop the running container:

```bash
docker stop java-app
```

To remove the container:

```bash
docker rm java-app
```

To remove the Docker image, run:

```bash
docker rmi rachitthakur/java-app:latest
```

---

# Task 3: Explore Docker Terminologies and Components

# 🐳 Docker Key Terminologies and Components

A quick guide to important **Docker concepts, components, and how they work together**.

---

## 📌 Docker Key Terminologies

### 1. Docker Image

A **Docker Image** is a read-only package containing everything required to run an application, including code, libraries, dependencies, configuration, and runtime.

```bash
docker pull nginx
```

This downloads the Nginx image from Docker Hub.

---

### 2. Docker Container

A **Docker Container** is a running instance of a Docker image. It provides an isolated environment in which an application runs.

```bash
docker run -d -p 8080:80 nginx
```

One image can be used to create multiple containers.

---

### 3. Dockerfile

A **Dockerfile** is a text file containing instructions used to build a Docker image.

Example:

```dockerfile
FROM nginx
COPY index.html /usr/share/nginx/html/
EXPOSE 80
```

Build the image:

```bash
docker build -t my-nginx .
```

---

### 4. Docker Volume

A **Docker Volume** is used to store persistent data generated or used by containers.

```bash
docker volume create mydata
```

Attach the volume to a container:

```bash
docker run -v mydata:/data nginx
```

### Uses

- Database storage
- Application data
- Persistent files
- Sharing data between containers

---

### 5. Docker Network

A **Docker Network** allows containers to communicate with each other and with external networks.

Create a network:

```bash
docker network create mynetwork
```

Run a container on the network:

```bash
docker run -d --network mynetwork --name app nginx
```

---

# 🧩 Main Docker Components

## 1. Docker Engine

**Docker Engine** is the core technology responsible for creating and managing Docker containers.

It mainly consists of:

- **Docker Daemon (`dockerd`)** – Manages images, containers, networks, and volumes.
- **Docker CLI** – Command-line interface used to interact with Docker.
- **Docker API** – Allows applications and tools to communicate with the Docker daemon.

Example:

```bash
docker run nginx
```

The Docker CLI sends the command to the Docker daemon, which creates and runs the container.

---

## 2. Docker Client

The **Docker Client** is the command-line interface through which users interact with Docker.

Common commands:

```bash
docker build
docker pull
docker run
docker ps
docker stop
```

The client communicates with the Docker daemon through the Docker API.

---

## 3. Docker Daemon

The **Docker Daemon (`dockerd`)** is a background service responsible for managing Docker objects such as:

- Images
- Containers
- Networks
- Volumes

For example:

```bash
docker run nginx
```

The daemon checks whether the Nginx image is available locally. If it is not available, Docker can download it from a registry such as Docker Hub.

---

## 4. Docker Hub

**Docker Hub** is a cloud-based registry where Docker images can be stored and shared.

Popular images include:

- Nginx
- Ubuntu
- MySQL
- Redis
- Node.js
- Python

Example:

```bash
docker pull nginx
```

---

## 5. Docker Registry

A **Docker Registry** is a storage system for Docker images.

### Types

- **Public Registry** – Images are publicly available.
- **Private Registry** – Used by organizations to store internal images.

**Docker Hub** is an example of a Docker registry.

---

## 6. Docker Compose

**Docker Compose** is used to define and run applications consisting of multiple containers.

For example:

```text
Frontend
   ↓
Backend
   ↓
Database
```

These services can be defined in a `compose.yaml` file and started together:

```bash
docker compose up
```

---

---

# 🚀 Example Docker Workflow

Suppose a developer wants to run an Nginx application.

### Step 1: Pull the Image

```bash
docker pull nginx
```

Docker downloads the Nginx image from Docker Hub if it isn't already available locally.

### Step 2: Run the Container

```bash
docker run -d -p 8080:80 nginx
```

Docker creates a container from the Nginx image.

### Step 3: Add Persistent Storage

If the application needs persistent data, attach a Docker Volume.

```bash
docker run -v mydata:/data nginx
```

### Step 4: Connect Containers

If multiple containers need to communicate, use a Docker Network.

```bash
docker network create mynetwork
```

### Step 5: Manage Containers

Useful commands include:

```bash
docker ps
docker stop <container_id>
docker start <container_id>
docker restart <container_id>
docker rm <container_id>
```

---

# 📊 Docker Terminology Summary

| Term | Description |
|---|---|
| 🖼️ **Image** | Read-only template used to create containers |
| 📦 **Container** | Running instance of an image |
| 📄 **Dockerfile** | Instructions used to build an image |
| 💾 **Volume** | Provides persistent storage |
| 🌐 **Network** | Enables communication between containers |
| ⚙️ **Docker Engine** | Core platform for running and managing containers |
| 💻 **Docker Client** | Interface used to send commands to Docker |
| 🔧 **Docker Daemon** | Background service that manages Docker resources |
| ☁️ **Docker Hub** | Cloud registry for storing and sharing images |
| 🗄️ **Registry** | System for storing Docker images |
| 🔗 **Docker Compose** | Tool for managing multi-container applications |
| 🔌 **Docker API** | Interface for communication with the Docker daemon |

---

# Task 4: Optimize Your Docker Image with Multi-Stage Builds

## 1. Implement a Multi-Stage Docker Build

A multi-stage Docker build uses multiple `FROM` statements in a single Dockerfile.

The main idea is:

- **Stage 1:** Build/compile the application using the JDK.
- **Stage 2:** Run the application using only the JRE.
- Only the required compiled files are copied from the build stage to the final image.

---

## Original Dockerfile

The original Dockerfile uses the full Java JDK for both compiling and running the application.

```dockerfile
# Use the official Eclipse Temurin Java 21 JDK image
FROM eclipse-temurin:21-jdk

# Set the working directory
WORKDIR /app

# Copy the Java source file into the container
COPY src/Main.java .

# Compile the Java application
RUN javac Main.java

# Start the Java application
CMD ["java", "Main"]
```

### Problems with the Original Dockerfile

- The full **JDK** remains in the final image.
- The Java compiler (`javac`) is not required after compilation.
- The final image can be larger than necessary.
- Development tools are included in the production container.

---

# Modified Dockerfile: Multi-Stage Build

```dockerfile
# ==========================================
# STAGE 1: Build Environment
# ==========================================

# Use the full JDK because we need the javac compiler
FROM eclipse-temurin:17-jdk-alpine AS builder

# Set the build workspace
WORKDIR /build

# Copy the Java source file
COPY src/Main.java .

# Compile the Java application
RUN javac Main.java


# ==========================================
# STAGE 2: Runtime Environment
# ==========================================

# Use only the JRE for running the application
FROM eclipse-temurin:17-jre-alpine

# Set the production workspace
WORKDIR /app

# Copy only the compiled class file from the builder stage
COPY --from=builder /build/Main.class /app/Main.class

# Copy the required text file
COPY quotes.txt /app/quotes.txt

# Document the application's port
EXPOSE 8000

# Run the Java application
CMD ["java", "Main"]
```

## How the Multi-Stage Build Works

### Stage 1 — Builder

```dockerfile
FROM eclipse-temurin:17-jdk-alpine AS builder
```

- Uses the full **JDK**.
- The JDK contains the `javac` compiler.
- Java source code is copied into the container.
- `javac Main.java` creates `Main.class`.

### Stage 2 — Runtime

```dockerfile
FROM eclipse-temurin:17-jre-alpine
```

- Uses only the **JRE**.
- The JRE contains the components required to run the Java application.
- The JDK compiler is not included.

### Copying the Compiled Application

```dockerfile
COPY --from=builder /build/Main.class /app/Main.class
```

Only the compiled `Main.class` file is copied from the builder stage.

This means the following are not carried into the final image:

- JDK compiler
- Build environment
- Temporary build files
- Original `Main.java` source file

---

# 2. Compare Image Sizes

Then check the image sizes again:

```bash
docker images
```
![Docker Images Output](images/Screenshot34.png)


---

# 3. Document the Differences

## Comparison Table

| Attribute | Original Dockerfile | Multi-Stage Dockerfile | Benefit |
|---|---|---|---|
| Build Environment | Full JDK | Full JDK only in builder stage | Build tools don't remain in production |
| Runtime Environment | Full JDK | JRE Alpine | Smaller final image |
| Operating System | Standard Temurin image | Alpine-based image | Smaller footprint |
| Compiler | Present in final image | Only in builder stage | Removes unnecessary tools |
| Source Code | Present | Only compiled `.class` file copied | Cleaner final image |
| Build Files | May remain in image | Left in builder stage | Reduces unnecessary files |
| Security | More tools available | Fewer tools in final image | Smaller attack surface |
| Deployment | Larger image | Smaller image | Faster image transfer |

---

# 4. Main Benefits of Multi-Stage Builds

## 1. Smaller Docker Image 📦

- Build tools are not included in the final image.
- Only the files required to run the application are copied.
- This helps reduce the final image size.

## 2. Faster Deployment ⚡

- Smaller images require less time to upload and download.
- Containers can be deployed faster.
- This is especially useful in CI/CD pipelines.

## 3. Better Security 🔒

- Development tools such as compilers are not included in the production image.
- Fewer installed tools mean fewer potential security vulnerabilities.
- The final container has a smaller attack surface.

## 4. Separation of Build and Runtime 🏗️➡️🚀

- The **builder stage** is responsible for compiling the application.
- The **runtime stage** is responsible only for running the application.
- This creates a clean separation between development and production environments.

## 5. Less Storage Usage 💾

- Smaller images require less disk space.
- Docker registries need less storage.
- Servers require less space for storing images.

## 6. Cleaner Production Image 🧹

The final image does not need:

- Source code
- Compiler
- Build tools
- Temporary build files
- Unnecessary development dependencies

Only the required runtime files are included.

## 7. Easier Maintenance 🔧

- Build and runtime environments are clearly separated.
- The Dockerfile becomes easier to understand.
- Production images remain focused on running the application.

---

# Task 5: Manage Your Image with Docker Hub

## 1. Tag Your Image

Tag the Docker image with a version tag:

```bash
docker tag rachitthakur/multi-javaapp:latest rachitthakur/multi-javaapp:latest
```

---

## 2. Push Your Image to Docker Hub

First, log in to Docker Hub:

```bash
docker login
```

![Docker Login](images/Screenshot35.png)

After successful login, push the Docker image to Docker Hub:

```bash
docker push rachitthakur/multi-javaapp:latest
```

![Docker Push](images/Screenshot36.png)

### Successfully Pushed to Docker Hub

The image was successfully pushed to Docker Hub.

![Docker Hub Image](images/Screenshot37.png)

---

## 3. Pull the Image

To verify that the image is available on Docker Hub, pull the image:

```bash
docker pull rachitthakur/multi-javaapp:latest
```

![Docker Pull](images/Screenshot38.png)

---

## Summary

The Docker image was successfully:

- Tagged with a version tag.
- Pushed to Docker Hub.
- Verified by pulling it from Docker Hub.

The image `rachitthakur/multi-javaapp:latest` is now available on Docker Hub for use and distribution.

---

# Task 6: Persist Data with Docker Volumes

## 1. Create a Docker Volume

Create a Docker volume named `my_volume`:

```bash
docker volume create my_volume
```

### Screenshot

![Docker Volume Create](images/Screenshot39.png)

---

## 2. Check the Volume and Its Location

To check the details and location of the Docker volume, run:

```bash
docker volume inspect my_volume
```

This command shows information such as the volume name, driver, and mount point.

On a Linux system, the volume is usually stored under:

```text
/var/lib/docker/volumes/my_volume/_data
```

### Screenshot

![Docker Volume Inspect](images/Screenshot40.png)

---

## 3. Run a Container with the Volume

Run the Docker container and attach the `my_volume` volume to `/app/data` inside the container:

```bash
docker run -d -v my_volume:/app/data <your-username>/sample-app:v1.0
```

For example:

```bash
docker run -d -v my_volume:/app/data rachitthakur/multi-javaapp:latest
```

Here:

- `my_volume` → Docker volume
- `/app/data` → directory inside the container
- `-v` → mounts the volume to the container
- `multi-javaapp:latest` → Docker image being used

### Screenshot

![Docker Container with Volume](images/Screenshot41.png)

---

# How Docker Volumes Help with Data Persistence

Docker containers are generally temporary. When a container is deleted, data stored only inside the container can also be lost.

Docker volumes solve this problem by storing data separately from the container.

If the container is removed, the volume and its data remain available.

A new container can use the same volume:

```bash
docker run -d -v my_volume:/app/data <your-username>/sample-app:v1.0
```

The previously stored data can then be accessed by the new container.

---

# Why Docker Volumes Are Useful

## 1. Data Persistence

Data remains available even when containers are deleted or recreated.

## 2. Container-Independent Storage

The data is stored separately from the container's lifecycle.

## 3. Easy Backup

Docker volume data can be backed up and restored when required.

## 4. Sharing Data

The same volume can be mounted to multiple containers when sharing data is required.

## 5. Useful for Databases

Docker volumes are commonly used for databases such as **MySQL** and **PostgreSQL** because database data needs to survive container restarts, upgrades, and recreation.

---

## Summary

Docker volumes provide **persistent storage** for containers. They keep application data separate from the container, allowing the data to survive when containers are stopped, removed, or recreated.

Therefore, Docker volumes are especially useful for **databases, application data, backups, and sharing data between containers**.

---

# Task 7: Configure Docker Networking

## 1. Create a Custom Docker Network

Create a custom Docker network named `two-tier` to allow containers to communicate with each other.

```bash
docker network create two-tier
```

**Screenshot:**

![Docker Network Creation](images/Screenshot42.png)

## 2. Run Containers on the Same Network

Run the Flask application and MySQL database containers on the same Docker network.

### Run the Flask Application Container

```bash
docker run -d \
  --name flask-app \
  --network two-tier \
  -p 5000:5000 \
  -e MYSQL_HOST=my-db \
  -e MYSQL_USER=root \
  -e MYSQL_PASSWORD=root \
  -e MYSQL_DB=mydatabase \
  rachitthakur/two-tier-flask-app:latest
```

### Run the MySQL Database Container

```bash
docker run -d \
  --name my-db \
  --network two-tier \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=mydatabase \
  mysql:latest
```

**Note:** The database must be initialized and ready before the Flask application can connect successfully. If the containers already exist, remove or reuse them as appropriate rather than creating duplicate containers.

**Screenshot:**

![Docker Containers](images/Screenshot43.png)

## 3. Verify Docker Network Configuration

Use the following command to inspect the custom network:

```bash
docker network inspect two-tier
```

This command displays network details, including the containers connected to it.

Verify that both `flask-app` and `my-db` appear in the container list.

**Screenshot:**

![Docker Network Inspection](images/Screenshot44.png)

## 4. Access the Flask Application

The `-p 5000:5000` option publishes container port 5000 on port 5000 of the host machine.

Open the following address in your browser:

```text
http://localhost:5000
```

The application should be accessible if the Flask container is running correctly and listening on port 5000.

**Screenshot:**

![Flask Application Running](images/Screenshot45.png)

## 5. Docker Networking and Its Significance in Multi-Container Applications

### What Is Docker Networking?

Docker networking is a feature that allows containers to communicate with each other, the host machine, and external networks.

### How Docker Networking Works

1. Docker creates a virtual network to connect containers.
2. Containers connected to the same network can communicate with each other.
3. Containers can communicate using their names or IP addresses.
4. Docker manages communication between containers.
5. Port mapping allows external users to access applications running inside containers.

**Example:**

In a web application, the frontend container communicates with the backend container, and the backend container communicates with the database container.

### Types of Docker Networks

1. **Bridge Network:** Connects containers running on the same Docker host.
2. **Host Network:** Allows a container to use the host machine's network directly.
3. **None Network:** Provides network isolation to a container.
4. **Overlay Network:** Connects containers across multiple Docker hosts in supported configurations.

### Significance of Docker Networking

1. **Communication:** Allows containers to exchange data with each other.
2. **Security:** Helps isolate containers using separate networks.
3. **Service Discovery:** Allows containers on a user-defined bridge network to find each other using container names.
4. **Scalability:** Supports applications that use multiple containers.
5. **Port Mapping:** Allows external users to access container applications.
6. **Easy Management:** Makes connecting and managing containers easier.

### Conclusion

Docker networking plays an important role in multi-container applications. It allows different containers, such as frontend, backend, and database containers, to communicate and work together efficiently.

---

# Task 8: Orchestrate with Docker Compose

## 1. Introduction

Docker Compose is a tool used to define and manage multi-container Docker applications. It allows us to configure multiple services, networks, and volumes in a single YAML file.

In this task, I used Docker Compose to deploy a two-tier Flask application with a MySQL database.

## 2. Create a `docker-compose.yml` File

Create a file named `docker-compose.yml` in the root directory of the project.

### Docker Compose Configuration

```yaml
services:
  flask-app:
    image: rachitthakur/two-tier-flask-app:latest
    container_name: flask-app
    ports:
      - "5000:5000"
    environment:
      MYSQL_HOST: my-db
      MYSQL_USER: root
      MYSQL_PASSWORD: root
      MYSQL_DB: mydatabase
    depends_on:
      my-db:
        condition: service_healthy
    networks:
      - two-tier
    restart: unless-stopped

  my-db:
    image: mysql:8.0
    container_name: my-db
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: mydatabase
    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - two-tier
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost", "-uroot", "-proot"]
      interval: 10s
      timeout: 5s
      retries: 10
      start_period: 30s
    restart: unless-stopped

networks:
  two-tier:
    driver: bridge

volumes:
  mysql_data:
```

## 3. Explanation of the Configuration

### A. Flask Application Service

The `flask-app` service runs the Flask web application using an image hosted on Docker Hub.

- **Image:** Downloads and runs the Flask application image.
- **Container name:** Names the container `flask-app`.
- **Ports:** Maps host port 5000 to container port 5000.
- **Environment variables:** Configure the MySQL connection.
- **Depends on:** Waits for the MySQL service to pass its health check before starting Flask.
- **Networks:** Connects Flask to the `two-tier` network.
- **Restart policy:** Restarts the container unless it has been explicitly stopped.

### B. MySQL Database Service

The `my-db` service runs the MySQL database.

- **Image:** Uses the MySQL 8.0 image.
- **Container name:** Names the container `my-db`.
- **Environment variables:** Set the MySQL root password and create the `mydatabase` database during initial database initialization.
- **Volumes:** Store database files persistently.
- **Networks:** Connects MySQL to the `two-tier` network.
- **Health check:** Checks whether MySQL is ready to accept connections.
- **Restart policy:** Restarts the container unless it has been explicitly stopped.

### C. Networks

The `two-tier` network uses the bridge driver.

It allows the Flask application and MySQL database containers to communicate with each other.

Flask connects to MySQL using the hostname `my-db` rather than `localhost`.

### D. Volumes

The `mysql_data` volume stores MySQL database files outside the container's writable layer.

This helps preserve database data when the MySQL container is recreated.

## 4. Deploy the Application

Run the following command from the directory containing `docker-compose.yml`:

```bash
docker-compose up -d
```

This command creates the necessary network and volume, then starts the Flask and MySQL services in the background.

**Screenshot:**

![Flask Application Running](images/Screenshot46.png)

## 5. Verify the Deployment

Check the status of the containers:

```bash
docker-compose ps
```

View the application logs:

```bash
docker-compose logs flask-app
```

View the database logs:

```bash
docker-compose logs my-db
```

## 6. Access the Application

Open a web browser and visit:

```text
http://localhost:5000
```

The Flask application should be accessible if the container is running correctly and listening on port 5000.

**Screenshot:**

![Flask Application](images/Screenshot45.png)

## 7. Shut Down the Application

To stop and remove the containers and the Compose-created network, run:

```bash
docker-compose down
```

The named `mysql_data` volume is preserved by default, so database data can remain available when the application is started again.

**Screenshot:**

![Docker Compose Shutdown](images/Screenshot47.png)

## 8. Benefits of Docker Compose

1. **Simple management:** Runs multiple containers using a single command.
2. **Easy configuration:** Defines services, networks, and volumes in one YAML file.
3. **Networking:** Allows containers to communicate using service names.
4. **Data persistence:** Volumes preserve database files beyond the container lifecycle.
5. **Automation:** Starts services in the required order and can wait for health checks.
6. **Portability:** Makes it easier to run the same application setup on different systems with Docker Compose installed.

## 9. Conclusion

Docker Compose simplifies the deployment and management of multi-container applications.

In this task, I used Docker Compose to run a Flask web application and a MySQL database. I configured networking for communication between the services, used a volume to persist database data, and added a health check to ensure MySQL was ready before Flask started.

This approach makes the application easier to deploy, manage, and maintain.

---

# Task 9: Analyze Your Image with Docker Scout

## 1. Install Docker Scout

Docker Scout is a tool used to analyze Docker images and identify security vulnerabilities.

### Download Docker Scout

```bash
curl -fsSL https://raw.githubusercontent.com/docker/scout-cli/main/install.sh -o install-scout.sh
```

### Run the Installation Script

```bash
sh install-scout.sh
```

### Verify Installation

```bash
docker scout version
```

The above command verifies that Docker Scout is installed successfully.

---

## 2. Run Docker Scout Analysis

Run Docker Scout against the Docker image to identify vulnerabilities.

### Scan Image for Vulnerabilities

```bash
docker scout cves rachitthakur/two-tier-flask-app:latest
```

### Get Image Security Summary

```bash
docker scout quickview rachitthakur/two-tier-flask-app:latest
```

### Save the Scan Report

To save the vulnerability report into a text file:

```bash
docker scout cves rachitthakur/two-tier-flask-app:latest > scout_report.txt
```

This creates `scout_report.txt`, which can be used for further analysis.

---

## 3. Review and Interpret the Report

### Successfully Scanned Image

| Detail | Information |
|---|---|
| Image Name | `rachitthakur/two-tier-flask-app:latest` |
| Image Digest | `03c414306279` |
| Platform | `linux/amd64` |
| Image Size | 177 MB |
| Packages Indexed | 211 |
| Vulnerable Packages | 26 |
| Total Vulnerabilities | 161 |

### Vulnerability Summary

| Severity | Number of Vulnerabilities |
|---|---:|
| Critical | 3 |
| High | 20 |
| Medium | 28 |
| Low | 110 |
| **Total** | **161** |

### Analysis Result

Docker Scout detected **161 vulnerabilities across 26 packages**.

- Critical: 3 vulnerabilities.
- High: 20 vulnerabilities.
- Medium: 28 vulnerabilities.
- Low: 110 vulnerabilities.

Critical and High vulnerabilities should be prioritized because they represent the most important security risks identified by the scan.

---

## 4. Affected Dependencies and Layers

The scan identified vulnerabilities in two major dependency groups.

### A. Python Application Dependencies

The following Python packages were identified:

- Flask
- Werkzeug
- Requests
- urllib3
- Certifi
- pip
- wheel
- setuptools
- jaraco-context

These packages are related to the Python application and its dependencies.

### B. Operating System Dependencies

The following operating system packages were identified:

- MariaDB
- OpenSSL
- PCRE2
- zlib
- binutils
- glibc
- coreutils
- systemd
- SQLite
- Perl
- APT
- Other system utilities

These packages may be inherited from the base image or installed during the Docker build.

### C. Layer Identification

Docker Scout identifies vulnerable packages but the provided scan output does not map every vulnerability to an exact Dockerfile instruction or layer number.

The likely sources are:

1. Base image layers inherited from `python:3.9-slim`.
2. Python dependencies installed through `requirements.txt` or pip.
3. Operating system packages installed during the Docker build.
4. Additional application dependencies included in the final image.

### Inspect Docker Image Layers

To check the image build history:

```bash
docker history rachitthakur/two-tier-flask-app:latest
```

To inspect image configuration:

```bash
docker image inspect rachitthakur/two-tier-flask-app:latest
```

These commands help investigate the image structure and the instructions used to build it.

---

## 5. Recommended Remediation

### A. Update the Base Image

The current base image is:

```dockerfile
FROM python:3.9-slim
```

Docker Scout recommends moving to:

```dockerfile
FROM python:3.12-slim
```

### Base Image Comparison

The base-image comparison reported the following estimated changes:

| Severity | Python 3.9-slim | Python 3.12-slim | Reduction |
|---|---:|---:|---:|
| Critical | 9 | 0 | 9 |
| High | 39 | 1 | 38 |
| Medium | 35 | 6 | 29 |
| Low | 63 | 27 | 36 |

**Note:** These figures represent Scout's base-image comparison, not guaranteed vulnerability counts for the complete application image. Application compatibility should be tested before upgrading Python.

### B. Update Python Dependencies

Update vulnerable dependencies in `requirements.txt` using compatible patched versions.

Examples of fixed versions reported by Scout:

| Package | Recommended Fixed Version |
|---|---|
| certifi | 2026.10.19 |
| urllib3 | 2.8.0 |
| Werkzeug | 3.1.6 |
| Flask | 2.2.5 |
| wheel | 0.46.2 |
| jaraco-context | 6.1.0 |
| pip | 26.2.0 |
| requests | 2.33.0 |
| setuptools | 84.1.0 |

These are examples of advisory-specific fixed versions reported by Scout. Check all applicable advisories and application compatibility before selecting final dependency versions.

After updating dependencies, rebuild and test the application.

### C. Update Operating System Packages

Update operating system packages during the Docker build.

Example:

```dockerfile
RUN apt-get update && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*
```

This helps install available security updates and remove unnecessary package cache files.

Rebuild and scan the image after updating packages.

### D. Run Container as a Non-Root User

Docker Scout reported that the container runs as root.

Create a non-root user in the Dockerfile:

```dockerfile
RUN useradd -m appuser

USER appuser
```

**Benefits:**

- Reduces security risks.
- Limits container privileges.
- Helps prevent unauthorized system-level changes.
- Improves container security.

Ensure that the application files and required directories are accessible to this user.

### E. Use Multi-Stage Docker Builds

Use multi-stage builds to keep unnecessary build tools out of the final image.

**Benefits:**

- Smaller Docker image size.
- Reduced attack surface.
- Better security.
- Cleaner production image.

### F. Review Unnecessary Packages

Remove unnecessary dependencies and packages from the image.

Recommended actions:

- Install only required packages.
- Avoid unnecessary system utilities.
- Review copyleft-licensed packages.
- Keep application dependencies updated.
- Remove unnecessary build tools from the final image.

---

## 6. Final Security Recommendations

Based on the Docker Scout analysis, the following security practices are recommended:

1. Use updated and trusted base images.
2. Regularly scan Docker images using Docker Scout.
3. Update vulnerable application dependencies.
4. Patch operating system packages.
5. Run containers using non-root users.
6. Use multi-stage Docker builds.
7. Review package licenses.
8. Pin and regularly review dependency versions.
9. Rebuild images after applying security updates.
10. Perform another Docker Scout scan to verify the improvements.

---

**Final Status:** Vulnerabilities identified and remediation recommendations documented. The fixes have not yet been verified through a new Docker Scout scan.

---

## 8. Screenshots and Evidence

Add your Docker Scout screenshots inside the `images` directory.

### Display Screenshots on GitHub

![Docker Scout Quickview](images/Screenshot48.png)

![Docker Scout Vulnerability Report](images/Screenshot49.png)

---