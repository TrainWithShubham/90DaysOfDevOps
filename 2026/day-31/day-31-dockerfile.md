# Day 31 – Dockerfile & Custom Images

## Introduction

Today I learned how to create my own Docker images using Dockerfile.

I practiced:

- building custom images
- Dockerfile instructions
- CMD vs ENTRYPOINT
- running custom website in Docker
- .dockerignore
- Docker build cache

---

# Task 1 – My First Dockerfile

I created my first Dockerfile using Ubuntu base image.

Dockerfile:

```dockerfile
FROM ubuntu

RUN apt-get update && apt-get install -y curl

WORKDIR /app

COPY . .

CMD ["echo","Hello Friends"]
```

---

# Build Image

```bash
docker build -t asma-file .
```

This created a custom Docker image.

---

# Run Container

```bash
docker run asma-file
```

Output:

```text
Hello Friends
```

---

# What I Learned

## FROM

```dockerfile
FROM ubuntu
```

Uses Ubuntu as base image.

---

## RUN

```dockerfile
RUN apt-get update && apt-get install -y curl
```

Runs commands during image build time.

Used to install packages.

---

## WORKDIR

```dockerfile
WORKDIR /app
```

Sets working directory inside container.

---

## COPY

```dockerfile
COPY . .
```

Copies files from host machine into Docker image.

---

## CMD

```dockerfile
CMD ["echo","Hello Friends"]
```

Runs default command when container starts.

---

# Important Understanding

Container stays alive only while the main process is running.

Since:

```dockerfile
CMD ["echo","Hello Friends"]
```

finishes quickly, the container exits immediately.

---

# Task 2 – Dockerfile Instructions

Dockerfile:

```dockerfile
FROM ubuntu

RUN apt-get update && apt-get install -y curl

WORKDIR /app

COPY message.txt .

EXPOSE 8080

CMD ["cat", "message.txt"]
```

---

# What I Learned

## EXPOSE

```dockerfile
EXPOSE 8080
```

Documents the port used by application inside container.

---

## COPY message.txt .

Copies file into current working directory inside container.

---

# RUN vs CMD

| RUN                         | CMD                               |
| --------------------------- | --------------------------------- |
| Executes during image build | Executes during container startup |

---

# Task 3 – CMD vs ENTRYPOINT

## CMD Example

Dockerfile:

```dockerfile
FROM ubuntu

CMD ["echo", "hello from CMD"]
```

Run:

```bash
docker run cmd-demo:v1
```

Output:

```text
hello from CMD
```

Override command:

```bash
docker run cmd-demo:v1 echo "custom message"
```

Output:

```text
custom message
```

I learned:

- CMD can be overridden.

---

## ENTRYPOINT Example

Dockerfile:

```dockerfile
FROM ubuntu

ENTRYPOINT ["echo"]
```

Run:

```bash
docker run entrypoint-demo:v1 hello from entrypoint
```

Output:

```text
hello from entrypoint
```

I learned:

- ENTRYPOINT acts like fixed executable.
- Additional arguments get appended.

---

# CMD vs ENTRYPOINT

| CMD               | ENTRYPOINT             |
| ----------------- | ---------------------- |
| Default command   | Fixed executable       |
| Easily overridden | Usually not overridden |

---

# Task 4 – Custom Website Using Nginx

I created a simple HTML website.

## index.html

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Asma Docker Website</title>
  </head>
  <body>
    <h1>Hello from Asma's custom Docker image!</h1>
    <p>This website is running inside an Nginx container.</p>
  </body>
</html>
```

---

# Website Dockerfile

```dockerfile
FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

---

# Build Image

```bash
docker build -t my-website:v1 .
```

---

# Run Container

```bash
docker run -d -p 8080:80 --name asma-website my-website:v1
```

---

# Browser Access

```text
http://localhost:8080
```

---

# What I Learned

- Nginx serves files from:

```text
/usr/share/nginx/html/
```

- `daemon off;` keeps nginx running in foreground.
- Long-running process keeps container alive.

---

# Task 5 – .dockerignore

I created:

```text
.dockerignore
```

Content:

```text
node_modules
.git
*.md
.env
```

---

# What I Learned

`.dockerignore` prevents unnecessary files from being sent to Docker build context.

Benefits:

- smaller image size
- faster builds
- better security
- avoids copying secrets

---

# Important Docker Concepts Learned

## Image

Read-only template used to create containers.

---

## Container

Running instance of an image.

---

## Build Context

Files Docker sends to daemon during image build.

---

## Layers

Each Dockerfile instruction creates a layer.

Docker uses layers for:

- caching
- faster builds
- storage optimization

---

# Interview Questions I Learned

## What is Dockerfile?

Dockerfile is a text file containing instructions to build a custom Docker image.

---

## Difference between image and container?

Image is a template. Container is a running instance of image.

---

## Difference between RUN and CMD?

RUN executes during image build. CMD executes during container startup.

---

## Why use nginx:alpine?

Because Alpine is lightweight and reduces image size.

---

## Why container exits automatically sometimes?

Because container stays alive only while main process is running.

---

# Conclusion

Today I learned:

- how to create custom Docker images
- Dockerfile instructions
- CMD vs ENTRYPOINT
- building website containers
- .dockerignore
- Docker caching and optimization

This lab helped me understand how real Docker images are built and managed in DevOps environments.
