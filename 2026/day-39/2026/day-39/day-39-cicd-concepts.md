# Day 39 – CI/CD Concepts

# What is CI/CD?

CI/CD is a DevOps practice that automates the process of building, testing, and deploying applications.

It helps developers:
- catch bugs early
- deploy faster
- reduce manual work
- improve software quality

CI/CD is not just a tool.
It is a development and deployment practice followed by teams.

---

# Task 1 – The Problem

## What can go wrong if 5 developers manually deploy code?

- Code conflicts between developers
- One developer may overwrite another developer’s changes
- Bugs can reach production
- Different environments may behave differently
- Manual deployment mistakes can happen
- Rollbacks become difficult
- Deployment takes too much time
- No consistent testing process

## What does “It works on my machine” mean?

This means the application works correctly on the developer’s local system but fails on another machine or server.

Reasons:
- Different OS versions
- Missing dependencies
- Different environment variables
- Different package versions
- Different configurations

This is a real problem because production servers must behave consistently for all users.

## How many times a day can a team safely deploy manually?

Usually only a few times safely.

Manual deployments are:
- slow
- risky
- error-prone

As deployment frequency increases, chances of mistakes also increase.

CI/CD solves this by automating deployments.

---

# Task 2 – CI vs CD

## Continuous Integration (CI)

Continuous Integration is the practice of frequently merging code changes into a shared repository.

Whenever code is pushed:
- application is built
- tests are executed
- errors are detected early

CI helps catch:
- build failures
- syntax errors
- failed tests
- integration issues

### Real-world Example

A developer pushes code to GitHub.
GitHub Actions automatically runs tests and checks if the build succeeds.

---

## Continuous Delivery (CD)

Continuous Delivery means the application is always ready for deployment.

After CI passes:
- application is packaged
- deployment process is automated
- deployment requires manual approval

The software can be released anytime safely.

### Real-world Example

After testing passes, the application is automatically deployed to a staging environment.
A manager clicks “Approve” before production deployment.

---

## Continuous Deployment

Continuous Deployment automatically deploys every successful change directly to production without manual approval.

If tests pass:
- deployment happens automatically

This is faster but requires strong testing and monitoring.

### Real-world Example

Netflix or Facebook automatically deploys small tested changes to production many times a day.

---

# Task 3 – Pipeline Anatomy

## Trigger

An event that starts the pipeline.

Examples:
- git push
- pull request
- manual trigger
- schedule

---

## Stage

A logical phase in the pipeline.

Examples:
- Build
- Test
- Deploy

---

## Job

A group of related tasks inside a stage.

Example:
- Running unit tests
- Building Docker image

---

## Step

A single command or action inside a job.

Example:
```bash
npm install


Developer Pushes Code to GitHub
                |
                v
+------------------------------+
|        Stage 1: Build        |
| - Install dependencies       |
| - Build application          |
+------------------------------+
                |
                v
+------------------------------+
|        Stage 2: Test         |
| - Run unit tests             |
| - Run integration tests      |
+------------------------------+
                |
                v
+------------------------------+
|      Stage 3: Dockerize      |
| - Build Docker image         |
| - Push image to registry     |
+------------------------------+
                |
                v
+------------------------------+
|      Stage 4: Deploy         |
| - Deploy to staging server   |
| - Verify deployment          |
+------------------------------+




---

For LinkedIn, you can share something like:

:::writing{variant="social_post" id="58321"}
🚀 Day 39 of #90DaysOfDevOps

Today I learned the fundamentals of CI/CD before building actual pipelines.

✅ Continuous Integration (CI)
✅ Continuous Delivery (CD)
✅ Continuous Deployment
✅ Pipeline Anatomy
✅ Build → Test → Dockerize → Deploy flow

Also explored real GitHub Actions workflows from the React repository to understand how production-grade CI/CD works.

One important learning:
“A failed pipeline is not failure — it’s protection.”

#DevOps #GitHubActions #CICD #Docker #Kubernetes #90DaysOfDevOps #TrainWithShubham
:::
