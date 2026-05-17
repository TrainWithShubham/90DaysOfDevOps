# Day 33 – Docker Compose: Multi-Container Basics

## Challenge Tasks

### Task 1: Install & Verify
1. Check if Docker Compose is available on your machine
2. Verify the version

    ![image](images/compose-version.png)

---

### Task 2: Your First Compose File
1. Create a folder `compose-basics`
2. Write a `docker-compose.yml` that runs a single **Nginx** container with port mapping
3. Start it with `docker compose up`
4. Access it in your browser
5. Stop it with `docker compose down`

    [Dockerfile](compose-basics/Dockerfile)

    [Compose file](compose-basics/docker-compose.yml)
    
    ![image](images/task2.png)

    ![image](images/task2.5.png)

---

### Task 3: Two-Container Setup
Write a `docker-compose.yml` that runs:
- A **WordPress** container
- A **MySQL** container

They should:
- Be on the same network (Compose does this automatically)
- MySQL should have a named volume for data persistence
- WordPress should connect to MySQL using the service name

Start it, access WordPress in your browser, and set it up.

![image](images/wrd1.png)


![image](images/wrd2install.png)


![image](images/wrdbefore.png)


**Verify:** Stop and restart with `docker compose down` and `docker compose up` — is your WordPress data still there?

- Yes,wordpress data is there.


![image](images/down.png)


![image](images/wrdafter.png)



[Compose file](wordpress-mysql/docker-compose.yml)
    

---

### Task 4: Compose Commands
Practice and document these:
1. Start services in **detached mode**

    `docker compose up -d`
    ![image](images/task4.1.png)

2. View running services

    `docker compose ps`
    ![image](images/task4.2.png)

3. View **logs** of all services

    `docker compose logs db` && `docker compose logs wordpress`
    ![image](images/task4.3.png)

4. View logs of a **specific** service

    ![image](images/task4.4.png)

5. **Stop** services without removing

    `docker compose stop`
    ![image](images/task4.5.png)

6. **Remove** everything (containers, networks)

    `docker compose down`
    ![image](images/task4.6.png)

7. **Rebuild** images if you make a change

    `docker compose up --build.`

---

### Task 5: Environment Variables
1. Add environment variables directly in your `docker-compose.yml`
2. Create a `.env` file and reference variables from it in your compose file
3. Verify the variables are being picked up

    ![image](images/task5.png)

    [Compose file](worpress-mysql-env/docker-compose.yml)

    [Env](worpress-mysql-env/.env)
        
