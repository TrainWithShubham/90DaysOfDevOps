Task 1: What is Docker?
Docker is an open source containerization platform that allows you to package any application along with dependencies (libraries, environment, configs, runtime) into a container so it runs consistently across environments (dev, test, production).
<img width="948" height="418" alt="Screenshot 2026-04-23 163856" src="https://github.com/user-attachments/assets/61d55b37-ffdb-4e10-ba4e-5b25cffd503f" />### 

Simple words: build app; run anywhere
A container is a lightweight, standalone unit that includes:
- Application code
- Runtime (e.g., Python, Node)
- Libraries & dependencies
  It runs on top of the host OS but stays isolated from other containers.
Why do we need containers?
Before containers:

“It works on my machine” problem 
Dependency conflicts
Difficult deployments

- We need for consistency, fast deployment, lightweight, easly scaling

Q. Containers vs Virtual Machines — what's the real difference?
COntainers vs Virtual can be differntiate for the following features are:

Virtual Containers- Works on OS-Level doesn't use hardware  whereas Virtual machines works on Hardware and software.
Size: Containers size is in MB whereas VM size is in GB
Time: Container starts time is fast in seconds whereas VM starting time is in Minutes.
Resources: Resource usuage take less whereas VM takes much time.
Application Uses: COntainer used for micro-services app but VMs used as a legacy application with running different OS (Linux, Window OS etc)

Q. What is the Docker architecture? (daemon, client, images, containers, registry)
 Docker uses a client–server architecture to build, manage, and run containers.
<img width="1536" height="1024" alt="ChatGPT Image Apr 23, 2026, 04_11_01 PM" src="https://github.com/user-attachments/assets/1bcf4c7a-8905-4969-9083-6739cc8ee620" />
 
  Docker Core Components are:
  1. Docker Client
       The tool you interact with (CLI/API)
        Example commands:
        - docker build
        - docker pull
        - docker run
            Sends requests to the Docker Daemon
  2. Docker Daemon (dockerd)
   - The main engine running in the background
    It is Responsible for building images, running containers, managing volumes & netowks
  3. Docker Images:
     Its blueprint tempalte of container
     contains application-code, runtime, install dependencies & libraries
  4. Docker Containers
  Docker container has follwing lifecycle
  - start
  - stop
  - Delete
  Docker container is running instance of images, and its lightweight and isolated.
 5. Docker Registry
    It contains running container both on public and private network
    - storing images for locally or docker hub as public repo
    1. Developer runs a command (docker run nginx)
    2. Docker Client sends request to Docker Daemon
    3. Daemon checks local system for image
    4. If not found → pulls image from Registry
    5. Daemon creates and starts Container
    6. Application runs inside container
<hr>
### Task 2: Install Docker
1. Install Docker on your machine (or use a cloud instance)
I install Ubuntu server
command for installing docker:
sudo apt update -y
sudo apt install -y docker.io
- Start and enable Docker:
sudo systemctl start docker
sudo systemctl enable docker
Run Docker without sudo:
sudo usermod -aG docker $USER docker
Log out and log back in after this
<img width="471" height="172" alt="Screenshot 2026-04-23 163054" src="https://github.com/user-attachments/assets/02fca1be-d6fc-4a79-b009-01282d6c178e" />
<img width="744" height="411" alt="Screenshot 2026-04-23 163348" src="https://github.com/user-attachments/assets/1979834b-2cbb-4b20-ad66-28417aeab2e0" />

2. Step 2: Verify Installation
docker --version
Expected output:
<img width="905" height="397" alt="Screenshot 2026-04-23 163506" src="https://github.com/user-attachments/assets/298afbbc-d67f-412b-95ac-2fac8eca80f9" />

docker info
<img width="948" height="418" alt="Screenshot 2026-04-23 163856" src="https://github.com/user-attachments/assets/3003fec3-36a1-43b2-bf8b-2573470786cd" />

Step 3: Run Hello World Container
docker run hell-world
<img width="917" height="375" alt="image" src="https://github.com/user-attachments/assets/54499547-c771-467b-b8d9-2facdb6c1ccf" />

Step 4: Understand the Output
What actually happens behind the scenes:
1. Client → Daemon
  - Your command goes from Docker Client → Docker Daemon
2. Check for Image Locally
  Docker looks for hello-world image on your system
    Not found (first time)
3. Pull from Registry
    - Docker pulls the image from Docker Hub
4. Create Container
  Docker creates a container from the image
5. Run the Container
  - The container runs and prints a message

### Task 3: Run Real Containers
1. Run an Nginx Container
   docker run -d -p 8080:80 --name my-nginx nginx
   <img width="1099" height="352" alt="image" src="https://github.com/user-attachments/assets/902cb6ae-b1cb-4008-9796-d7c3ed8ff53c" />
2. Run an Ubuntu container in interactive mode — explore it like a mini Linux machine
   <img width="987" height="505" alt="Screenshot 2026-04-23 165347" src="https://github.com/user-attachments/assets/a02f35d2-af54-4941-b5ed-3c80b6795ea7" />
3. List all running containers
   <img width="1299" height="210" alt="Screenshot 2026-04-23 165609" src="https://github.com/user-attachments/assets/7767ad3e-7d7b-4858-920d-499c28196642" />
4. List all containers (including stopped ones)
   <img width="1253" height="51" alt="Screenshot 2026-04-23 165725" src="https://github.com/user-attachments/assets/705b3e8d-a959-4377-85f1-eb7588e89d46" />
5. Stop and remove a container 
<img width="793" height="91" alt="Screenshot 2026-04-23 165924" src="https://github.com/user-attachments/assets/2cfa5e68-5117-4d92-b291-3511bb310bd5" />
<img width="830" height="134" alt="Screenshot 2026-04-23 170034" src="https://github.com/user-attachments/assets/0fd86b01-be86-444b-a3ed-32257f626f2a" />
<hr>
### Task 4: Explore
1. Run a container in detached mode — what's different?
What’s different?
-d = detached mode
Runs in background (no terminal attached)
You get container ID instead of shell
2. Give a container a custom name
docker run -d --name my-nginx nginx
3. Map a port from the container to your host
docker run -d -p 8080:80 --name web nginx
4. Check logs of a running container
docker logs web
<img width="1102" height="404" alt="Screenshot 2026-04-23 170639" src="https://github.com/user-attachments/assets/eb1c198b-f938-43d9-bbf3-6137ec2f59c3" />

5. Run a command inside a running container
docker exec -it web bash
<img width="789" height="85" alt="Screenshot 2026-04-23 170720" src="https://github.com/user-attachments/assets/ab7205f5-0e56-411c-af04-2c9d2615b522" />
<hr>
Key Concepts (Important)
-d → background execution
--name → easy management
-p → expose container to outside world
logs → debugging
exec → access running container
“In Docker, I can run containers in detached mode using -d, assign custom names using --name, map ports using -p, check logs using docker logs, and execute commands inside a running container using docker exec -it
<hr>
#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham

Happy Learning! TrainWithShubham
