# Build stage
FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /app
COPY . .
RUN chmod +x mvnw && ./mvnw clean package -DskipTests -B

# Run stage - alpine has significantly fewer CVEs than ubuntu/jammy
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Pull latest security patches for OS libraries
RUN apk update && apk upgrade --no-cache

# Create a non-root user for security (Alpine uses addgroup/adduser instead of groupadd/useradd)
RUN addgroup -S devsecops && adduser -S -G devsecops devsecops
USER devsecops

# Copy only the built artifact
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
