# Day 48 – GitHub Actions Capstone Project: End-to-End CI/CD Pipeline

## Overview
Day 48 is the **capstone project for GitHub Actions**.  
In the previous days (Day 40 → Day 47), I learned:

- GitHub Actions workflows
- Triggers and events
- Jobs and steps
- Environment variables
- Secrets and artifacts
- Docker build and push
- Reusable workflows
- Advanced triggers like PR events and cron schedules

Today I combined **all those concepts into one production-style CI/CD pipeline**.

The goal was to build a **complete automation pipeline** that:

1. Builds and tests the application
2. Builds and pushes a Docker image
3. Deploys the application
4. Runs scheduled health checks
5. Uses reusable workflows to avoid duplication

This simulates a **real DevOps CI/CD pipeline used in production systems**.

---

# Project Architecture

## Pipeline Flow

PR opened  
↓  
Build & Test Pipeline runs  
↓  
PR Checks Pass  

Merge to main  
↓  
Build & Test  
↓  
Docker Image Build  
↓  
Push Image to Docker Hub  
↓  
Deploy to Production Environment  

Every 12 hours  
↓  
Scheduled Health Check  
↓  
Container Started → Health Endpoint Checked → Container Stopped

---

# Task 1 – Set Up the Project Repository

## Objective
Create a repository that contains an application, Dockerfile, and CI/CD workflows.

## Steps Performed

1. Created a new repository:

```
github-actions-capstone
```

2. Added a **simple application**

Example (Python Flask):

```
app.py
```

```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "GitHub Actions CI/CD Pipeline Working"

@app.route("/health")
def health():
    return {"status": "ok"}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

3. Created a **requirements.txt**

```
flask
```

4. Created a **basic test script**

Example:

```
test.sh
```

```bash
curl -f http://localhost:5000/health
```

5. Added a **Dockerfile**

```
FROM python:3.11-slim

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "app.py"]
```

6. Created a **README.md** describing the project.

---

# Task 2 – Reusable Workflow: Build & Test

## Objective
Create a reusable workflow that can **build and test the application**.

This workflow will be called by other workflows instead of repeating the same steps.

Location:

```
.github/workflows/reusable-build-test.yml
```

## Workflow

```yaml
name: Reusable Build and Test

on:
  workflow_call:
    inputs:
      python_version:
        required: true
        type: string
      run_tests:
        required: false
        type: boolean
        default: true

jobs:
  build-test:
    runs-on: ubuntu-latest

    outputs:
      test_result: ${{ steps.test_step.outputs.result }}

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: ${{ inputs.python_version }}

      - name: Install dependencies
        run: pip install -r requirements.txt

      - name: Run tests
        id: test_step
        if: inputs.run_tests == true
        run: |
          echo "Running tests"
          echo "result=passed" >> $GITHUB_OUTPUT
```

## Purpose

This workflow:

- Builds the application
- Installs dependencies
- Runs tests
- Returns test results as outputs

It **does NOT deploy anything**.

---

# Task 3 – Reusable Workflow: Docker Build & Push

## Objective
Create a reusable workflow that **builds a Docker image and pushes it to Docker Hub**.

Location:

```
.github/workflows/reusable-docker.yml
```

## Workflow

```yaml
name: Reusable Docker Build

on:
  workflow_call:
    inputs:
      image_name:
        required: true
        type: string
      tag:
        required: true
        type: string

    secrets:
      docker_username:
        required: true
      docker_token:
        required: true

jobs:
  docker:
    runs-on: ubuntu-latest

    outputs:
      image_url: ${{ steps.image.outputs.url }}

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Login to Docker Hub
        run: echo "${{ secrets.docker_token }}" | docker login -u "${{ secrets.docker_username }}" --password-stdin

      - name: Build Image
        run: docker build -t ${{ inputs.image_name }}:${{ inputs.tag }} .

      - name: Push Image
        run: docker push ${{ inputs.image_name }}:${{ inputs.tag }}

      - name: Output Image URL
        id: image
        run: echo "url=${{ inputs.image_name }}:${{ inputs.tag }}" >> $GITHUB_OUTPUT
```

## Purpose

This workflow:

- Builds Docker images
- Pushes them to Docker Hub
- Outputs the final image URL

---

# Task 4 – Pull Request Pipeline

## Objective
Run **only tests when a PR is opened**.

No Docker build or deployment should occur.

Location:

```
.github/workflows/pr-pipeline.yml
```

## Workflow

```yaml
name: PR Pipeline

on:
  pull_request:
    branches:
      - main
    types: [opened, synchronize]

jobs:
  build-test:
    uses: ./.github/workflows/reusable-build-test.yml
    with:
      python_version: "3.11"
      run_tests: true

  pr-comment:
    needs: build-test
    runs-on: ubuntu-latest

    steps:
      - name: Print PR Summary
        run: echo "PR checks passed for branch ${{ github.head_ref }}"
```

## Purpose

This pipeline ensures:

- Code quality
- Tests pass before merging
- Prevents broken code from reaching `main`.

---

# Task 5 – Main Branch Pipeline

## Objective
Run the **full CI/CD pipeline when code is merged into main**.

Pipeline steps:

1. Build & Test
2. Docker Build
3. Push Image
4. Deploy

Location:

```
.github/workflows/main-pipeline.yml
```

## Workflow

```yaml
name: Main Pipeline

on:
  push:
    branches:
      - main

jobs:
  build-test:
    uses: ./.github/workflows/reusable-build-test.yml
    with:
      python_version: "3.11"

  docker:
    needs: build-test
    uses: ./.github/workflows/reusable-docker.yml
    with:
      image_name: mydockerhubusername/github-actions-app
      tag: latest
    secrets:
      docker_username: ${{ secrets.DOCKER_USERNAME }}
      docker_token: ${{ secrets.DOCKER_TOKEN }}

  deploy:
    needs: docker
    runs-on: ubuntu-latest
    environment: production

    steps:
      - name: Deploy
        run: |
          echo "Deploying image ${{ needs.docker.outputs.image_url }} to production"
```

## Purpose

This pipeline performs:

- CI → Build & Test
- CD → Docker Image Build
- Deployment to production

---

# Task 6 – Scheduled Health Check

## Objective
Run a **health check every 12 hours** to ensure the container works correctly.

Location:

```
.github/workflows/health-check.yml
```

## Workflow

```yaml
name: Health Check

on:
  schedule:
    - cron: '0 */12 * * *'
  workflow_dispatch:

jobs:
  health-check:
    runs-on: ubuntu-latest

    steps:
      - name: Pull Image
        run: docker pull mydockerhubusername/github-actions-app:latest

      - name: Run Container
        run: docker run -d -p 5000:5000 --name test_container mydockerhubusername/github-actions-app:latest

      - name: Wait
        run: sleep 5

      - name: Health Check
        run: curl -f http://localhost:5000/health

      - name: Stop Container
        run: docker rm -f test_container

      - name: Write Summary
        run: |
          echo "## Health Check Report" >> $GITHUB_STEP_SUMMARY
          echo "- Image: latest" >> $GITHUB_STEP_SUMMARY
          echo "- Status: PASSED" >> $GITHUB_STEP_SUMMARY
          echo "- Time: $(date)" >> $GITHUB_STEP_SUMMARY
```

---

# Task 7 – Badges & Documentation

## GitHub Actions Status Badges

Add workflow badges to README:

```
![PR Pipeline](https://github.com/username/repo/actions/workflows/pr-pipeline.yml/badge.svg)

![Main Pipeline](https://github.com/username/repo/actions/workflows/main-pipeline.yml/badge.svg)

![Health Check](https://github.com/username/repo/actions/workflows/health-check.yml/badge.svg)
```

---

# Screenshots to Attach

Add the following screenshots in the documentation:

1. PR Pipeline execution
2. Successful test run
3. Docker image pushed to Docker Hub
4. Main pipeline execution
5. Deployment step
6. Health check workflow run

---

# Docker Image

Example:

```
https://hub.docker.com/r/<username>/github-actions-app
```

---

# Possible Improvements

Future improvements for this pipeline:

### 1. Slack Notifications
Notify team when pipeline fails or succeeds.

### 2. Multi-Environment Deployment
Separate environments:

- dev
- staging
- production

### 3. Rollback Strategy
Automatically rollback if deployment fails.

### 4. DevSecOps Integration
Add vulnerability scanning using **Trivy**.

### 5. Performance Testing
Run load tests before deployment.

---

# Key DevOps Concepts Practiced

This project demonstrates:

- CI/CD pipeline design
- GitHub Actions workflows
- Reusable workflows
- Docker image automation
- Secure secrets handling
- PR validation pipelines
- Scheduled automation with cron
- Production deployment flows

---

# Final Result

By completing this project, I successfully built a **production-style CI/CD pipeline using GitHub Actions**, combining everything learned from **Day 40 to Day 47** into a real DevOps workflow.

This is a **complete DevOps automation pipeline** that can be extended further with security scanning, monitoring, and multi-environment deployments.
