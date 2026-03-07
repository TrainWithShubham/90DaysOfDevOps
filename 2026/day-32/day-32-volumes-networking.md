# Day 32 – Docker Volumes & Networking

## Challenge Tasks

### Task 1: The Problem

In this task, we will understand the **data persistence problem in Docker containers**.

Containers are **ephemeral**, which means when a container is removed, the data stored inside it is also deleted.

---

### 1. Run a Postgres Container

First, run a Postgres container.

Command:

docker run -d \
--name postgres-test \
-e POSTGRES_PASSWORD=1234 \
-p 5432:5432 \
postgres

Explanation:

docker run -d  
- Runs the container in detached mode.

--name postgres-test  
- Assigns a custom name to the container.

-e POSTGRES_PASSWORD=1234  
- Sets the password for the Postgres database.

-p 5432:5432  
- Maps the container port to the host port.

---

### 2. Create Data Inside the Container

Enter the container.

Command:

docker exec -it postgres-test psql -U postgres

Create a table.

Command:

CREATE TABLE students (
id INT,
name VARCHAR(50)
);

Insert data.

Command:

INSERT INTO students VALUES (1,'Om');
INSERT INTO students VALUES (2,'Rahul');

Check the data.

Command:

SELECT * FROM students;

Example Output:

id | name  
----|------  
1 | Om  
2 | Rahul  

---

### 3. Stop the Container

Stop the running container.

Command:

docker stop postgres-test

---

### 4. Remove the Container

Now remove the container completely.

Command:

docker rm postgres-test

---

### 5. Run a New Container

Run the same Postgres container again.

Command:

docker run -d \
--name postgres-test \
-e POSTGRES_PASSWORD=1234 \
-p 5432:5432 \
postgres

Enter the container again.

Command:

docker exec -it postgres-test psql -U postgres

Check tables.

Command:

\dt

---

### What Happened?

The **students table and inserted data are gone**.

The database is empty because the **previous container was deleted**.

---

### Why Did This Happen?

Docker stores data **inside the container filesystem**.

When the container is removed:

- The container filesystem is deleted
- All stored data is lost

This happened because **no Docker volume was used**.

---

### Conclusion

This experiment shows why **Docker volumes are important**.

Without volumes, databases running inside containers will lose their data when the container is removed.

---


### Task 2: Named Volumes

In this task, we will solve the **data persistence problem** using **Docker Named Volumes**.

Named volumes store data **outside the container**, so the data remains safe even if the container is removed.

---

### 1. Create a Named Volume

First, create a Docker volume.

Command:

docker volume create pgdata

Explanation:

docker volume create  
- Creates a new Docker volume.

pgdata  
- Name of the volume.

Verify the volume.

Command:

docker volume ls

This command lists all Docker volumes on the system.

---

### 2. Run a Database Container with the Volume

Run a Postgres container and attach the volume.

Command:

docker run -d \
--name postgres-volume \
-e POSTGRES_PASSWORD=1234 \
-v pgdata:/var/lib/postgresql/data \
-p 5432:5432 \
postgres

Explanation:

-v pgdata:/var/lib/postgresql/data  
- Attaches the named volume **pgdata** to the Postgres data directory inside the container.

This ensures that database files are stored in the volume instead of inside the container.

---

### 3. Add Data to the Database

Enter the container.

Command:

docker exec -it postgres-volume psql -U postgres

Create a table.

Command:

CREATE TABLE students (
id INT,
name VARCHAR(50)
);

Insert some data.

Command:

INSERT INTO students VALUES (1,'Om');
INSERT INTO students VALUES (2,'Rahul');

Check the data.

Command:

SELECT * FROM students;

Example Output:

id | name  
----|------  
1 | Om  
2 | Rahul  

---

### 4. Stop and Remove the Container

Stop the container.

Command:

docker stop postgres-volume

Remove the container.

Command:

docker rm postgres-volume

Note:  
The container is removed, but the **volume still exists**.

---

### 5. Run a New Container with the Same Volume

Now run a new Postgres container using the **same volume**.

Command:

docker run -d \
--name postgres-volume2 \
-e POSTGRES_PASSWORD=1234 \
-v pgdata:/var/lib/postgresql/data \
-p 5432:5432 \
postgres

Enter the container.

Command:

docker exec -it postgres-volume2 psql -U postgres

Check the tables.

Command:

\dt

Check the data.

Command:

SELECT * FROM students;

---

### What Happened?

The **students table and inserted data are still present**.

This happened because the data was stored in the **Docker volume**, not inside the container.

---

### Verify Volumes

List all volumes.

Command:

docker volume ls

Inspect the volume.

Command:

docker volume inspect pgdata

This command shows details like:

- Volume name
- Driver
- Mount location on the host system

---

### Conclusion

Docker **Named Volumes** allow containers to store data persistently.

Even if the container is removed, the data remains safe because it is stored in the volume.


---


### Task 3: Bind Mounts

In this task, we will learn how **Bind Mounts** work in Docker.

A bind mount directly connects a **folder on the host machine** to a **folder inside the container**.

This means any change on the host will immediately reflect inside the container.

---

### 1. Create a Folder on Your Host Machine

First create a folder and move into it.

Command:

mkdir nginx-bind  
cd nginx-bind  

---

### 2. Create an index.html File

Create a simple HTML file.

Command:

nano index.html

Add the following content:

<html>
<head>
<title>Docker Bind Mount</title>
</head>
<body>
<h1>Hello from Bind Mount</h1>
<p>This page is served using Docker Bind Mount.</p>
</body>
</html>

Save and exit the file.

---

### 3. Run an Nginx Container with Bind Mount

Now run an Nginx container and mount the host folder to the Nginx web directory.

Command:

docker run -d \
--name nginx-bind \
-p 8080:80 \
-v $(pwd):/usr/share/nginx/html \
nginx

Explanation:

docker run -d  
- Runs the container in detached mode.

-p 8080:80  
- Maps container port 80 to host port 8080.

-v $(pwd):/usr/share/nginx/html  
- Mounts the current host directory to the Nginx HTML directory inside the container.

nginx  
- Uses the Nginx image.

---

### 4. Access the Page in Your Browser

Open your browser and visit:

http://localhost:8080

You should see the **HTML page you created**.

---

### 5. Edit the HTML File

Now edit the index.html file on the host.

Command:

nano index.html

Change the text for example:

<h1>Docker Bind Mount Working!</h1>

Save the file.

Now refresh the browser.

You will see the **updated page instantly**, without restarting the container.

---

### Difference Between Named Volume and Bind Mount

Named Volume:

- Managed completely by Docker
- Stored inside Docker’s storage directory
- Good for databases and persistent application data
- Docker manages its lifecycle

Bind Mount:

- Uses a specific folder from the host machine
- Directly linked to host filesystem
- Changes reflect immediately in the container
- Mostly used for development and testing

---

### Conclusion

Bind mounts allow containers to use files directly from the host system.

They are very useful in development because changes made on the host machine instantly appear inside the container.


---


### Task 4: Docker Networking Basics

In this task, we will explore **Docker networking** and understand how containers communicate with each other.

Docker creates a few **default networks**, and the most common one is the **bridge network**.

---

### 1. List All Docker Networks

First, list all networks available on your system.

Command:

docker network ls

Example Output:

NETWORK ID     NAME      DRIVER    SCOPE  
a1b2c3d4e5f6   bridge    bridge    local  
f7g8h9i0j1k2   host      host      local  
l3m4n5o6p7q8   none      null      local  

Explanation:

bridge  
- Default network used by containers.

host  
- Container shares the host network.

none  
- Container has no network access.

---

### 2. Inspect the Default Bridge Network

Inspect the bridge network to see detailed configuration.

Command:

docker network inspect bridge

This command shows:

- Network ID
- Subnet
- Gateway
- Connected containers
- IP address range

---

### 3. Run Two Containers on the Default Bridge

Run two Ubuntu containers.

Command:

docker run -dit --name container1 ubuntu  
docker run -dit --name container2 ubuntu  

Explanation:

- `-d` → detached mode  
- `-i` → interactive  
- `-t` → terminal  

Check running containers:

docker ps

---

### 4. Try to Ping by Container Name

Enter container1.

Command:

docker exec -it container1 bash

Install ping utility.

Command:

apt update  
apt install -y iputils-ping  

Now try to ping container2 using its name.

Command:

ping container2

Result:

This **will NOT work** on the default bridge network.

Reason:

The default bridge network **does not provide automatic DNS resolution for container names**.

---

### 5. Ping Using Container IP Address

First, find the IP address of container2.

Command:

docker inspect container2

Look for the **IPAddress** field.

Example:

172.17.0.3

Now from container1 run:

Command:

ping 172.17.0.3

Result:

The ping **will work successfully**.

---

### Key Learning

On the **default bridge network**:

- Containers **cannot communicate using container names**
- Containers **can communicate using IP addresses**

To enable name-based communication, we usually create a **custom Docker network**.

---

### Conclusion

Docker networking allows containers to communicate with each other.

However, the **default bridge network has limitations**, and using a **custom bridge network** is the recommended approach for container communication.


---

### Task 5: Custom Networks

In this task, we will create a **custom Docker network** and see how containers can communicate using **container names**.

Custom networks provide **automatic DNS resolution**, which allows containers to find each other by name.

---

### 1. Create a Custom Network

Create a new bridge network.

Command:

docker network create my-app-net

Explanation:

docker network create  
- Creates a new Docker network.

my-app-net  
- Name of the custom network.

Verify the network.

Command:

docker network ls

You should see **my-app-net** in the list.

---

### 2. Run Two Containers on the Custom Network

Run the first container.

Command:

docker run -dit --name app1 --network my-app-net ubuntu

Run the second container.

Command:

docker run -dit --name app2 --network my-app-net ubuntu

Check running containers.

Command:

docker ps

---

### 3. Test Communication by Name

Enter the first container.

Command:

docker exec -it app1 bash

Install ping utility.

Command:

apt update  
apt install -y iputils-ping  

Now ping the second container using its **name**.

Command:

ping app2

Result:

The ping **works successfully**.

Example Output:

64 bytes from app2: icmp_seq=1 ttl=64 time=0.08 ms  
64 bytes from app2: icmp_seq=2 ttl=64 time=0.07 ms  

This shows the containers can communicate using **container names**.

---

### 4. Why Custom Networks Allow Name-Based Communication

Custom Docker networks include an **embedded DNS server**.

This DNS automatically maps:

container name → container IP address

So when you run:

ping app2

Docker resolves **app2** to its IP address internally.

---

### Default Bridge vs Custom Bridge

Default Bridge Network:

- No automatic DNS resolution
- Containers cannot communicate using names
- Communication works only using IP addresses

Custom Bridge Network:

- Built-in DNS service
- Containers can communicate using names
- Recommended for multi-container applications

---

### Conclusion

Custom Docker networks allow containers to communicate easily using **container names**.

This makes container communication simpler and is the **recommended networking approach for Docker applications**.


---

### Task 6: Put It Together

In this task, we will combine **Docker Volumes and Networking**.

We will run a **database container with persistent storage** and an **app container** on the same custom network, then verify that the app container can reach the database using the **container name**.

---

### 1. Create a Custom Network

Create a network for the application.

Command:

docker network create app-network

Verify:

docker network ls

---

### 2. Create a Volume for Database Data

Create a volume to store database data persistently.

Command:

docker volume create postgres-data

Explanation:

docker volume create  
- Creates a Docker-managed storage volume.

postgres-data  
- Name of the volume used by the database container.

---

### 3. Run the Database Container

Run a Postgres container attached to the custom network and volume.

Command:

docker run -d \
--name db \
--network app-network \
-e POSTGRES_PASSWORD=1234 \
-v postgres-data:/var/lib/postgresql \
-p 5434:5432 \
postgres

Explanation:

--name db  
- Container name used by other containers to connect.

--network app-network  
- Connects the container to the custom network.

-v postgres-data:/var/lib/postgresql  
- Stores database files in the Docker volume.

---

### 4. Run an App Container on the Same Network

Run another container that represents an application.

Command:

docker run -dit \
--name app \
--network app-network \
ubuntu

Explanation:

This container simulates an application that will communicate with the database.

---

### 5. Test Connection to Database by Container Name

Enter the app container.

Command:

docker exec -it app bash

Install ping tool.

Command:

apt update  
apt install -y iputils-ping  

Now ping the database container using its name.

Command:

ping db

Example Output:

64 bytes from db: icmp_seq=1 ttl=64 time=0.08 ms  
64 bytes from db: icmp_seq=2 ttl=64 time=0.07 ms  

---

### Result

The **app container successfully reaches the database container using its name**.

This works because both containers are connected to the **same custom Docker network**, which provides **automatic DNS resolution**.

---

### Key Learning

- Custom networks allow containers to communicate by **name**
- Volumes ensure **database data persists**
- Networking + volumes together form the base of **real multi-container applications**

---

### Conclusion

In this task, we combined:

- **Docker Volumes** for persistent database storage
- **Docker Networking** for container-to-container communication

This setup is commonly used in real-world applications such as **web app + database architectures**.