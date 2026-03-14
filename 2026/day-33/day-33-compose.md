---
# Docker Compose: Multi Container Basics
---

---
## Task 1: Install & Verify
---

- Check if Docker Compose is available on your machine

```bash
docker-compose --version
```

- Verify the version: 

![alt text](image-100.png)

---
Task 2: Your First Compose File
---

![alt text](image-101.png)

![alt text](image-102.png)

![alt text](image-103.png)

![alt text](image-104.png)

![alt text](image-105.png)

After performing above mentioned steps in this task i came to know that **docker-compose up** creates the container from docker-compose.yml file and also hosts it on the mentioned port in yml, we do not require explicit mapping in the command as we do it during creating / running a container from an image, and **docker-compose down** stops and removes the comtainer in a single command.

---
## Task 3: Two-Container Setup
---

![alt text](image-106.png)

![alt text](image-107.png)

![alt text](image-108.png)

![alt text](image-109.png)

![alt text](image-110.png)

![alt text](image-111.png)

![alt text](image-112.png)

![alt text](image-113.png)

![alt text](image-114.png)

Wordpress data still persisted as after my first setup i did not require to setup the wordpress again after i executed docker-compose down and docker-compose up -d, i just had to login into the wordpress using the credentials which i had setup for the first time, this means that the data of the wordpress is stored in the mysql database and it is being persisted

If we use -v while executing docker-compose, it deletes/removes the volume as well due to which data also gets deleted hence you need to setup the wordpress again

![alt text](image-115.png)

![alt text](image-116.png)

---

## Task 4: Compose Commands

1. Start services in detached mode

```bash
docker-compose up -d
```

![alt text](image-117.png)

2. View running services

```bash
docker-compose ps
```

![alt text](image-118.png)

3. View logs of all services

```bash
docker-compose logs -f
```

![alt text](image-119.png)

4. View logs of a specific service

```bash
docker-compose logs $service_name
```

![alt text](image-120.png)

5. Stop services without removing

```bash
docker-compose stop
```

![alt text](image-121.png)

6. Remove everything (containers, networks)

```bash
docker-compose down
docker-compose ps
docker volume ls
```

![alt text](image-122.png)

![alt text](image-123.png)

7. Rebuild images if you make a change

```bash
docker-compose up -d --build
```

![alt text](image-124.png)

---
## Task 5: Environment Variables

![alt text](image-125.png)

![alt text](image-126.png)

![alt text](image-127.png)

![alt text](image-128.png)
