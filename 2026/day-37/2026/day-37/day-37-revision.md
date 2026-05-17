# Day 37 – Docker Revision & Cheat Sheet

---

## Self-Assessment Checklist
Mark yourself honestly — **can do**, **shaky**, or **haven't done**:

- [ **can do**] Run a container from Docker Hub (interactive + detached)
- [ **can do**] List, stop, remove containers and images
- [ **shaky**] Explain image layers and how caching works
- [ **can do**] Write a Dockerfile from scratch with FROM, RUN, COPY, WORKDIR, CMD
- [ **shaky** ] Explain CMD vs ENTRYPOINT
- [**can do** ] Build and tag a custom image
- [ **can do**] Create and use named volumes
- [ **can do**] Use bind mounts
- [ **can do**] Create custom networks and connect containers
- [ **can do**] Write a docker-compose.yml for a multi-container app
- [**can do** ] Use environment variables and .env files in Compose
- [ **can do**] Write a multi-stage Dockerfile
- [ **can do**] Push an image to Docker Hub
- [ **can do**] Use healthchecks and depends_on

---

## Quick-Fire Questions
Answer from memory, then verify:
1. What is the difference between an image and a container?
- An image is a read-only blueprint. A container is a running instance of that image.

2. What happens to data inside a container when you remove it?
- Data is deleted unless stored in a volume or bind mount.

3. How do two containers on the same custom network communicate?
-  Containers can communicate using their names.

4. What does `docker compose down -v` do differently from `docker compose down`?
- `docker compose down -v ` stops and removes containers and networks along with volumes & `docker compose down` stops and removes containers and networks.

5. Why are multi-stage builds useful?
- Multi-stage builds smaller images because they separate “build” from “runtime”, copying only what’s necessary into the final image.

6. What is the difference between `COPY` and `ADD`?
- `COPY`: Copy files from local system (Docker VM). We nned to provide Source,Destination
- `ADD` : Similar to COPY but,it provides a feature to download files from internet,also we extract file.

7. What does `-p 8080:80` mean?
- `-p 8080:80` maps a port on your host machine to a port inside the container.

8. How do you check how much disk space Docker is using?
- Using command `docker system df`

---

## Build Your Docker Cheat Sheet
Create `docker-cheatsheet.md` organized by category:
- **Container commands** — run, ps, stop, rm, exec, logs
- **Image commands** — build, pull, push, tag, ls, rm
- **Volume commands** — create, ls, inspect, rm
- **Network commands** — create, ls, inspect, connect
- **Compose commands** — up, down, ps, logs, build
- **Cleanup commands** — prune, system df
- **Dockerfile instructions** — FROM, RUN, COPY, WORKDIR, EXPOSE, CMD, ENTRYPOINT

[Cheatsheet](https://github.com/srdangat/devops-notes/blob/main/docker/cheatsheet.md)
---

## Revisit Weak Spots
Pick **2 topics** you marked as shaky and redo the hands-on tasks from that day.

1. Explain image layers and how caching works

- Gained a clear understanding of Docker image layers and how caching works.

2. Explain CMD vs ENTRYPOINT
- Understood the difference between CMD and ENTRYPOINT, where ENTRYPOINT defines the main executable and CMD provides default arguments that can be overridden at runtime.
---

## Suggested Flow (45–60 minutes)
- 10 min: go through the checklist honestly
- 10 min: answer quick-fire questions
- 20 min: build your cheat sheet
- 10 min: redo one weak area

---

## Submission
1. Add `docker-cheatsheet.md` and `day-37-revision.md` to `2026/day-37/`
2. Commit and push to your fork

---

## Learn in Public
Share your Docker cheat sheet on LinkedIn — help others revise too.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
