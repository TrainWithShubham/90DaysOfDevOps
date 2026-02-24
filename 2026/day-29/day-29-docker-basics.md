### What is a container and why do we need them?

Container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably across different environments. We need them for below reasons:
- It can be run on any environment, being portable
- Lightweight as they share host machine's OS allowing faster execution
- Run application in isolated environment preventing dependency conflicts

### Containers vs Virtual Machines - what's the real difference?

Containers virtualize the operating system instead of hardware. Containers are more portable and efficient. Whereas virtual machines have their own guest OS which require more resources and have slower boot time.

### What is Docker architecture?

Docker used client/server architecture.

Core components of Docker:

- Docker daemon: Also called dockerd, listens for Docker API requests and manages Docker objects such as images, containers, networks and volumes
- Docker client: This is the primary way users interact with Docker via a command line interface(CLI). When you run commands like docker pull or docker run, it uses REST API to send these commands to Docker daemon
- Docker host: This is where docker daemon runs providing environment and resources to run containers
- Docker registry: These are services that store and distribute docker images. Docker hub is the public registry maintained by Docker while there are many private registries as well
- Docker images: Images are read-only template which contain a set of instructions to create a docker container
- Docker containers: A container is a runnable instance of an image

## What happens when you run a container in detached mode?

The container runs but in the background