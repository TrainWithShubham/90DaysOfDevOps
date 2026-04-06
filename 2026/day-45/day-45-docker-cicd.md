📄 README.md (Final Ready Version)
# 🚀 Docker CI/CD Pipeline using GitHub Actions

---

![![Build and Push to Docker Hub](https://github.com/omdeshmukh304-create/github-action/actions/workflows/build%20_and_push.yml/badge.svg)](https://github.com/omdeshmukh304-create/github-action/actions/workflows/build%20_and_push.yml)

---


https://hub.docker.com/r/omdeshmukh86/flask-app-ecs
---

## 📌 Project Overview

This project demonstrates a complete **CI/CD pipeline** using **GitHub Actions** that automatically builds and pushes a Docker image to Docker Hub whenever code is pushed to the repository.

This setup replicates a real-world production workflow used in DevOps environments.

---

## ⚙️ How It Works


git push
↓
GitHub Actions triggered
↓
Docker image build
↓
Image tagged (latest + commit SHA)
↓
Login to Docker Hub
↓
Push image to Docker Hub
↓
Pull & run anywhere 🚀


---

## 🛠️ Technologies Used

- 🐳 Docker
- ⚙️ GitHub Actions
- 🐍 Flask (Python)
- 📦 Docker Hub

---

## 📁 Project Structure


.
├── app.py
├── requirements.txt
├── Dockerfile
└── .github/workflows/docker-publish.yml


---

## 🔐 GitHub Secrets

The following secrets are used for secure authentication:

- `DOCKER_USERNAME`
- `DOCKER_TOKEN`

---

## 🚀 CI/CD Workflow

### Trigger
- Runs on every push to the repository

### Steps
1. Checkout source code
2. Build Docker image
3. Tag image:
   - `latest`
   - `sha-<commit-hash>`
4. Login to Docker Hub
5. Push image (only on `main` branch)

---

## 🐳 Docker Image

Docker images are available on Docker Hub with:

- `latest` tag
- `sha-<commit>` tag

---

## ▶️ Run Locally

Pull and run the container:

```bash
docker pull <your-username>/flask-app:latest
docker run -d -p 80:80 <your-username>/flask-app:latest

Then open:

http://localhost
🧪 Verification

✅ Workflow executed successfully

✅ Docker image built

✅ Image pushed to Docker Hub

✅ Tags visible (latest + SHA)

✅ Application runs locally

🧠 Key Learnings

Understanding CI/CD pipelines

Automating Docker builds and deployments

Using GitHub Actions workflows

Secure authentication using secrets

Conditional execution in pipelines

⚠️ Challenges Faced

Docker login failed due to insufficient token permissions

Incorrect Git remote configuration

✅ Solutions

Generated a new Docker Hub token with proper access

Fixed Git remote URL to point to the correct repository

🔥 Final Outcome

Successfully built a fully automated CI/CD pipeline that builds and pushes Docker images on every code push.

🚀 Conclusion

This project simulates a real-world DevOps pipeline where application code is automatically built, versioned, and deployed using containerization.

📌 Links

🔗 Docker Hub: https://hub.docker.com/

🔗 GitHub Repo: https://github.com/omdeshmukh304-create/github-action

💡 Author

Om Deshmukh
DevOps Learner 🚀 | #90DaysOfDevOps


---

# 💯 Ye kya hai?

👉 Fully professional README  
👉 Recruiter-ready  
👉 LinkedIn showcase ready  
👉 Assignment submission ready  

---

## ⚡ Next level

Agar chaho:
👉 main tera README aur bhi upgrade kar sakta hoon:
- screenshots section 📸  
- architecture diagram 🧠  
- animated GIF demo 🎥  

Bas bol 😎
day-45-docker-cicd.md ek file banav .md formate sara

Perfect 👍 ye le complete day-45-docker-cicd.md file (clean + professional) — directly copy karke use kar sakta hai:

📄 day-45-docker-cicd.md
# 🚀 Day 45 – Docker Build & Push using GitHub Actions

---

## 📌 Objective

The goal of this task is to build a complete CI/CD pipeline that automatically:
- Builds a Docker image
- Tags the image
- Pushes it to Docker Hub

All of this happens automatically when code is pushed to GitHub.

---

## 🧠 What I Built

- A GitHub Actions workflow for CI/CD
- Automated Docker image build process
- Image tagging with:
  - latest
  - commit SHA
- Secure login and push to Docker Hub

---

## ⚙️ Workflow Explanation


git push
↓
GitHub Actions triggered
↓
Code checkout
↓
Docker image build
↓
Image tagging (latest + SHA)
↓
Login to Docker Hub
↓
Push image to Docker Hub
↓
Pull & run anywhere 🚀


---

## 🛠️ Tools & Technologies Used

- GitHub Actions
- Docker
- Docker Hub
- Flask (Python)

---

## 📁 Project Structure


.
├── app.py
├── requirements.txt
├── Dockerfile
└── .github/workflows/docker-publish.yml


---

## 🔐 Secrets Used

To securely push images to Docker Hub:

- DOCKER_USERNAME
- DOCKER_TOKEN

---

## 🧪 Verification Steps

- ✅ Workflow triggered on push
- ✅ Docker image built successfully
- ✅ Image pushed to Docker Hub
- ✅ Tags created (latest + SHA)
- ✅ Container runs locally

---

## ▶️ Run Locally

Pull and run the Docker image:

```bash
docker pull <your-username>/flask-app:latest
docker run -d -p 80:80 <your-username>/flask-app:latest

Open in browser:

http://localhost
🧠 Key Learnings

How CI/CD pipelines work in real-world scenarios

Automating Docker build and push processes

Using GitHub Actions workflows

Managing secrets securely

Conditional execution in pipelines

⚠️ Challenges Faced

Docker push failed due to insufficient token permissions

Incorrect Git remote configuration

✅ Solutions

Created a new Docker Hub access token with proper permissions

Updated Git remote URL to the correct repository

🔥 Final Outcome

Successfully built a fully automated CI/CD pipeline that:

Builds Docker images automatically

Tags images with versioning

Pushes images to Docker Hub

Allows deployment anywhere using Docker

🚀 Conclusion

This project simulates a real production-level CI/CD pipeline used in DevOps, where application updates are automatically built and deployed using containerization.

📌 Links

Docker Hub: https://hub.docker.com/

GitHub Repo: https://github.com/omdeshmukh304-create/github-action