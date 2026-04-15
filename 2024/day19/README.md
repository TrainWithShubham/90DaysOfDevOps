# Day 19 Task: Docker for DevOps Engineers

**So far, you've learned how to create a docker-compose.yml file and push it to the repository. Let's move forward and explore more Docker Compose concepts. Today, let's study Docker Volume and Docker Network!** 😃

## Docker Volume

Docker allows you to create volumes, which are like separate storage areas that can be accessed by containers. They enable you to store data, like a database, outside the container, so it doesn't get deleted when the container is removed. You can also mount the same volume to multiple containers, allowing them to share data. For more details, check out this [reference](https://docs.docker.com/storage/volumes/).

## Docker Network

Docker allows you to create virtual networks, where you can connect multiple containers together. This way, the containers can communicate with each other and with the host machine. Each container has its own storage space, but if we want to share storage between containers, we need to use volumes. For more details, check out this [reference](https://docs.docker.com/network/).

## Task 1

Create a multi-container docker-compose file that will bring up and bring down containers in a single shot (e.g., create application and database containers).

### Hints:

- Use the `docker-compose up` command with the `-d` flag to start a multi-container application in detached mode.
- Use the `docker-compose scale` command to increase or decrease the number of replicas for a specific service. You can also add [`replicas`](https://stackoverflow.com/questions/63408708/how-to-scale-from-within-docker-compose-file) in the deployment file for auto-scaling.
- Use the `docker-compose ps` command to view the status of all containers, and `docker-compose logs` to view the logs of a specific service.
- Use the `docker-compose down` command to stop and remove all containers, networks, and volumes associated with the application.

## Task 2

- Learn how to use Docker Volumes and Named Volumes to share files and directories between multiple containers.
- Create two or more containers that read and write data to the same volume using the `docker run --mount` command.
- Verify that the data is the same in all containers by using the `docker exec` command to run commands inside each container.
- Use the `docker volume ls` command to list all volumes and the `docker volume rm` command to remove the volume when you're done.

## Project Opportunity

You can use this task as a project to add to your resume.

You can post on LinkedIn and let us know what you have learned from this task by using #90DaysOfDevOps Challenge. Happy Learning! 🙂

[← Previous Day](../day18/README.md) | [Next Day →](../day20/README.md)
