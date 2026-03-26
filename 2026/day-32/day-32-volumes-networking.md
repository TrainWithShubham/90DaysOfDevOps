# Day 32 – Docker Volumes & Networking
---

## Task 1: The Problem (Ephemeral Containers)

### Steps (Postgres example)

```bash
docker run --name pg-test -e POSTGRES_PASSWORD=pass -d postgres

# Exec into container
docker exec -it pg-test psql -U postgres

# Inside psql:
CREATE TABLE demo(id INT, name TEXT);
INSERT INTO demo VALUES (1, 'Alice');
SELECT * FROM demo;
\q

# Stop & remove
docker stop pg-test
docker rm pg-test

# Run a new container
docker run --name pg-test2 -e POSTGRES_PASSWORD=pass -d postgres
docker exec -it pg-test2 psql -U postgres
```

### Result

Your table/data is **gone**.

### Why?

Containers use a **writable layer** (union filesystem). When the container is removed:

* That layer is destroyed
* Any data not persisted externally is lost

This is fundamental: **containers are stateless by default**.

---

## Task 2: Named Volumes (Persistent Storage)

### Create volume

```bash
docker volume create pg-data
```

### Run container with volume

```bash
docker run --name pg-vol -e POSTGRES_PASSWORD=pass -v pg-data:/var/lib/postgresql/data -d postgres
```

### Insert data

Same SQL as before.

### Remove container

```bash
docker stop pg-vol
docker rm pg-vol
```

### Recreate container with SAME volume

```bash
docker run --name pg-vol2 -e POSTGRES_PASSWORD=pass -v pg-data:/var/lib/postgresql/data -d postgres
```

### Verify

```bash
docker exec -it pg-vol2 psql -U postgres
SELECT * FROM demo;
```

### Result

Data is still there.

### Inspect volume

```bash
docker volume ls
docker volume inspect pg-data
```

### Why?

Named volumes:

* Live outside container lifecycle
* Managed by Docker (`/var/lib/docker/volumes/...`)
* Decoupled from container deletion

---

## Task 3: Bind Mounts

### Create local folder

```bash
mkdir mysite
echo "<h1>Hello from host</h1>" > mysite/index.html
```

### Run Nginx with bind mount

```bash
docker run --name nginx-test -p 8080:80 -v $(pwd)/mysite:/usr/share/nginx/html -d nginx
```

### Open browser

```
http://localhost:8080
```

### Edit file locally

```bash
echo "<h1>Updated content</h1>" > mysite/index.html
```

Refresh browser → updates immediately

---

### Difference: Named Volume vs Bind Mount

| Feature             | Named Volume               | Bind Mount                  |
| ------------------- | -------------------------- | --------------------------- |
| Managed by Docker   | Yes                        | No                          |
| Location            | Docker storage             | Host filesystem             |
| Portability         | High                       | Low                         |
| Direct host editing | Not typical                | Yes                         |
| Performance         | Optimized                  | Depends on OS               |
| Use case            | Databases, persistent data | Dev workflows, live editing |

**Key Insight:**

* Named volumes = **data persistence abstraction**
* Bind mounts = **direct host ↔ container coupling**

---

## Task 4: Docker Networking Basics

### List networks
```bash
docker network ls
```
### Inspect bridge

```bash
docker network inspect bridge
```
### Run containers
### Install ping tool

### Test by name
- Fails

### Test by IP
- Works

---

### Why?

Default bridge:

* No automatic DNS resolution
* Containers must use IP unless linked (legacy)

---

## Task 5: Custom Networks

### Create network

```bash
docker network create my-app-net
```

### Run containers

### Install ping

### Test
- Works by **name**

---

### Why Custom Networks Enable Name Resolution

Custom bridge networks include:

* Embedded DNS server (Docker daemon)
* Automatic service discovery via container names
* Scoped isolation

Default bridge lacks this DNS feature.

---

## Task 6: Putting It All Together

### Create network

```bash
docker network create my-app-net
```

### Create volume

```bash
docker volume create db-data
```

### Run database

```bash
docker run -d --name mydb --network my-app-net -e POSTGRES_PASSWORD=pass -v db-data:/var/lib/postgresql/data postgres
```

### Run app container (example: busybox)

```bash
docker run -it --rm --network my-app-net nginx
```

### Inside container

```sh
ping mydb
```

Or test port:

```sh
nc -zv mydb 5432
```

---

### Result

- App container can reach DB using:

```
hostname = mydb
```

---

# **Key Takeaways**

* Containers are **ephemeral** unless storage is externalized
* **Volumes solve persistence**
* **Bind mounts solve development workflows**
* Default bridge = **IP-based communication**
* Custom networks = **DNS + service discovery**
* Real-world apps combine:

  * volumes (state)
  * networks (connectivity)
  * containers (compute)

---
[text](images) ![text](images/day-32-task-1-postgres-dbs-delete.png) ![text](images/day-32-task-1-postgres-dbs.png) ![text](images/day-32-task-2-db.png) ![text](images/day-32-task-2-persistent-volume-data.png) ![text](images/day-32-task-2-persistent-volume-data2.png) ![text](images/day-32-task-2-pgsql-backup.png) ![text](images/day-32-task-2.png) ![text](images/day32-task-1-postgres-db-drop.png) ![text](images/day32-task-1-postgres-q.png) ![text](images/day32-task-1-postgres.png) ![text](images/day32-task-1-psql.png) ![text](images/day32-task-1.png) ![text](images/day32-task-2-backu.png) ![text](images/day32-task-3-after-changes-refresh.png) ![text](images/day32-task-3-nginx.png) ![text](images/day32-task-3-webpage-success.png) ![text](images/day32-task-3.png) ![text](images/day32-task-4-1st-container-ping.png) ![text](images/day32-task-4-2nd-container-exec.png) ![text](images/day32-task-4-2nd-container-ping.png) ![text](images/day32-task-4-network-exec.png) ![text](images/day32-task-4-network-inspect.png) ![text](images/day32-task-4-network.png) ![text](images/day32-task-4.png) ![text](images/day32-task-5-both-inspect.png) ![text](images/day32-task-5-container-ping-via-custom-network.png) ![text](images/day32-task-5-inspect-net.png) ![text](images/day32-task-5.png) ![text](images/day32-task-6-inspect.png) ![text](images/day32-task-6-ping-pg-database.png) ![text](images/day32-task-6.png) [text](day-32-volumes-networking.md) [text](README.md)