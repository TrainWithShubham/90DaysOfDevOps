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

Uses Maven image

Builds the JAR file

Skips tests for container build

**Stage 2 (Runtime):**

Uses lightweight JRE alpine image

Copies only the JAR file

Runs as non-root user

Minimal and secure
