# Day 36 – Docker Project: Dockerize a Full Application

## Task
Today's goal is to **take a real application and Dockerize it end-to-end**.

No tutorials. No hand-holding. Pick an app, write the Dockerfile, set up Compose, and ship it. This is what you'll do on the job.

---

## Expected Output
- A markdown file: `day-36-docker-project.md`
- Complete project with Dockerfile, docker-compose.yml, and app code
- Image pushed to Docker Hub

---

## Challenge Tasks

### Task 1: Pick Your App
Choose **one** of these (or use your own project):
- A **Python Flask/Django** app with a database
- A **Node.js Express** app with MongoDB
- A **static website** served by Nginx with a backend API
- Any app from your GitHub that doesn't have Docker yet

If you don't have an app, clone a simple open-source one and Dockerize it.

---

### Task 2: Write the Dockerfile
1. Create a Dockerfile for your application
2. Use a **multi-stage build** if applicable
3. Use a **non-root user**
4. Keep the image **small** — use alpine or slim base images
5. Add a `.dockerignore` file

Build and test it locally.

---

### Task 3: Add Docker Compose
Write a `docker-compose.yml` that includes:
1. Your **app** service (built from Dockerfile)
2. A **database** service (Postgres, MySQL, MongoDB — whatever your app needs)
3. **Volumes** for database persistence
4. A **custom network**
5. **Environment variables** for configuration (use `.env` file)
6. **Healthchecks** on the database

Run `docker compose up` and verify everything works together.

---

### Task 4: Ship It
1. Tag your app image
2. Push it to Docker Hub
3. Share the Docker Hub link
4. Write a `README.md` in your project with:
   - What the app does
   - How to run it with Docker Compose
   - Any environment variables needed

---

### Task 5: Test the Whole Flow
1. Remove all local images and containers
2. Pull from Docker Hub and run using only your compose file
3. Does it work fresh? If not — fix it until it does

---

## Documentation
Create `day-36-docker-project.md` with:
- What app you chose and why
- Your Dockerfile (with comments explaining each line)
- Challenges you faced and how you solved them
- Final image size
- Docker Hub link

---

## Submission
1. Add all project files and `day-36-docker-project.md` to `2026/day-36/`
2. Commit and push to your fork

---

## Learn in Public
Share your Dockerized project on LinkedIn — include the Docker Hub link so others can pull and run it.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
