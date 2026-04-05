# Day 31 – Dockerfile: Build Your Own Images
## Overview
Today's goal is to write Dockerfiles and build custom images. This skill separates someone who just uses Docker from someone who actually ships Docker images.

## Task 1: First Dockerfile
Folder: my-first-image
Dockerfile:

FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl

CMD ["echo", "Hello from my custom image!"]

Build & Run:

docker build -t my-ubuntu:v1 .

docker run my-ubuntu:v1

Expected Output:
Hello from my custom image!

## Task 2: Dockerfile Instructions
Dockerfile using all key instructions:

FROM ubuntu:latest

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y curl

EXPOSE 8080

CMD ["echo", "This is a custom image with all instructions!"]

Build & Run:

docker build -t my-ubuntu-full:v1 .

docker run my-ubuntu-full:v1

## Task 3: CMD vs ENTRYPOINT
CMD Example:

FROM ubuntu:latest

CMD ["echo", "hello"]

docker run image → prints hello

docker run image hi → prints hi (CMD is overridden)

ENTRYPOINT Example:

FROM ubuntu:latest

ENTRYPOINT ["echo"]

docker run image → prints nothing

docker run image hello → prints hello

Notes: Use CMD for default commands that can be overridden. Use ENTRYPOINT for commands that should always run, with optional arguments appended.

## Task 4: Build a Simple Web App Image

Static HTML: index.html
<!DOCTYPE html>
<html>
<head><title>My Website</title></head>
<body>
<h1>Hello from my Dockerized website!</h1>
</body>
</html>
Dockerfile:

FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

Build & Run:

docker build -t my-website:v1 .

docker run -d -p 8080:80 my-website:v1

Verify: Open http://localhost:8080 in browser.

## Task 5: .dockerignore
Create .dockerignore:

node_modules

.git

*.md

.env

Effect: These files are ignored during Docker build, reducing image size.

## Task 6: Build Optimization
Build an image, change a single line, rebuild → notice cached layers speed up build.

Reorder Dockerfile: place frequently changing lines last (COPY, RUN scripts).

Why layer order matters: Docker caches each layer. If early layers rarely change, they are reused, speeding up builds. Only layers after the changed line are rebuilt.

Example Optimized Dockerfile:

FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

Rebuild:

docker build -t my-website:v2 .


