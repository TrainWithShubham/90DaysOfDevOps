# Day 43 – Jobs, Steps, Env Vars & Conditionals

## Overview

Today I learned how to **control the execution flow of GitHub Actions pipelines** using:

- Multiple jobs
- Job dependencies
- Environment variables
- Passing outputs between jobs
- Conditional execution of jobs and steps

These concepts are important because **real CI/CD pipelines are not just single scripts**.  
They contain **multiple stages like build, test, security checks, and deployment** that must run in a specific order.

Example real pipeline:

Build → Test → Security Scan → Package → Deploy

GitHub Actions allows us to design such pipelines using **jobs, steps, outputs, and conditionals**.

---

# Task 1 – Multi Job Workflow

## Context of the Task

In real DevOps pipelines, applications go through **multiple stages before deployment**.

Typical flow:

Code Push → Build → Test → Deploy

We cannot deploy the application **unless the build and tests succeed**.

This task teaches how to create **dependent jobs**.

---

## Goal

Create a workflow with three jobs:

- build
- test
- deploy

Execution order:

build → test → deploy

This is achieved using **job dependencies**.

---

## Key Concept

needs

The `needs` keyword makes a job run **only after another job completes successfully**.

Example:

needs: build

This means the job will start **only after the build job finishes successfully**.

---

## Example Workflow

name: Multi Job Workflow

on:
  push:

jobs:

  build:
    runs-on: ubuntu-latest
    steps:
      - name: Build application
        run: echo "Building the app"

  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Run tests
        run: echo "Running tests"

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - name: Deploy application
        run: echo "Deploying"

---

## Execution Flow

build  
 ↓  
test  
 ↓  
deploy  

GitHub Actions graph will show the **dependency chain**.

---

## Real World Usage

Used in almost every CI/CD pipeline.

Example pipeline:

Code Push  
 ↓  
Build Application  
 ↓  
Run Unit Tests  
 ↓  
Run Integration Tests  
 ↓  
Build Docker Image  
 ↓  
Deploy to Kubernetes

Using `needs` ensures **deployment only happens if all previous stages succeed**.

---

# Task 2 – Environment Variables

## Context of the Task

In real pipelines, we often reuse values such as:

- application name
- environment (dev, staging, production)
- version numbers
- API endpoints

Instead of repeating them everywhere, we store them in **environment variables**.

---

## Environment Variables in GitHub Actions

Environment variables can be defined at three levels.

---

## 1. Workflow Level

Available to all jobs and steps.

env:
  APP_NAME: myapp

---

## 2. Job Level

Available only inside a specific job.

env:
  ENVIRONMENT: staging

---

## 3. Step Level

Available only inside a specific step.

env:
  VERSION: 1.0.0

---

## Example Workflow

name: Environment Variables Demo

on:
  push:

env:
  APP_NAME: myapp

jobs:

  env-demo:
    runs-on: ubuntu-latest

    env:
      ENVIRONMENT: staging

    steps:

      - name: Print variables
        env:
          VERSION: 1.0.0
        run: |
          echo "App: $APP_NAME"
          echo "Environment: $ENVIRONMENT"
          echo "Version: $VERSION"

---

## Real World Usage

Environment variables are used for:

- environment configuration
- deployment environments
- container image names
- API keys
- service URLs

Example:

APP_NAME=myapp  
ENVIRONMENT=staging  
DOCKER_IMAGE=myapp:v1.2

This makes workflows **cleaner and easier to maintain**.

---

# GitHub Context Variables

GitHub automatically provides **context variables** with information about the workflow run.

Examples:

github.actor → user who triggered the workflow  
github.sha → commit SHA  
github.ref → branch reference  
github.event → full event payload  

Example:

- name: Print context variables
  run: |
    echo "Actor: ${{ github.actor }}"
    echo "Commit SHA: ${{ github.sha }}"

---

## Real World Usage

Context variables are used for:

- tracking who triggered deployments
- tagging Docker images with commit SHA
- identifying branch-based deployments
- generating release notes

Example:

docker build -t myapp:${{ github.sha }}

---

# Task 3 – Job Outputs

## Context of the Task

In real pipelines, jobs run on **different runners**.

This means **jobs cannot share variables directly**.

So GitHub provides **outputs** to pass data between jobs.

Example:

Build job creates Docker image tag → Deploy job uses that tag.

---

## Step 1 – Set Output

echo "date=$(date)" >> $GITHUB_OUTPUT

---

## Step 2 – Define Job Output

outputs:
  today: ${{ steps.date_step.outputs.date }}

---

## Step 3 – Access Output in Another Job

${{ needs.job-name.outputs.output-name }}

---

## Example Workflow

name: Job Outputs Example

on:
  workflow_dispatch:

jobs:

  generate_date:
    runs-on: ubuntu-latest

    outputs:
      today: ${{ steps.date_step.outputs.date }}

    steps:
      - name: Generate date
        id: date_step
        run: |
          echo "date=$(date)" >> $GITHUB_OUTPUT

  print_date:
    needs: generate_date
    runs-on: ubuntu-latest

    steps:
      - name: Print date
        run: echo "Today's date is ${{ needs.generate_date.outputs.today }}"

---

## Real World Usage

Passing outputs is used when:

- passing Docker image tag from build job to deploy job
- passing artifact name
- passing build version
- passing test reports

Example pipeline:

Build Docker Image  
 ↓  
Generate Image Tag  
 ↓  
Deploy using Image Tag

---

# Task 4 – Conditionals

## Context of the Task

In real pipelines, some tasks should run **only under certain conditions**.

Examples:

- Deploy only on main branch
- Run security scans only on pull requests
- Run rollback steps if deployment fails

Conditionals allow this behavior.

---

## Run Step Only on Main Branch

if: github.ref == 'refs/heads/main'

Example:

- name: Run only on main branch
  if: ${{ github.ref == 'refs/heads/main' }}
  run: echo "This runs only on main branch"

---

## Run Step When Previous Step Failed

GitHub provides a function:

failure()

Example:

- name: Run when previous step fails
  if: ${{ failure() }}
  run: echo "Previous step failed"

---

## Run Job Only on Push Events

if: github.event_name == 'push'

Example:

jobs:
  deploy:
    if: ${{ github.event_name == 'push' }}

This prevents deployments during pull requests.

---

## continue-on-error

Normally if a step fails:

exit 1

the job stops immediately.

Using:

continue-on-error: true

the workflow continues even if the step fails.

Example:

- name: Fail but continue
  continue-on-error: true
  run: exit 1

---

## Real World Usage

Used for:

- optional checks
- security scans
- cleanup scripts
- notification steps
- debugging steps

Example:

Run security scan → continue pipeline even if scan fails.

---

# Task 5 – Smart Pipeline

## Context of the Task

Modern CI pipelines often run **multiple checks in parallel** to speed up builds.

Example:

Lint  
Unit Tests  
Security Scan  

Running them sequentially would slow down pipelines.

So we run them **in parallel**, then combine results.

---

## Pipeline Requirements

- trigger on push
- run lint and test in parallel
- run summary job after both finish
- detect branch type
- print commit message

---

## Example Workflow

name: Smart Pipeline

on:
  push:

jobs:

  lint:
    runs-on: ubuntu-latest
    steps:
      - name: Run lint checks
        run: echo "Running lint checks"

  test:
    runs-on: ubuntu-latest
    steps:
      - name: Run tests
        run: echo "Running tests"

  summary:
    needs: [lint, test]
    runs-on: ubuntu-latest

    steps:

      - name: Print summary
        run: echo "Jobs completed"

      - name: Detect main branch
        if: ${{ github.ref == 'refs/heads/main' }}
        run: echo "Push to main branch"

      - name: Detect feature branch
        if: ${{ github.ref != 'refs/heads/main' }}
        run: echo "Push to feature branch"

      - name: Print commit message
        run: echo "Commit message: ${{ github.event.head_commit.message }}"

---

## Pipeline Execution

lint  ───┐  
         ├── summary  
test  ───┘  

lint and test run **in parallel**.

summary runs **only after both finish**.

---

# Key Concepts Learned

Jobs → independent stages of workflow  
Steps → commands executed inside jobs  
needs → defines job dependency  
env → environment variables  
outputs → pass data between jobs  
if → conditional execution  
continue-on-error → continue workflow even after failure  

---

# Summary

Today I learned how to design **more advanced GitHub Actions pipelines** using:

- multiple jobs
- job dependencies
- environment variables
- passing outputs between jobs
- conditional logic

These features help build **real-world CI/CD pipelines used in DevOps automation**.

---

# Tags

#90DaysOfDevOps  
#DevOpsKaJosh  
#TrainWithShubham
