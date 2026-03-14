# Day 31 – Dockerfile: Build Your Own Images

## Challenge Tasks

### Task 1: Your First Dockerfile

### 1. Create a Folder

First, create a new folder for the Docker image.

Command:

mkdir my-first-image  
cd my-first-image  

This folder will store the Dockerfile used to build the custom image.

---

### 2. Create a Dockerfile

Inside the folder, create a file named **Dockerfile**.

Command:

nano Dockerfile

Add the following content:

FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl

CMD ["echo", "Hello from my custom image!"]

Explanation:

FROM ubuntu:latest  
- Uses Ubuntu as the base image.

RUN apt-get update && apt-get install -y curl  
- Updates the package list and installs curl inside the image.

CMD ["echo", "Hello from my custom image!"]  
- Sets the default command that runs when the container starts.

Save and exit the file.

---

### 3. Build the Image

Now build the Docker image and give it the tag **my-ubuntu:v1**.

Command:

docker build -t my-ubuntu:v1 .

Explanation:

docker build → builds an image from the Dockerfile  
-t → assigns a tag to the image  
my-ubuntu:v1 → image name and version  
. → current directory where the Dockerfile is located

---

### 4. Run a Container from the Image

Run a container using the custom image.

Command:

docker run my-ubuntu:v1

---

### Verify Output

Expected output:

Hello from my custom image!

If this message appears, it confirms that the Dockerfile was built successfully and the container executed the default command.





## Task 2: Dockerfile Instructions

In this task, we will create a Dockerfile that uses common Dockerfile instructions such as FROM, RUN, COPY, WORKDIR, EXPOSE, and CMD.

---

### 1. Create a New Folder

First, create a new folder for this project.

Command:

mkdir dockerfile-demo  
cd dockerfile-demo  

---

### 2. Create a Sample File

Create a simple file that will be copied into the Docker image.

Command:

nano index.html

Add the following content:

Hello from Dockerfile demo

Save and exit the file.

---

### 3. Create a Dockerfile

Now create the Dockerfile.

Command:

nano Dockerfile

Add the following content:

FROM nginx:latest

RUN apt-get update

WORKDIR /usr/share/nginx/html

COPY index.html .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

Explanation:

FROM nginx:latest  
- Sets nginx as the base image.

RUN apt-get update  
- Runs a command during the image build process.

WORKDIR /usr/share/nginx/html  
- Sets the working directory inside the container.

COPY index.html .  
- Copies the index.html file from the host machine into the container.

EXPOSE 80  
- Documents that the container listens on port 80.

CMD ["nginx", "-g", "daemon off;"]  
- Defines the default command to run when the container starts.

Save and exit the file.

---

### 4. Build the Image

Build the Docker image using the Dockerfile.

Command:

docker build -t dockerfile-demo:v1 .

---

### 5. Run the Container

Run the container and map port 80.

Command:

docker run -p 8080:80 dockerfile-demo:v1

---

### Verify

Open your browser and visit:

http://localhost:8080

You should see the message:

Hello from Dockerfile demo

This confirms that the Dockerfile instructions worked correctly.





## Task 3: CMD vs ENTRYPOINT

In this task, we will understand the difference between **CMD** and **ENTRYPOINT** in a Dockerfile.

---

### 1. Create an Image Using CMD

First, create a new folder.

Command:

mkdir cmd-demo  
cd cmd-demo  

Create a Dockerfile.

Command:

nano Dockerfile

Add the following content:

FROM ubuntu:latest

CMD ["echo", "hello"]

Save and exit.

---

### Build the Image

Command:

docker build -t cmd-image:v1 .

---

### Run the Container

Command:

docker run cmd-image:v1

Output:

hello

---

### Run with a Custom Command

Command:

docker run cmd-image:v1 echo "custom message"

Output:

custom message

Explanation:

- **CMD provides a default command.**
- When we pass another command in `docker run`, it **overrides the CMD instruction**.

---

### 2. Create an Image Using ENTRYPOINT

Create another Dockerfile.

Command:

nano Dockerfile

Add the following content:

FROM ubuntu:latest

ENTRYPOINT ["echo"]

Save and exit.

---

### Build the Image

Command:

docker build -t entrypoint-image:v1 .

---

### Run the Container

Command:

docker run entrypoint-image:v1 hello

Output:

hello

---

### Run with Additional Arguments

Command:

docker run entrypoint-image:v1 hello world

Output:

hello world

Explanation:

- **ENTRYPOINT sets the main command that always runs.**
- Any arguments provided in `docker run` are **added to the ENTRYPOINT command**, not replaced.

Example:

ENTRYPOINT → echo  
Argument → hello world  

Final command executed:

echo hello world

---

### CMD vs ENTRYPOINT

CMD:

- Provides a **default command**
- Can be **overridden easily** by the user

ENTRYPOINT:

- Defines the **main command that always runs**
- Additional arguments are **appended**, not replaced

---

### When to Use CMD vs ENTRYPOINT

Use **CMD** when:

- You want a **default command that users can override**
- The container may run **different commands**

Use **ENTRYPOINT** when:

- The container should behave like a **specific executable**
- You want the **main command to always run**





## Task 4: Build a Simple Web App Image

In this task, we will build a simple Docker image that serves a static HTML website using **Nginx**.

---

### 1. Create a Project Folder

First, create a new folder for the web app.

Command:

mkdir my-website  
cd my-website  

---

### 2. Create a Static HTML File

Create an HTML file that will be served by Nginx.

Command:

nano index.html

Add the following content:

<html>
<head>
<title>My Docker Website</title>
</head>
<body>
<h1>Hello from my Docker website!</h1>
<p>This page is served using Nginx inside a Docker container.</p>
</body>
</html>

Save and exit the file.

---

### 3. Create the Dockerfile

Now create the Dockerfile.

Command:

nano Dockerfile

Add the following content:

FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

Explanation:

FROM nginx:alpine  
- Uses a lightweight Nginx image based on Alpine Linux.

COPY index.html /usr/share/nginx/html/index.html  
- Copies the HTML file from the host machine to the default Nginx web directory inside the container.

Save and exit the file.

---

### 4. Build the Docker Image

Build the image and tag it **my-website:v1**.

Command:

docker build -t my-website:v1 .

---

### 5. Run the Container with Port Mapping

Run the container and map port **8080** on your system to port **80** inside the container.

Command:

docker run -p 8080:80 my-website:v1

---

### Verify

Open your browser and go to:

http://localhost:8080

You should see your custom HTML page:

Hello from my Docker website!

This confirms that the website is successfully running inside the Docker container.





## Task 5: .dockerignore

In this task, we will learn how to use a **.dockerignore** file to prevent unnecessary files from being included in the Docker build context.

---

### 1. Create a `.dockerignore` File

Inside your project folder, create a file named **.dockerignore**.

Command:

nano .dockerignore

---

### 2. Add Ignore Rules

Add the following entries to the file:

node_modules  
.git  
*.md  
.env  

Explanation:

node_modules  
- Prevents large dependency folders from being sent to Docker during build.

.git  
- Excludes the Git repository and history.

*.md  
- Ignores markdown files such as README.md.

.env  
- Prevents environment variable files from being included for security reasons.

Save and exit the file.

---

### 3. Build the Docker Image

Now build the Docker image again.

Command:

docker build -t dockerignore-demo:v1 .

During the build process, Docker will **exclude the files and folders listed in `.dockerignore`**.

---

### Verify

To verify, check the build context size when running the build command.

Example output:

Sending build context to Docker daemon  5.2kB

If `.dockerignore` is working correctly:

- Ignored files will **not be sent to Docker**
- The **build context size will be smaller**
- Sensitive or unnecessary files will **not be included in the image**

---

### Summary

In this task you learned:

- What a `.dockerignore` file is
- How to exclude unnecessary files from Docker builds
- How `.dockerignore` helps reduce image size
- How it improves security by excluding sensitive files




## Task 5: Cleanup

In this task, we will clean up Docker resources such as running containers, stopped containers, and unused images.

---

### 1. Stop All Running Containers

To stop all running containers in one command, use:

Command:

docker stop $(docker ps -q)

---

### 2. Remove All Stopped Containers

After containers are stopped, you can remove them with:

Command:

docker container prune

---

### 3. Remove Unused Images

To remove images that are not used by any container, run:

Command:

docker image prune

This helps free up disk space by deleting unused images.

---

### 4. Check Docker Disk Usage

To see how much disk space Docker is using, run:

Command:

docker system df

