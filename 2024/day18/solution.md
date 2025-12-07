# Day 18 Answers:  Docker for DevOps Engineers

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

## Tasks with Answers

## Task 1

Learn how to use the docker-compose.yml file to set up the environment, configure the services and links between different containers, and also to use environment variables in the docker-compose.yml file.

[Sample docker-compose.yml file](https://github.com/LondheShubham153/90DaysOfDevOps/blob/master/2023/day18/docker-compose.yaml)

   **Answer**

   ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day18/image/1_docker_compose_yml_file.png)

## Task 2
   
   - **1. Pull a pre-existing Docker image from a public repository (e.g. Docker Hub) and run it on your local machine. Run the container as a non-root user (Hint: Use the `usermod` command to give the user permission to Docker). Make sure you reboot the instance after giving permission to the user.**
      - Pull the Docker image:

      **Answer**

      ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day18/image/2_Pull_the_Docker_image.png)

      - Add the current user to the Docker group:

      **Answer**

      ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day18/image/3_Add_the_current_user_to_the_Docker_group.png)

      - Reboot the machine to apply the changes:

      **Answer**

      ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day18/image/4_Reboot_the_machine_to_apply_the_changes.png)

      - Run the Docker container:

      **Answer**

      ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day18/image/5_Run_the_Docker_container.png)      

   - **2. Inspect the container's running processes and exposed ports using the `docker inspect` command.**
      - Inspect the container:

      **Answer**

      ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day18/image/6_Inspect_the_container.png)      

   - **3. Use the `docker logs` command to view the container's log output.**
      - View the logs:

      **Answer**

      ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day18/image/7_View_the_logs.png)

   - **4. Use the `docker stop` and `docker start` commands to stop and start the container.**
      - Stop the container:

      **Answer**

      ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day18/image/8_Stop_the_container.png)

      - Start the container:

      **Answer**

      ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day18/image/9_Start_the_container.png)

   - **5. Use the `docker rm` command to remove the container when you're done.**
      - Remove the container:

      **Answer**

      ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day18/image/10_Remove_the_container.png)      

## How to Run Docker Commands Without Sudo?

- Make sure Docker is installed and the system is updated (This was already completed as part of previous tasks):
   - `sudo usermod -a -G docker $USER`

      **Answer**

      ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day18/image/3_Add_the_current_user_to_the_Docker_group.png)      

   - Reboot the machine.

      **Answer**

      ![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day18/image/4_Reboot_the_machine_to_apply_the_changes.png)         

For reference, you can watch this [video](https://youtu.be/Tevxhn6Odc8).

[LinkedIn](https://www.linkedin.com/in/bhavin-savaliya/)
