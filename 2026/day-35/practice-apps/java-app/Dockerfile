FROM maven:3.9.9-eclipse-temurin-17

# Metadata
LABEL maintainer="SUMIT" \
      version="1.0" \
      description="Book API - single stage with best practices"

# Environment optimization
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"

# Create non-root user early
RUN useradd -m javausr

WORKDIR /app

# Copy only pom.xml first (better caching)
COPY pom.xml ./

# Cache dependencies (quiet + batch mode)
RUN mvn -B -q -e -DskipTests dependency:go-offline

# Copy source separately
COPY src ./src

# Build + rename jar (fixed typo skipTests)
RUN mvn -B -q -DskipTests clean package \
    && cp target/book-api-1.0.0.jar app.jar

# Change ownership for security
RUN chown -R javausr:javausr /app

# Switch to non-root user
USER javausr

# Expose only required port
EXPOSE 8080

# Use exec form with env support
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
