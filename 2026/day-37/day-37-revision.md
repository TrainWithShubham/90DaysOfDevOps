# Day 37 – Docker Revision

## Self-Assessment Checklist

| Topic | Status |
|---|---|
| Run a container from Docker Hub (interactive + detached) | ✅ Can do |
| List, stop, remove containers and images | ✅ Can do |
| Explain image layers and how caching works | 🟡 Shaky |
| Write a Dockerfile from scratch | ✅ Can do |
| Explain CMD vs ENTRYPOINT | 🟡 Shaky |
| Build and tag a custom image | ✅ Can do |
| Create and use named volumes | ✅ Can do |
| Use bind mounts | ✅ Can do |
| Create custom networks and connect containers | 🟡 Shaky |
| Write a docker-compose.yml for a multi-container app | ✅ Can do |
| Use environment variables and .env files in Compose | ✅ Can do |
| Write a multi-stage Dockerfile | ✅ Can do |
| Push an image to Docker Hub | ✅ Can do |
| Use healthchecks and depends_on | 🟡 Shaky |

---

## Quick-Fire Questions — Answers

### 1. What is the difference between an image and a container?

An **image** is a read-only blueprint that contains all the dependencies, code, and configuration needed to run an application. A **container** is a live, running instance created from that image. One image can spin up many containers. A container cannot exist without an image.


---

### 2. What happens to data inside a container when you remove it?

The data is **permanently lost**. Containers are ephemeral by design. To persist data, you must attach a named volume (`-v mydata:/app/data`) or a bind mount (`-v $(pwd):/app`) before the container is removed.

---

### 3. How do two containers on the same custom network communicate?

Containers on the same custom network use each other's **container name as the hostname**. Docker has a built-in DNS resolver that maps container names to their internal IP addresses automatically. For example, if a container is named `db`, another container can connect to it at `postgres://db:5432`.

---

### 4. What does `docker compose down -v` do differently from `docker compose down`?

`docker compose down` stops and removes containers and networks, but **leaves volumes intact** (data is safe).

`docker compose down -v` does all of the above and also **deletes named volumes**, wiping any persisted data. Use it when you want a completely clean reset of your environment.


---

### 5. Why are multi-stage builds useful?

Multi-stage builds let you use a heavy builder image (with compilers, dev tools, test runners) for the build step, then copy only the compiled output into a minimal final image. The result is:

- Smaller production image
- No dev dependencies shipped
- Smaller attack surface
- Faster deploys


---

### 6. What is the difference between `COPY` and `ADD`?

`COPY` simply copies files from the host into the image. It is explicit and predictable — **prefer it for most cases**.

`ADD` does everything `COPY` does, plus:
- Automatically extracts `.tar.gz` archives
- Can fetch files from a URL

Use `ADD` only when you specifically need one of those two extra features.

---

### 7. What does `-p 8080:80` mean?

The format is `host:container`. So:
- `8080` = the port on **your machine** (what you visit in the browser)
- `80` = the port **inside the container** (what the app listens on)

Traffic to `localhost:8080` gets forwarded by Docker to port `80` inside the container.


---

### 8. How do you check how much disk space Docker is using?

```bash
docker system df
```

This shows a breakdown of space used by images, containers, volumes, and build cache. `df` alone is a Linux system command — not Docker-specific.


---

---

## Weak Spots to Revisit

### 1. Container networking and Docker DNS

Go back to the networking day and run this hands-on:

```bash
# Create a custom network
docker network create mynet

# Run two containers on it
docker run -d --name db --network mynet postgres:15
docker run -it --network mynet alpine sh

# Inside the alpine container, ping db by name
ping db
```

The fact that `ping db` works — without any IP address — is Docker DNS in action.

### 2. `docker compose down` flags

Practice the difference:

```bash
docker compose up -d              # start services
docker compose down               # stop — volumes still exist
docker volume ls                  # confirm volume is still there

docker compose up -d              # start again
docker compose down -v            # stop — volumes deleted
docker volume ls                  # volume is gone
```

---

## Key Things That Actually Stick From Today

- You don't need to memorize commands — that's what the cheat sheet is for
- The concepts are what matter: ephemeral containers, persistent volumes, image layers, DNS on custom networks
- You understood multi-stage builds better than most beginners — that's the hardest concept on this list
- Repeat usage is what makes the commands stick, not cramming
