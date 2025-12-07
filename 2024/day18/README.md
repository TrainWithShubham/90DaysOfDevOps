# Day 18 Task: Docker for DevOps Engineers

Till now you have created a Dockerfile and pushed it to the repository. Let's move forward and dig deeper into other Docker concepts. Today, let's study Docker Compose! 😃

## Docker Compose

- Docker Compose is a tool that was developed to help define and share multi-container applications.
- With Compose, we can create a YAML file to define the services and, with a single command, spin everything up or tear it all down.
- Learn more about Docker Compose [here](https://tecadmin.net/tutorial/docker/docker-compose/).

## What is YAML?

- YAML is a data serialization language that is often used for writing configuration files. Depending on whom you ask, YAML stands for "Yet Another Markup Language" or "YAML Ain’t Markup Language" (a recursive acronym), which emphasizes that YAML is for data, not documents.
- YAML is a popular programming language because it is human-readable and easy to understand.
- YAML files use a .yml or .yaml extension.
- Read more about it [here](https://www.redhat.com/en/topics/automation/what-is-yaml).

## Task 1

Learn how to use the docker-compose.yml file to set up the environment, configure the services and links between different containers, and also to use environment variables in the docker-compose.yml file.

[Sample docker-compose.yml file](https://github.com/LondheShubham153/90DaysOfDevOps/blob/master/2023/day18/docker-compose.yaml)

## Task 2

- Pull a pre-existing Docker image from a public repository (e.g. Docker Hub) and run it on your local machine. Run the container as a non-root user (Hint: Use the `usermod` command to give the user permission to Docker). Make sure you reboot the instance after giving permission to the user.
- Inspect the container's running processes and exposed ports using the `docker inspect` command.
- Use the `docker logs` command to view the container's log output.
- Use the `docker stop` and `docker start` commands to stop and start the container.
- Use the `docker rm` command to remove the container when you're done.

## How to Run Docker Commands Without Sudo?

- Make sure Docker is installed and the system is updated (This was already completed as part of previous tasks):
- `sudo usermod -a -G docker $USER`
- Reboot the machine.

For reference, you can watch this [video](https://youtu.be/Tevxhn6Odc8).

You can post on LinkedIn and let us know what you have learned from this task by using #90DaysOfDevOps Challenge. Happy Learning! :)

[← Previous Day](../day17/README.md) | [Next Day →](../day19/README.md)
