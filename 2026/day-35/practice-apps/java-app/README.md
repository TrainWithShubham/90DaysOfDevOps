# Java Book API

A simple RESTful Book Manager API built with Java 17 and Spring Boot 3. Designed for Docker practice.

## Tech Stack

- **Language:** Java 17
- **Framework:** Spring Boot 3.3
- **Build Tool:** Maven
- **Server:** Embedded Tomcat

## Project Structure

```
java-app/
├── src/
│   └── main/
│       ├── java/com/example/bookapi/
│       │   ├── BookApiApplication.java   # Entry point
│       │   ├── Book.java                 # Model class
│       │   └── BookController.java       # REST controller
│       └── resources/
│           └── application.properties    # App configuration
├── pom.xml     # Maven dependencies
└── README.md
```

## API Endpoints

| Method | Endpoint          | Description       |
|--------|-------------------|-------------------|
| GET    | `/api/`           | Welcome message   |
| GET    | `/api/health`     | Health check      |
| GET    | `/api/books`      | List all books    |
| GET    | `/api/books/{id}` | Get a single book |
| POST   | `/api/books`      | Add a new book    |
| DELETE | `/api/books/{id}` | Remove a book     |

## Running Locally (without Docker)

**Prerequisites:** Java 17+, Maven 3.8+

```bash
# Build the project
mvn clean package

# Run the JAR
java -jar target/book-api-1.0.0.jar
```

App runs at: `http://localhost:8080`

## Example Requests

```bash
# Get all books
curl http://localhost:8080/api/books

# Add a book
curl -X POST http://localhost:8080/api/books \
  -H "Content-Type: application/json" \
  -d '{"title":"Clean Architecture","author":"Robert C. Martin","isbn":"978-0134494166","year":2017}'

# Delete a book
curl -X DELETE http://localhost:8080/api/books/1
```

## Docker Practice Goals

- Use multi-stage build: `maven:3.9-eclipse-temurin-17` for build stage, `eclipse-temurin:17-jre-alpine` for runtime
- Copy the fat JAR from `/target/*.jar` in the build stage
- Expose port `8080`
- Practice `ENTRYPOINT ["java", "-jar", "app.jar"]`
- Explore `JAVA_OPTS` environment variable for JVM tuning
