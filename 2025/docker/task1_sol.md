### Task 1: Introduction and Conceptual Understanding
1. **Write an Introduction:**  
   - In your `solution.md`, provide a brief explanation of Docker’s purpose in modern DevOps.
   - Compare **Virtualization vs. Containerization** and explain why containerization is the preferred approach for microservices and CI/CD pipelines.


### Introduction to Docker 

Docker is an OS‑level virtualization (or containerization) platform, which allows applications to share the host OS kernel instead of running a separate guest OS like in traditional virtualization. This design makes Docker containers lightweight, fast, and portable, while keeping them isolated from one another.

** Containers vs. virtualization **
Containers are an abstraction that packages application code and dependencies together. Instances of the container can then be created, started, stopped, moved, or deleted using the Docker API or command-line interface (CLI). Containers can be connected to one or more networks, be attached to storage, or create new images based on their current states. 

Containers differ from virtual machines, which use a software abstraction layer on top of computer hardware, allowing the hardware to be shared more efficiently in multiple instances that will run individual applications. Docker containers require fewer physical hardware resources than virtual machines, and they also offer faster startup times and lower overhead. This makes Docker ideal for high-velocity environments, where rapid software development cycles and scalability are crucial. 

![alt text](image-1.png)

Containerization is the preferred approach for microservices and CI/CD pipelines because it offers crucial benefits such as isolation, consistency, and portability. These benefits streamline development, testing, and deployment, making the entire process faster and more reliable.
