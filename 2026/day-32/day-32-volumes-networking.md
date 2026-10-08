# Day 32 – Docker Volumes & Networking Concepts (/human)

In this lab, I learned two very important Docker concepts: persistent storage and container networking.

By default, containers are temporary. If I create a database container and store data inside it, the data remains only inside the container layer. Once the container is removed, all the data is also deleted. This is why Docker volumes are important.

First, I created a named Docker volume. A volume is like permanent storage managed by Docker. Even if the container is deleted, the volume still exists and keeps the data safe. I attached the volume to the MySQL container using:

```bash
-v final1:/var/lib/mysql
```

Here:

- `final1` is the Docker volume name
- `/var/lib/mysql` is the MySQL data directory inside the container

This means MySQL stores all database files inside the Docker volume instead of temporary container storage.

I also learned bind mounts. In bind mounts, a folder from my local machine is directly connected to a folder inside the container. For example, I created an `index.html` file on my Windows machine and mounted it inside an Nginx container. When I changed the HTML file locally and refreshed the browser, the changes appeared immediately. This is called live file syncing and is mostly used during development.

Then I learned Docker networking.

By default, containers run on the default bridge network. Containers can communicate using IP addresses, but name-based communication is not reliable there.

So I created a custom Docker bridge network:

```bash
docker network create final1-net
```

Then I started two containers on the same custom network:

```bash
docker run -dit --name app-client --network final1-net ubuntu bash
```

and MySQL container:

```bash
docker run -d --name final1 --network final1-net ...
```

Because both containers were connected to the same custom network, Docker automatically provided internal DNS resolution. This allowed containers to communicate using container names instead of IP addresses.

From inside the app container, I tested connectivity by pinging the MySQL container:

```bash
ping final1
```

This verified that both containers could communicate over the Docker network.

I understood that in real production environments:

- frontend containers talk to backend containers
- backend containers talk to database containers
- communication usually happens using container names, not IP addresses

I also learned:

- Volumes provide persistent storage
- Bind mounts provide live file synchronization
- Custom Docker networks provide container-to-container communication
- Docker automatically manages internal DNS for custom networks

This lab helped me understand the real foundation of modern containerized applications and DevOps environments.
