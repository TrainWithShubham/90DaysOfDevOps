# Day 32 – Docker Volumes & Networking

## Goal
Solve two real problems in Docker:
1. **Data persistence** — containers are ephemeral, so data is lost when removed.
2. **Container communication** — enable containers to communicate via networks.

---

## Task 1: The Problem – Data Loss without Volumes

**Steps Taken:**
1. Ran a MySQL container:
```bash
docker run -dit --name mysql-test -e MYSQL_ROOT_PASSWORD=root mysql:latest
```
2. Created a database and added a table with a few rows.
3. Stopped and removed the container:
```bash
docker stop mysql-test
docker rm mysql-test
```
4. Ran a new container and checked the data.

**Observation:**  
All data was lost. The database was empty.

**Reason:**  
Containers are ephemeral. When deleted, their internal filesystem (including the database files) is also deleted.

---

## Task 2: Named Volumes

**Steps Taken:**
1. Created a named volume:
```bash
docker volume create mysql-data
```
2. Ran MySQL with the named volume attached:
```bash
docker run -dit --name mysql-persistent -v mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root mysql:latest
```
3. Added some data, stopped and removed the container:
```bash
docker stop mysql-persistent
docker rm mysql-persistent
```
4. Ran a new container with the **same volume**:
```bash
docker run -dit --name mysql-new -v mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root mysql:latest
```

**Observation:**  
Data was still there! The table and rows were intact.

**Verification:**
```bash
docker volume ls
docker volume inspect mysql-data
```

**Conclusion:**  
Named volumes persist data independently of containers. This is the recommended way to store important data.

---

## Task 3: Bind Mounts

**Steps Taken:**
1. Created a folder on the host:
```bash
mkdir ~/nginx-html
echo "Hello from Docker" > ~/nginx-html/index.html
```
2. Ran an Nginx container with a bind mount:
```bash
docker run -dit --name nginx-test -p 8080:80 -v ~/nginx-html:/usr/share/nginx/html nginx
```
3. Opened `http://localhost:8080` → saw "Hello from Docker".
4. Edited `index.html` on the host → refreshed browser → changes were reflected instantly.

**Observation:**  
Changes on the host are immediately visible inside the container.

**Difference between named volume and bind mount:**  
- **Named volumes:** Managed by Docker, stored in Docker’s path, persist data independently of host.
- **Bind mounts:** Directly map a host directory to the container. Immediate reflection, but depend on host path.

---

## Task 4: Docker Networking Basics

**Steps Taken:**
1. Listed networks:
```bash
docker network ls
```
2. Inspected default `bridge` network:
```bash
docker network inspect bridge
```
3. Ran two containers on default bridge:
```bash
docker run -dit --name container1 nginx
docker run -dit --name container2 nginx
```
4. Tested connectivity:
```bash
docker exec -it container1 ping container2
```

**Observation:**  
- Name-based ping **did not work** on default bridge.
- Ping by **IP address** worked (e.g., `ping 172.17.0.5`).

---

## Task 5: Custom Networks

**Steps Taken:**
1. Created a custom network:
```bash
docker network create my-app-net
```
2. Ran two containers on `my-app-net`:
```bash
docker run -dit --name container3 --network my-app-net nginx
docker run -dit --name container4 --network my-app-net nginx
```
3. Tested connectivity:
```bash
docker exec -it container3 ping container4
```

**Observation:**  
Name-based ping **worked** on custom network.

**Reason:**  
Custom bridge networks provide an internal DNS, which resolves container names to IPs. Default bridge does not.

---

## Task 6: Putting It Together

**Steps Taken:**
1. Created a custom network:
```bash
docker network create my-app-net
```
2. Ran MySQL container on network with volume:
```bash
docker run -dit --name mysql-app -v mysql-data:/var/lib/mysql --network my-app-net -e MYSQL_ROOT_PASSWORD=root mysql
```
3. Ran Nginx app container on the same network:
```bash
docker run -dit --name app-container --network my-app-net nginx
```
4. Verified connectivity from app container to database:
```bash
docker exec -it app-container ping mysql-app
```

**Observation:**  
Ping succeeded, showing that the app container can communicate with the database by name.

---

## Notes / Key Learnings

- **Containers are ephemeral:** Deleting them removes internal filesystem.
- **Named volumes** solve persistence problems.
- **Bind mounts** are useful for live-editing files from the host.
- **Default bridge network:** containers can communicate by IP, not by name.
- **Custom bridge network:** enables container-to-container DNS, allowing name-based communication.

---

## Screenshots

*(Add screenshots of ping results, volume inspect, browser showing Nginx page, etc.)*

