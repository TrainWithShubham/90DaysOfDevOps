## **Task 1**

## what is Container?
Container is light weight, standalone and executable software packages that includes everything need to run an aplication
like  code, runtime, system tools, libraries, and settings. 
Container run on the host OS level of the system. It's share the available resouses of the system as per requirement.
A Conatainer is runing instance of docker image.
#### Why we need  conatainer?
# 1. Environment Consistency
 Same App run on the different ways: 
1. Local
2. EC2 instace
3. Kubernetes
4. Cloud
    No Environment Mismatch
# 2. Isolation 
Container isolates the application 
Example:
. App1 needs Python 3.8
 .Apps2 needs python 3.11
  They Won't conflict
  # 3. Lightweight (Important Difference from VM)
  Containers share host OS kernel.
   Unlike virtual machine:
. No Full OS inside 
. Fatster Startup 
. Less memory usage
  # 4. Faster Deployment 
 Start container in seconds where VMs takes minutes.
  # 5. Scalability
  We can multile conatainer at time. Used in microservices.
  # 6. Microservices Architecture
    Modern apps are built as:
    1. payment-services
    2. Auth services 
    3. Order services
Each runs in it's own container.

# Containers vs Virtual Machines — what's the real difference?
🔹 Virtual Machine (VM)

```
Hardware
   ↓
  Hypervisor (VMware / VirtualBox / KVM)
   ↓
  Guest OS
   ↓
 Application + Dependencies
```

Each VM has it's own:
1. Its full own OS
2. Its own kernel
3. Its own system libraries

 🔹 Conatainer

```
Hardware
   ↓
Host OS
   ↓
Docker Engine
   ↓
Containers (App + Dependencies)
```
Conatainers:
1. Shared host OS Kernal
2. Only package app+dependencies
3. No separate OS

# Docker Architechture
```
+------------------+
|   Docker Client  |
|  (docker CLI)    |
+---------+--------+
          |
          | REST API
          v
+--------------------------+
|     Docker Daemon        |
|      (dockerd)           |
|--------------------------|
|  Images                  |
|  Containers              |
|  Networks                |
|  Volumes                 |
+-----------+--------------+
            |
            |
            v
+------------------+
| Docker Registry  |
| (DockerHub/ECR)  |
+------------------+
```

**Client**
Docker Client takes the command and send them to daemon using REST API.
 Example: 
 ```
docker build
docker run
docker pull
```
Client & daemon can run on same machine or different machines.

**Docker Daemon**

Docker daemon is the brain of docker engine. 
It:
* Manage Networks
* Build Images
* Run Conatainers
* Manage Volumes

**Docker Registry**
A Docker registry is a service designed to store, manage, and distribute Docker images. It acts as a central library where images can be uploaded (pushed) and downloaded (pulled)
```
docker pull <image_name: used to pull images from docker registry
docker push <image_name>: used to push the image on registry
```

**Docker Images**
Docker images are the package of the software available to use. It contains full OS, libraries and software that need to run the application:
We can say that image= Software package
```
docker images: list the images
docker build: used to build the image from dockerfile
```
**Docker Cotainers**
A Docker container is a lightweight, standalone, and executable software package that bundles an application and all its dependencies, ensuring it runs consistently and reliably across different computing environments. It is a running instance of a Docker image. 
Docker conatiner=Blueprint of Docker Images

## **Task 2**
* Install and Verify the Docker 

<img width="747" height="103" alt="docker_version" src="https://github.com/user-attachments/assets/2c94f3f6-d86d-41f4-93dd-92bdc30d0c16" />
* Run the hello-world container
  
<img width="1003" height="722" alt="docker _hello" src="https://github.com/user-attachments/assets/77b9bbc2-3111-45ef-b9cc-7ce3adecae6f" />

  
