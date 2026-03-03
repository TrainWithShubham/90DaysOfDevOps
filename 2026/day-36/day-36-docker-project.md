# Day 36 – Docker Project  
## Dockerizing a Full Spring Boot Application

---

## 🚀 Project Overview

For Day 36 of #90DaysOfDevOps, I Dockerized a real-world Spring Boot banking application end-to-end.

The application includes:

- Spring Boot 3.4.1 (Java 21)
- MySQL 8.0 database
- Thymeleaf frontend
- JPA/Hibernate
- Spring Security
- Actuator endpoints

This project demonstrates production-style containerization using:

- Multi-stage Docker builds
- Non-root container execution
- Docker Compose
- Healthchecks
- Named volumes
- Custom networks
- Environment-based configuration

---

## 🧠 Why I Chose This App

I chose this Spring Boot banking application because:

- It is a full-stack application (frontend + backend + DB)
- It requires database integration
- It uses environment variables properly
- It resembles real-world enterprise applications

This made it ideal for complete Dockerization.

---

## 🐳 Dockerfile (Multi-Stage Build)

```dockerfile
FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /build
COPY . .
RUN mvn package -DskipTests

FROM eclipse-temurin:21-jre-alpine

RUN addgroup -S bankapp && adduser -S bankapp -G bankapp

WORKDIR /app

COPY --from=build /build/target/bankapp-0.0.1-SNAPSHOT.jar /app/app.jar

USER bankapp

CMD ["java", "-jar", "/app/app.jar"]

```

## 🔍 Explanation

**Stage 1 (Builder):**

- Uses Maven image
- Builds the JAR file
- Skips tests for container build

**Stage 2 (Runtime):**

- Uses lightweight JRE alpine image
- Copies only the JAR file
- Runs as non-root user
- Minimal and secure

```.dockerignore
.git
.env
target/
.gitignore
```

This reduces build context and prevents sensitive or unnecessary files from entering the image.

---

```YAML
version: '3.8'

services:
  mysql:
    image: mysql:8.0
    restart: on-failure:5
    networks:
      - bankapp-net
    environment:
      MYSQL_DATABASE: bankapp_db
      MYSQL_USER: bankapp_dbuser
      MYSQL_PASSWORD: BankApp@123
      MYSQL_ROOT_PASSWORD: BankApp@321
    volumes:
      - mysql-data:/var/lib/mysql
    healthcheck:
      test: ["CMD-SHELL", "mysqladmin ping -h localhost -u root -p$$MYSQL_ROOT_PASSWORD || exit 1"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s

  app:
    build: .
    restart: on-failure:5
    networks:
      - bankapp-net
    environment:
      MYSQL_HOST: mysql
      MYSQL_PORT: 3306
      MYSQL_DATABASE: bankapp_db
      MYSQL_USER: bankapp_dbuser
      MYSQL_PASSWORD: BankApp@123
    ports:
      - "8080:8080"
    depends_on:
      mysql:
        condition: service_healthy

volumes:
  mysql-data:

networks:
  bankapp-net:
    driver: bridge
```

## 🔄 How Containers Communicate

- Custom bridge network: bankapp-net
- MySQL service name: mysql
- App connects using:

```code
MYSQL_HOST=mysql
```
Docker's internal DNS resolves service names automatically.

---

## 💾 Data Persistence

MySQL data is persisted using a named Docker volume:

```code
mysql-data → /var/lib/mysql
```
Even if containers are removed, database data remains safe.

---

## 🏥 Health Check

MySQL includes a healthcheck:

```code
mysqladmin ping
```
The application waits for MySQL to become healthy before starting.

---

## 📏 Final Image Size

Final image size:
~408MB (Spring Boot + Java 21 runtime)
Multi-stage build ensures:
- No Maven in runtime image
- Smaller attack surface
- Cleaner production image

---

🧪 Testing the Whole Flow

I performed a fresh environment test:
1. Removed containers and volumes
2. Removed images
3. Rebuilt using Docker Compose
4. Verified:
   - App loads at http://localhost:8080
   - User registration works
   - Transactions persist
   - Database connection successful
Everything worked successfully.

---

## 🐳 Docker Hub Image

Docker Hub Repository:

```code
https://hub.docker.com/r/shivkumarkonnuri/ai-bankapp-devops-app
```
Image tag:
```code
shivkumarkonnuri/ai-bankapp-devops-app:day36
```

---

## 🧠 Challenges Faced

1. Maven test failures due to missing database
   - Solved using: -DskipTests
2. Incorrect MySQL volume mount path
   - Corrected to /var/lib/mysql
3. Using JDK instead of JRE in runtime
   - Switched to eclipse-temurin:21-jre-alpine
4. Running container as root
   - Added non-root user
5. Git remote conflicts
   - Reconfigured origin and force pushed safely

---

## 🎯 What I Learned

- How multi-stage builds reduce image size
- Why containers should not run as root
- Importance of healthchecks
- Proper Docker networking
- Volume persistence strategy
- Production-ready container architecture
- Git remote management
