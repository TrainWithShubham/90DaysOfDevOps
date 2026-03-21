90 Days of DevOps
Day 31
Dockerfile: Build Your Own Images
Write Dockerfiles. Build custom images. Ship software.
#DevOpsKaJosh  |  #TrainWithShubham
Overview

A Dockerfile is a text file containing instructions to build a Docker image. Every instruction creates a new layer in the image. Understanding Dockerfiles is the key difference between someone who uses Docker and someone who actually ships software with Docker.

Today's Learning Goal
Write Dockerfiles from scratch, understand every core instruction, grasp the difference between CMD and ENTRYPOINT, build a real web app image, and learn cache-aware layer optimization.

Task 1: Your First Dockerfile

Project Structure
my-first-image/
└── Dockerfile

Dockerfile
# my-first-image/Dockerfile
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

CMD ["echo", "Hello from my custom image!"]

Build and Run
# Build and tag the image
docker build -t my-ubuntu:v1 .

# Run a container from your new image
docker run my-ubuntu:v1

# Expected output:
# Hello from my custom image!

What just happened?
Docker read each instruction top-to-bottom. FROM pulled ubuntu:22.04 as the base layer. RUN executed apt-get inside a temporary container and committed the result as a new layer. CMD stored the default command metadata — it runs when you do docker run.

Task 2: Dockerfile Instructions

A Dockerfile Using Every Core Instruction
# Task2/Dockerfile
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package files first (cache-friendly — see Task 6)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Document that the app listens on port 3000
EXPOSE 3000

# Default command to start the app
CMD ["node", "server.js"]

What Each Instruction Does
Instruction	Purpose
FROM node:20-alpine	Sets the base image. Every Dockerfile must start with FROM. Alpine variants are smaller (~5 MB vs ~900 MB).
WORKDIR /app	Creates the directory if needed and sets it as the current directory for all subsequent instructions.
COPY package*.json ./	Copies files from the build context (your machine) into the image at the WORKDIR path.
RUN npm install	Executes a shell command during the build. Creates a new image layer with the results.
COPY . .	Copies the rest of the source code. Placed after RUN npm install to maximize cache hits.
EXPOSE 3000	Documents the intended port. Does NOT actually publish the port — that requires -p at runtime.
CMD ["node", "server.js"]	Sets the default command when the container starts. Can be overridden at docker run.

Task 3: CMD vs ENTRYPOINT

CMD — Overridable Default
# cmd-demo/Dockerfile
FROM alpine
CMD ["echo", "hello"]

docker build -t cmd-demo .

docker run cmd-demo
# Output: hello

docker run cmd-demo echo goodbye
# Output: goodbye    (CMD was replaced entirely)

ENTRYPOINT — Fixed Executable
# ep-demo/Dockerfile
FROM alpine
ENTRYPOINT ["echo"]

docker build -t ep-demo .

docker run ep-demo
# Output: (empty line — echo with no args)

docker run ep-demo hello devops world
# Output: hello devops world   (args appended to ENTRYPOINT)

CMD + ENTRYPOINT Together
FROM alpine
ENTRYPOINT ["echo"]
CMD ["default message"]

# docker run → Output: default message
# docker run my-img custom msg → Output: custom msg

When to Use Each
Use Case	Instruction
Container is a utility/tool (curl, aws-cli)	ENTRYPOINT — lock in the executable, pass args at runtime
Container runs a service (web app, API)	CMD — define default start command, easy to override for debugging
Want a default arg but allow override	ENTRYPOINT + CMD together: ENTRYPOINT is the binary, CMD is the default flag/arg
Simple scripting or ad-hoc commands	CMD — most flexible for dev and experimentation

Task 4: Build a Simple Web App Image

Project Files
Create two files in a folder called my-website/:

index.html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>My Docker Site</title>
    <style>
      body { font-family: Arial, sans-serif; background: #0f172a;
             color: #e2e8f0; display: flex; justify-content: center;
             align-items: center; height: 100vh; margin: 0; }
      h1 { color: #60a5fa; }
    </style>
  </head>
  <body>
    <div>
      <h1>Hello from Docker!</h1>
      <p>Day 31 — Served by Nginx inside a container.</p>
    </div>
  </body>
</html>

Dockerfile
FROM nginx:alpine

# Remove default Nginx welcome page
RUN rm -rf /usr/share/nginx/html/*

# Copy our HTML into the Nginx web root
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

Build and Run
docker build -t my-website:v1 .

docker run -d -p 8080:80 --name my-site my-website:v1

# Visit http://localhost:8080 in your browser

Why nginx:alpine?
The full nginx image is ~140 MB. The alpine variant is only ~23 MB — over 6x smaller. For a static site, you get identical functionality with a fraction of the storage and pull time. Always prefer alpine base images in production.

Task 5: .dockerignore

A .dockerignore file tells Docker which files to exclude from the build context. The build context is everything in the current directory that gets sent to the Docker daemon — even files you never COPY. A large context means slower builds.

.dockerignore File
# .dockerignore

# Node dependencies (rebuilt inside container)
node_modules

# Version control
.git
.gitignore

# Documentation (not needed in image)
*.md
README*

# Secrets — never bake into images!
.env
*.env.*

# Build artifacts and test files
dist/
coverage/
*.test.js

Verify Ignored Files Are Excluded
# Add a test file that should be ignored
echo 'secret' > .env
echo 'big data' > README.md

# Build and check the image filesystem
docker build -t ignore-test .
docker run --rm ignore-test ls -la /app

# .env and README.md should NOT appear

Security Rule
Never COPY . . without a .dockerignore. You risk baking .env secrets, AWS credentials, or SSH keys into your image. Once pushed to a registry, those secrets are exposed. Always add .dockerignore before your first COPY.

Task 6: Build Optimization & Layer Caching

How Docker Layer Caching Works
Each Dockerfile instruction creates an immutable layer. When you rebuild, Docker checks if the instruction and its inputs have changed. If nothing changed, Docker reuses the cached layer — skipping the work entirely. Once a layer is invalidated (changed), ALL subsequent layers are rebuilt too.

Bad Layer Order — Slow Rebuilds
# SLOW: source code copied before installing deps
FROM node:20-alpine
WORKDIR /app
COPY . .
RUN npm install
CMD ["node", "server.js"]

Problem: Every time you change any source file, Docker invalidates the COPY . . layer — and then re-runs npm install from scratch, even though your package.json did not change. That npm install could take 60+ seconds on every build.

Optimized Layer Order — Fast Rebuilds
# FAST: deps installed before copying all source code
FROM node:20-alpine
WORKDIR /app

# 1. Copy only dependency manifests (rarely change)
COPY package*.json ./

# 2. Install dependencies (cached until package.json changes)
RUN npm install --production

# 3. Copy source code last (changes on every edit — no cache loss above)
COPY . .

CMD ["node", "server.js"]

Now when you edit server.js and rebuild, Docker reuses the cached node_modules layer and only re-copies your source. Build time drops from 60+ seconds to under 2 seconds.

Cache Invalidation Demonstration
# First build — all layers built from scratch
docker build -t cache-demo .

# Edit any source file...
echo 'console.log("v2")' >> server.js

# Rebuild — watch which layers say 'CACHED'
docker build -t cache-demo .
# You will see:
# => CACHED [2/4] WORKDIR /app
# => CACHED [3/4] COPY package*.json ./
# => CACHED [4/4] RUN npm install     <-- this is the win!
# => [5/4] COPY . .                   <-- only this re-runs

Layer Optimization Rules
Rule	Why It Matters
Put rarely-changing instructions first	Maximize cache hits. Base image, system packages, and dependencies change infrequently.
COPY package.json before COPY . .	npm install/pip install are slow. Cache them separately from your changing source code.
Combine RUN commands with &&	Each RUN is a layer. Chaining commands reduces layer count and final image size.
Clean up in the same RUN	apt-get cache must be removed in the same layer it was created, or it stays in the image.
Use .dockerignore	Reduces build context size → faster COPY . . → less invalidation noise.
Prefer alpine base images	Smaller base = fewer layers to pull, push, and cache.

Combining RUN Commands
# BAD: 3 separate layers
RUN apt-get update
RUN apt-get install -y curl
RUN rm -rf /var/lib/apt/lists/*

# GOOD: 1 layer — smaller image, cleaner cache
RUN apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

Dockerfile Instruction Quick Reference

Instruction	Description
FROM <image>	Set the base image. Required as the first instruction.
WORKDIR <path>	Set (and create) the working directory for subsequent instructions.
COPY <src> <dest>	Copy files from build context into the image.
RUN <command>	Execute a command at build time. Creates a new layer.
EXPOSE <port>	Document the port the container listens on (informational only).
ENV KEY=value	Set environment variables available at build and run time.
ARG NAME=default	Define build-time variables passed with --build-arg.
CMD ["cmd","arg"]	Default command when container starts. Overridable at docker run.
ENTRYPOINT ["cmd"]	Fixed executable for the container. Args appended at docker run.
VOLUME ["path"]	Create a mount point for persistent data.
USER name	Set the user for subsequent RUN/CMD/ENTRYPOINT instructions.
LABEL key=value	Add metadata to the image (author, version, description).

Day 31 Complete 
#90DaysOfDevOps  |  #DevOpsKaJosh  |  #TrainWithShubham
Happy Learning!  —  TrainWithShubham
