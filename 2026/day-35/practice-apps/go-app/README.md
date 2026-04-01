# Go Product API

A lightweight RESTful Product Manager API built with Go using only the standard library. Designed for Docker practice.

## Tech Stack

- **Language:** Go 1.22
- **Framework:** Standard library (`net/http`)
- **Dependencies:** None (zero external dependencies!)

## Project Structure

```
go-app/
├── main.go    # All-in-one: models, handlers, server
├── go.mod     # Go module definition
└── README.md
```

## API Endpoints

| Method | Endpoint            | Description          |
|--------|---------------------|----------------------|
| GET    | `/`                 | Welcome message      |
| GET    | `/health`           | Health check         |
| GET    | `/products`         | List all products    |
| GET    | `/products/{id}`    | Get a single product |
| POST   | `/products`         | Create a product     |
| DELETE | `/products/{id}`    | Delete a product     |

## Running Locally (without Docker)

**Prerequisites:** Go 1.22+

```bash
# Run directly
go run main.go

# Or build and run the binary
go build -o server .
./server
```

App runs at: `http://localhost:8080`

## Example Requests

```bash
# Get all products
curl http://localhost:8080/products

# Create a product
curl -X POST http://localhost:8080/products \
  -H "Content-Type: application/json" \
  -d '{"name":"USB Hub","price":34.99,"category":"Electronics","in_stock":true}'

# Get product by ID
curl http://localhost:8080/products/1

# Delete a product
curl -X DELETE http://localhost:8080/products/2
```

## Docker Practice Goals

- Use multi-stage build: `golang:1.22-alpine` for build, `alpine:3.19` (or `scratch`) for runtime
- Build a static binary: `CGO_ENABLED=0 GOOS=linux go build -o server .`
- Expose port `8080`
- Notice how tiny the final image is compared to Java/Python!
- Practice using `scratch` as base image for minimal containers
