# Day 31 – Dockerfile: Build Your Own Images
## Task 1: Your First Dockerfile
1. Create a folder called my-first-image - `mkdir my-first-image`
2. Inside it, create a Dockerfile that:
Uses ubuntu as the base image
Installs curl
Sets a default command to print "Hello from my custom image!"

### Dockerfile
```
FROM ubuntu

WORKDIR /app

#install curl

RUN apt-get update && apt-get install -y curl

#default command

CMD ["echo", "Hello from my custom image!"]
```
Step:1 `docker build -t my-ubuntu:v1 .` # build an image & . is the current folder where the Dockerfile is located.
Step:2 `docker images` - will show the docker image "my-ubuntu & the tag is V1"
step:3 `docker run my-ubuntu:v1` - created a container from the image 
Output: `Hello from my custom image!`

## Task 2: Dockerfile Instructions
```
FROM nginx

FROM ubuntu

RUN apt-get update && apt-get install -y curl

WORKDIR /app

COPY app.sh /app/app.sh

EXPOSE 8080

CMD ["./app.sh"]
```
## Write in your notes: When would you use CMD vs ENTRYPOINT?
- Use ENTRYPOINT when your container has a single, fixed purpose — like a tool (ping, curl, ffmpeg). The command should always run and shouldn't change.
- Use CMD when you want a default behavior that users can easily override at runtime
- Use both together when you want a fixed executable (ENTRYPOINT) but flexible default arguments (CMD) — this is the most common production pattern.

## Task 4: Build a Simple Web App Image
### Dockerfile
```
FROM nginx:alpine

WORKDIR /app

COPY index.html /usr/share/nginx/html/
```
1. Step:1 - `docker build -t webapp-demo:v1 .`
2. Step:2 - `docker run -d -p 8080:80 webapp-demo:v1`
2. Step:3 run the index file on browser on port 8080. Make sure it is availble in security group.

## Task 5: .dockerignore
1. Step:1 `vim .dockerignore`
2. Step:2 make the files and folders - mkdir node_modules, touch test.md, touch .env & mkdir .git
3. Step:3 vim Dockerfile
```
FROM ubuntu

WORKDIR /app

COPY . .

CMD ["ls", "-a"]
```
4. `docker build -t ignore-demo:v1 .`
5. `docker run ignore-demo`
6. Output - It will not show dockerignore files
```
.
..
.dockerignore
Dockerfile
app.sh
devops-nginx-demo
```
## Task 6: Build Optimization
### Note: Why does layer order matter for build speed?
- Docker builds images layer by layer and caches each one. When a layer changes, Docker invalidates the cache for that layer and every layer after it — forcing them all to rebuild. By putting frequently changing lines (like COPY . .) at the bottom, the expensive layers above (like RUN npm install) stay cached and are skipped. This can reduce build time from minutes to just seconds.