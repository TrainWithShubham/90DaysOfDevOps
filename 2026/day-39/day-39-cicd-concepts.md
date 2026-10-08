# Day 39 – What is CI/CD?

Today I learned basic CI/CD concepts before creating actual pipelines.

CI/CD helps automate software delivery and reduce manual deployment problems.

---

# Problems Without CI/CD

If many developers deploy code manually:

- code conflicts happen
- production can break
- deployment becomes slow
- human mistakes happen
- troubleshooting becomes difficult

Manual deployment is risky because every developer may have different environment or process.

---

# “It Works on My Machine”

This means application works on developer machine but fails on another machine or server.

Reasons:

- different software versions
- missing dependencies
- different environment variables
- different OS configuration

Example:

Application works on local laptop but fails on production server because Python or Java version is different.

CI/CD helps maintain same process and consistency everywhere.

---

# Continuous Integration (CI)

Continuous Integration means developers frequently push code to shared repository.

When developer pushes code:

- pipeline automatically starts
- application builds automatically
- automated tests run
- bugs are detected early
- broken code is stopped before deployment

CI mainly focuses on integrating code changes safely.

Example:
Developer pushes code to GitHub and GitHub Actions automatically runs build and tests.

---

# What Happens Internally During CI?

Developer pushes code to GitHub
↓
GitHub detects new code change
↓
Workflow YAML file is read
↓
Runner machine starts automatically
↓
Project source code is downloaded on runner
↓
Dependencies are installed
↓
Build process starts
↓
Automated tests run
↓
Linting and code quality checks run
↓
If everything passes, pipeline becomes successful
↓
Artifact or Docker image gets created

If test fails:

- pipeline stops
- deployment does not happen
- developer fixes issue and pushes again

This helps catch problems early before production.

---

# Continuous Delivery

Continuous Delivery means application is always ready for deployment.

After successful testing:

- build is packaged
- release is prepared
- deployment needs manual approval

Main focus:
Application should always stay deployable.

Example:
Manager or DevOps engineer manually approves production deployment.

---

# Continuous Deployment

Continuous Deployment automatically deploys application after all tests pass.

No manual approval is needed.

Internally:

- tests pass
- Docker image builds
- deployment automatically starts
- new version goes live automatically

Example:
Netflix automatically deploys updates after successful testing.

---

# Pipeline Anatomy

## Trigger

Starts pipeline automatically.

Examples:

- git push
- pull request
- schedule
- manual workflow dispatch

---

## Stage

Logical phase of pipeline.

Examples:

- build
- test
- deploy

Stages help organize workflow properly.

---

## Job

A task inside stage.

Example:

- run tests
- build Docker image
- scan security vulnerabilities

Jobs can run sequentially or parallel.

---

## Step

Single command or action inside job.

Examples:

- checkout code
- install dependencies
- run docker build

Steps are smallest execution unit.

---

## Runner

Machine that executes pipeline jobs.

Examples:

- GitHub-hosted runner
- self-hosted runner
- Jenkins server

Runner provides CPU, memory, operating system, and environment to execute jobs.

---

## Artifact

Output generated from pipeline.

Examples:

- Docker image
- build package
- compiled application
- test reports

Artifacts can be reused in later stages.

---

# Simple CI/CD Pipeline Flow

Developer Writes Code
↓
Pushes Code to GitHub
↓
GitHub Detects Change
↓
Pipeline Starts Automatically
↓
Runner Machine Starts
↓
Dependencies Install
↓
Application Builds
↓
Tests Execute
↓
Docker Image Builds
↓
Artifact Stores
↓
Deploy to Staging Server
↓
Deployment Logs Generated

---

# Open Source Workflow Research

Repository:
FastAPI

Workflow Folder:
.github/workflows/

What triggers workflow?

- push
- pull_request

What does workflow do?

- runs automated tests
- validates code
- checks code quality
- verifies application build

---

# Important Interview Concepts

## Why CI/CD is important?

CI/CD improves:

- automation
- reliability
- consistency
- deployment speed
- early bug detection

---

## Why pipeline failure is good?

Pipeline failure prevents broken code from reaching production.

It helps developers fix issues early.

---

## Difference Between CI and CD

CI:
Focuses on build and testing.

CD:
Focuses on deployment and release automation.

---

## Why Automation Matters?

Without automation:

- deployments become slow
- mistakes increase
- troubleshooting becomes difficult

Automation reduces manual effort and improves stability.

---

# What I Learned

1. CI/CD automates software delivery process.
2. Pipeline internally performs many automated tasks.
3. CI catches problems before deployment.
4. Automation improves deployment reliability.
5. YAML workflows control CI/CD pipelines.

---

# Important Note

Pipeline failure is not bad.

It means CI/CD detected issue before production deployment and protected production environment.
