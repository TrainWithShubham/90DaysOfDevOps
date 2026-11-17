# Day 37 – Docker Revision & Cheat Sheet

## Goal
Take a **one-day pause** to consolidate everything from Days 29–36 so Docker actually sticks.

## Expected Output
- A markdown file: `docker-cheatsheet.md`
- A markdown file: `day-37-revision.md` with self-check answers

---

## Self-Assessment Checklist
Mark yourself honestly — **can do**, **shaky**, or **haven't done**:

- [ ] Run a container from Docker Hub (interactive + detached)
- [ ] List, stop, remove containers and images
- [ ] Explain image layers and how caching works
- [ ] Write a Dockerfile from scratch with FROM, RUN, COPY, WORKDIR, CMD
- [ ] Explain CMD vs ENTRYPOINT
- [ ] Build and tag a custom image
- [ ] Create and use named volumes
- [ ] Use bind mounts
- [ ] Create custom networks and connect containers
- [ ] Write a docker-compose.yml for a multi-container app
- [ ] Use environment variables and .env files in Compose
- [ ] Write a multi-stage Dockerfile
- [ ] Push an image to Docker Hub
- [ ] Use healthchecks and depends_on

---

## Quick-Fire Questions
Answer from memory, then verify:
1. What is the difference between an image and a container?
2. What happens to data inside a container when you remove it?
3. How do two containers on the same custom network communicate?
4. What does `docker compose down -v` do differently from `docker compose down`?
5. Why are multi-stage builds useful?
6. What is the difference between `COPY` and `ADD`?
7. What does `-p 8080:80` mean?
8. How do you check how much disk space Docker is using?

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

Keep it short — one line per command, something you'd actually reference on the job.

---

## Revisit Weak Spots
Pick **2 topics** you marked as shaky and redo the hands-on tasks from that day.

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
