# Day 35 – Multi-Stage Builds & Docker Hub

## Introduction

Today I learned about multi-stage Docker builds and Docker Hub.

Multi-stage builds help reduce Docker image size by separating the build environment from the final runtime environment.

Smaller images are:

- faster
- lightweight
- secure
- easy to deploy

I also learned how to push Docker images to Docker Hub.

---

# Task 1 – Single Stage Build

## Go Application

### main.go

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello from Asma Day 35 Multi-Stage Docker App")
}
```

---

## Single Stage Dockerfile

### Dockerfile.single

```dockerfile
FROM golang:1.24

WORKDIR /app

COPY . .

RUN go build -o asma-app .

CMD ["./asma-app"]
```

---

## Build Single Stage Image

```bash
docker build -f Dockerfile.single -t asma-go-single .
```

---

## Check Image Size

```bash
docker images
```

### Result

| Image          | Size   |
| -------------- | ------ |
| asma-go-single | 1.36GB |

The image size is large because:

- Go compiler
- build tools
- source files
- cache

are included inside the final image.

---

# Task 2 – Multi-Stage Build

## Multi-Stage Dockerfile

### Dockerfile.multi

```dockerfile
FROM golang:1.24 AS builder

WORKDIR /app

COPY . .

RUN go build -o asma-app .

FROM alpine:3.22

WORKDIR /app

COPY --from=builder /app/asma-app .

CMD ["./asma-app"]
```

---

## Build Multi-Stage Image

```bash
docker build -f Dockerfile.multi -t asma-go-multi .
```

---

## Check Image Size

```bash
docker images
```

### Result

| Image         | Size   |
| ------------- | ------ |
| asma-go-multi | 16.4MB |

---

# Size Comparison

| Build Type         | Size   |
| ------------------ | ------ |
| Single Stage Build | 1.36GB |
| Multi-Stage Build  | 16.4MB |

---

# Why Multi-Stage Image is Smaller

The multi-stage image is smaller because:

- build tools are removed
- Go compiler is removed
- cache files are removed
- only the final application is copied

This makes the image lightweight and secure.

---

# Run the Container

```bash
docker run asma-go-multi
```

### Output

```text
Hello from Asma Day 35 Multi-Stage Docker App
```

---

# Task 3 – Push Image to Docker Hub

## Login to Docker Hub

```bash
docker login
```

---

## Tag Image

```bash
docker tag asma-go-multi asmasaiyed104/asma-go-multi:v1
```

```bash
docker tag asma-go-multi asmasaiyed104/asma-go-multi:latest
```

---

## Push Image

```bash
docker push asmasaiyed104/asma-go-multi:v1
```

```bash
docker push asmasaiyed104/asma-go-multi:latest
```

---

# Task 4 – Docker Hub Repository

I checked my Docker Hub repository and explored:

- image tags
- latest tag
- version tags
- repository description

---

# latest vs Specific Tag

## latest

```bash
docker pull nginx:latest
```

Downloads the newest image.

---

## Specific Tag

```bash
docker pull nginx:1.27
```

Downloads a fixed version.

Specific tags are better because they provide stable versions.

---

# Task 5 – Image Best Practices

## 1. Minimal Base Image

Used:

```dockerfile
FROM alpine:3.22
```

instead of Ubuntu.

Alpine image is much smaller.

---

## 2. Non-Root User

```dockerfile
RUN adduser -D appuser

USER appuser
```

This improves security.

---

## 3. Reduce Layers

Combined commands together.

Example:

```dockerfile
RUN apk update && apk add curl
```

---

## 4. Use Specific Tags

Good practice:

```dockerfile
FROM golang:1.24
```

Avoid:

```dockerfile
FROM golang:latest
```

Specific versions make builds stable.

---

# Final Optimized Dockerfile

```dockerfile
FROM golang:1.24 AS builder

WORKDIR /app

COPY . .

RUN go build -o asma-app .

FROM alpine:3.22

WORKDIR /app

COPY --from=builder /app/asma-app .

CMD ["./asma-app"]
```

---

# What I Learned

Today I learned:

- single-stage build
- multi-stage build
- image optimization
- Docker Hub push and pull
- image tagging
- Docker image best practices

---

# Conclusion

Multi-stage builds are very useful in real DevOps projects because they create smaller and optimized Docker images.

Docker Hub helps share and distribute images easily across systems and teams.
