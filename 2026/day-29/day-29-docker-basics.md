Task 1: What is Docker?

Research and write short notes on:

**What is a container and why do we need them? **
----------------------------------------------
container is a collection of resources packaged together to run the application anywhere. 
we need containers because it solves software deployment issue/dependies. like develore saying code runs on my system but not on client system.

**Containers vs Virtual Machines — what's the real difference?**
-------------------------------------------------
containers is a light weight coz it share the resource with the given OS and does not need to assign seperate RAM, storage ,ETC.
Whereas in VM, we need huge storage, RAM, starting and stoping VM process is ver slow

**What is the Docker architecture? (daemon, client, images, containers, registry)
Draw or describe the Docker architecture in your own words.
**
--------------------------------------------
daemon (dockerD) is the main engine. basically it the service that runs in backgroud and manages all images , container , volumes
client is the CLI through which we interact with docker
registery is a place where all the images are stored  to be used . Example, DockerHub, private registry.
A Docker image is a read-only template that contains the application code, runtime, libraries, and dependencies needed to create a container.
container is an isolated instance where your application  is running created from a docker image while share host kernel OS

**
Task 2: Install Docker

Install Docker on your machine (or use a cloud instance)
Verify the installation
Run the hello-world container
Read the output carefully — it explains what just happened**
---------------------------------------

<img width="800" height="404" alt="Screenshot 2026-03-05 at 1 02 38 PM" src="https://github.com/user-attachments/assets/0cfc248e-97bc-42c0-9958-41f23c6550b8" />


**Task 3: Run Real Containers**

Run an Nginx container and access it in your browser
Run an Ubuntu container in interactive mode — explore it like a mini Linux machine
List all running containers
List all containers (including stopped ones)
Stop and remove a container

<img width="870" height="151" alt="Screenshot 2026-03-05 at 1 12 47 PM" src="https://github.com/user-attachments/assets/529b3b84-83b4-471c-ac42-4bee22b1f7b6" />


<img width="788" height="391" alt="Screenshot 2026-03-05 at 1 13 04 PM" src="https://github.com/user-attachments/assets/8060c9d9-2592-4c04-bf90-e5229ab835ad" />

**docker rm **
--------------
<img width="867" height="132" alt="Screenshot 2026-03-05 at 1 13 42 PM" src="https://github.com/user-attachments/assets/c2e18b7c-5e21-485b-903e-4678835eac55" />

