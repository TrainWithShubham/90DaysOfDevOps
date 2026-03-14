# Day 45 – Docker Build & Push in GitHub Actions

## Overview
Today I built a complete CI/CD pipeline using GitHub Actions and Docker.  
Whenever code is pushed to the repository, GitHub Actions automatically builds a Docker image and pushes it to Docker Hub. This removes the need for manual Docker build and push steps.

This simulates how real production DevOps pipelines work.

------------------------------------------------------------

## Task 1 – Preparation

Objective  
Prepare the repository and Docker credentials required for the CI pipeline.

Steps Performed

1. Used the application that was Dockerized earlier (Day 36).

2. Added the Dockerfile to the repository `github-actions-practice`.

Example repository structure

```
github-actions-practice  
│  
├── Dockerfile  
├── application files  
└── .github  
    └── workflows  
        └── docker-publish.yml
```

3. Configured Docker Hub authentication in GitHub.

Repository → Settings → Secrets and variables → Actions

Secrets added

DOCKERHUB_TOKEN

Repository variable added

DOCKERHUB_USERNAME

These credentials allow the GitHub Actions runner to log in to Docker Hub securely and push images.

------------------------------------------------------------

## Task 2 – Build Docker Image in CI

Objective  
Automatically build the Docker image when code is pushed to the repository.

Workflow file location

.github/workflows/docker-publish.yml

Workflow configuration

name: Docker Publish

on:
  push:
    branches:
      - main
      - feature/*

jobs:
  build:
    runs-on: ubuntu-latest

    steps:

      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Build Docker Image
        run: docker build -t $DOCKERHUB_USERNAME/myapp:$GITHUB_SHA .

Explanation

Push trigger  
The workflow runs whenever code is pushed to the main branch or a feature branch.

Checkout step  
The repository code is downloaded to the GitHub runner.

Build step  
Docker builds the image using the Dockerfile in the repository.

Verification  
Checked the GitHub Actions logs to confirm the Docker image was built successfully.

------------------------------------------------------------

## Task 3 – Push Docker Image to Docker Hub

Objective  
Push the built Docker image to Docker Hub with two tags.

Docker login step

uses: docker/login-action@v3

Tags used for the image

username/myapp:latest  
username/myapp:sha-shortcommit

Example

shivkumar/myapp:latest  
shivkumar/myapp:sha-3fa9c1b

Tagging step

docker tag username/myapp:$GITHUB_SHA username/myapp:latest  
docker tag username/myapp:$GITHUB_SHA username/myapp:sha-$SHORT_SHA

Push step

docker push username/myapp:latest  
docker push username/myapp:sha-$SHORT_SHA

Verification

Visited Docker Hub repository and confirmed both tags were present.

Example link

https://hub.docker.com/r/username/myapp

------------------------------------------------------------

## Task 4 – Only Push on Main

Objective  
Ensure Docker images are pushed only when code is merged to the main branch.

Condition used in workflow

if: github.ref == 'refs/heads/main'

Behavior

Branch: main  
Image build → Yes  
Image push → Yes

Branch: feature branch  
Image build → Yes  
Image push → No

Testing

Created a feature branch and pushed code.  
Workflow ran successfully.  
Docker build step executed.  
Push step was skipped.

This prevents unnecessary images from being pushed during feature development.

------------------------------------------------------------

## Task 5 – Add a Status Badge

Objective  
Display the pipeline status directly in the repository README.

Badge URL format

https://github.com/<username>/<repo>/actions/workflows/docker-publish.yml/badge.svg

Added badge to README.md

# GitHub Actions Practice

![Docker Publish](https://github.com/<username>/<repo>/actions/workflows/docker-publish.yml/badge.svg)

Result

The badge automatically updates based on workflow status.

Green  → Pipeline succeeded  
Red    → Pipeline failed  
Yellow → Workflow running

------------------------------------------------------------

## Task 6 – Pull and Run the Docker Image

Objective  
Verify that the Docker image created by the CI pipeline works correctly.

Pull the image

docker pull username/myapp:latest

Example

docker pull shivkumar/myapp:latest

Run the container

docker run -d -p 8080:80 shivkumar/myapp:latest

Verify container

docker ps

Open browser

http://localhost:8080

The application loaded successfully, confirming the image built by the pipeline works correctly.

------------------------------------------------------------

## Full Journey – From git push to Running Container

Developer pushes code to GitHub  
↓  
GitHub Actions workflow starts  
↓  
Repository code is checked out  
↓  
Docker image is built  
↓  
Image tagged with latest and commit SHA  
↓  
Image pushed to Docker Hub  
↓  
User pulls image from Docker Hub  
↓  
Container is started locally or on a server

This demonstrates a full CI/CD pipeline for containerized applications.

------------------------------------------------------------

## Real World DevOps Pipeline

Code Commit  
↓  
CI Pipeline builds Docker image  
↓  
Image stored in container registry  
↓  
Deployment system pulls image  
↓  
Application deployed to servers or Kubernetes

Common registries used in production

Docker Hub  
AWS ECR  
Google Artifact Registry  
GitHub Container Registry

------------------------------------------------------------

## Key Learnings

Automated Docker builds using GitHub Actions  
Secure secret management using GitHub Secrets  
Docker image versioning using commit SHA  
Conditional workflow execution  
Publishing images to Docker Hub  
Running containers from CI built images  
Using CI badges to display pipeline health

------------------------------------------------------------

## Screenshots to Add

GitHub Actions pipeline run  

<img width="1328" height="609" alt="image" src="https://github.com/user-attachments/assets/42e182b3-4499-449e-98f5-a97a45c4b6d8" />


Docker build logs in workflow

<img width="973" height="460" alt="image" src="https://github.com/user-attachments/assets/c5bef5df-d996-4565-b615-0310f6ec29c3" />

<img width="958" height="508" alt="image" src="https://github.com/user-attachments/assets/1872390e-2723-4742-afcf-fe8e6d96c41d" />


Docker Hub repository showing image tags  

<img width="1355" height="572" alt="image" src="https://github.com/user-attachments/assets/a70b5da3-4af8-423f-a34d-6fd04cedf485" />


README showing green status badge  

<img width="1027" height="424" alt="image" src="https://github.com/user-attachments/assets/02fdef42-eee5-420b-8709-a3129b4ada16" />

docker pull command output  

<img width="820" height="232" alt="image" src="https://github.com/user-attachments/assets/df7515c0-4067-49c4-a287-97a5f6876d98" />

docker run command  

<img width="835" height="42" alt="image" src="https://github.com/user-attachments/assets/1be5dc72-b97e-466d-a338-d4ff4ba9562d" />

docker ps output showing running container

<img width="1363" height="89" alt="image" src="https://github.com/user-attachments/assets/1f3e4f82-3705-44d5-b188-f0e9a42157fb" />

Application running in browser

<img width="1363" height="680" alt="image" src="https://github.com/user-attachments/assets/cee51c7b-49b3-4a87-b562-cffa9b963341" />

------------------------------------------------------------
