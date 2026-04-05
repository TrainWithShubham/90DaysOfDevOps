# Day 32 – Docker Volumes & Networking
## Task 1

### Run a MySQL container (no volume)

`docker run -d --name mysql-test -e MYSQL_ROOT_PASSWORD=root mysql:latest`

### Check that it’s running.

`docker ps`

### Enter the container

>`docker exec -it mysql-test mysql -u root -p`
           OR
>`docker exec -it mysql-test bash`
>`mysql -u root -p`

### Now create data

`CREATE DATABASE imp_data;`

`USE imp_data;`

### Add some data

```
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO users (name) VALUES ('Fahad');
INSERT INTO users (name) VALUES ('Docker');

SELECT * FROM users;
```

### Exit MySQL 
`exit`

### Now stop the container and remove the container

`docker stop 901acdb9de6b && docker rm 901acdb9de6b`

### Run a brand new container with the same volume

`docker run -d --name mysql-test -e MYSQL_ROOT_PASSWORD=root mysql:latest`

### Enter again: MySQL conatiner

`docker exec -it mysql-test mysql -u root -p`

### Now check for your database.

`SHOW DATABASES;`

My data is gone.
Because the container filesystem was deleted I removed it.

---

## Task 2 – Named Volumes
### Step 1: Create Named Volume

`docker volume create imp_data`

Verify
`docker volume ls`

### Step 2: Run Docker with Volume

`docker run -d --name mysql-test -v vol-1:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root mysql:latest`

### Step 3: Enter mysql conatiner and Add Data

`docker exec -it mysql-test mysql -u root -p`

`creare database imp_data;`

`show databases;`

### Step 4: Remove Container

`docker stop 901acdb9de6b && docker rm 901acdb9de6b`

### Remove image also

`docker rmi 901acdb9de6b`

### Step 5: Run New Container Using Same Volume

`docker run -d --name mysql-test -v vol-1:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root mysql:latest`

### Now check for your database.

`docker exec -it mysql-test mysql -u root -p`

`show databases;`

**The named volume stores data outside the container lifecycle.**

**Even if the container is deleted, the volume remains.**

---

## Task 3 – Bind Mounts
### Step 1: Create Folder on Host
`touch index.html`

Add content:

<h1>Hello from Host Machine 🚀</h1>

### Step 2: Run Nginx with Bind Mount
`docker run -d -p 81:80 -v /home/ubuntu/day-32:/usr/share/nginx/html --name nginx-server nginx:latest`

**Edit Inbound Rule on AWS**

### Step 3: Edit index.html on Host

Add content:

<h1>Updated from Host 🔥</h1>


**Refresh browser — changes appear instantly.**

### Named Volume vs Bind Mount
| Named Volume | Bind Volume |
| :--- | :--- |
| Managed by Docker | Managed by me |
| Stored in Docker’s internal directory | Linked to specific host folder |
| Better for databases | Better for development |

Docker stores the data in its own managed space, typically under:

/var/lib/docker/volumes/

You rarely touch those files directly.

---

**Bind mounts** are better for development or when you want direct access to files on the host machine.

Example:

volumes:
  - ./index.html:/usr/share/nginx/html/index.html

Now when you edit index.html on your computer, the container instantly serves the updated file. Great for coding, testing, or logs you want to inspect.

---

## Task 4: Docker Networking Basics
### List all Docker networks on your machine
`docker network ls`

### Inspect Bridge Network
`docker network inspect bridge`

### Run Two Containers on Default Bridge
`docker run -d -it --name con-1 ubuntu`

`docker run -d -it --name con-2 ubuntu`

### Install ping
`docker exec -it container1 apt update`

`docker exec -it container1 apt install -y iputils-ping`

>`Or we can enter container-1 and install ping`

### Test 1: Ping by Name

`docker exec -it container1 ping container2`

>`Or we can enter container-1 and PING conatiner-2`

**❌ Fails**

### Test 2: Ping by IP

`docker exec -it container-1 ping 172.17.0.5`

**✅ Works**

---

## Task 5 – Custom Network
### Create Custom Bridge

`docker network create my-app-net`

### Run Containers on Custom Network

`docker run -d -it --name con-1 --network my-app-net ubuntu:latest`

`docker run -d -it --name con-2 --network my-app-net ubuntu:latest`

### Install ping and test

`docker exec -it con-1 ping con-2`

**✅ Works**

**Why Does Custom Network Allow Name Communication?**

Custom bridge networks include an embedded DNS server.

Docker automatically resolves container names to IP addresses inside custom networks.

Default bridge does NOT provide automatic DNS resolution.

---

## Task 6 – Putting It All Together 

### Step 1 — Create a Custom Network
`docker network create my-app-net`

### Step 2 — Create a Named Volume for MySQL
`docker volume create mysql-data`

### Step 3 — Run MySQL on That Network with the Volume
`docker run -d -e MYSQL_ROOT_PASSWORD=root -v /home/ubuntu/day-32/data:/var/lib/mysql --network my-aap-net mysql:latest`

### Now install MySQL client inside it:
`docker exec -it my-app bash`

**Inside the container:**

`apt update`

`apt install -y mysql-client`

### Step 5 — Connect Using Container Name
`mysql -h my-mysql -u root -p`

**That works because custom bridge networks include an embedded DNS server. Docker automatically resolves container names to IP addresses inside that network.**

**This does NOT work on the default bridge.**