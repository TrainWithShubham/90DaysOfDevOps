# Day 42 – GitHub Hosted Runners

## Overview
In this task I learned how GitHub Actions workflows run on **GitHub-hosted runners** and how the same workflow can execute jobs on different operating systems.  
I created a workflow that runs **three jobs in parallel** on Ubuntu, Windows, and macOS runners and prints information about each runner.

---

# Task – GitHub Hosted Runners

## Goal
Create a workflow with **3 jobs**, each running on a different operating system:

- ubuntu-latest
- windows-latest
- macos-latest

Each job prints:
- OS name
- Runner hostname
- Current user executing the job

All jobs run **in parallel**.

---

# Workflow File

File location:

.github/workflows/github-hosted-runners.yml

YAML configuration:

name: GitHub Hosted Runners Practice

on:
  workflow_dispatch:

jobs:
  ubuntu:
    runs-on: ubuntu-latest

    steps:
      - name: Print OS name
        run: uname -a

      - name: Print runner hostname
        run: hostname

      - name: Print current user
        run: whoami

  windows:
    runs-on: windows-latest

    steps:
      - name: Print OS name
        run: systeminfo | findstr /B /C:"OS Name"

      - name: Print runner hostname
        run: hostname

      - name: Print current user
        run: whoami

  macos:
    runs-on: macos-latest

    steps:
      - name: Print OS name
        run: sw_vers -productName

      - name: Print runner hostname
        run: hostname

      - name: Print current user
        run: whoami

---

# Result

When the workflow runs, GitHub creates **three separate runners**.

Each job runs **simultaneously on a different operating system**.

Jobs created:

| Job | Runner OS |
|----|----|
| ubuntu | Ubuntu Linux |
| windows | Windows Server |
| macos | macOS |

All jobs run **in parallel**.

---

# Example Output

### Ubuntu Runner

Linux fv-az123-456 6.x.x x86_64 GNU/Linux  
fv-az123-456  
runner  

### Windows Runner

OS Name: Microsoft Windows Server 2022 Datacenter  
fv-az789-321  
runneradmin  

### macOS Runner

macOS  
fv-az654-987  
runner  

---

# What is a GitHub-hosted runner?

A **GitHub-hosted runner** is a virtual machine provided by GitHub that runs workflow jobs.

These runners are automatically created when a workflow starts and destroyed after the job finishes.

They come with pre-installed tools such as:

- Git
- Docker
- Node.js
- Python
- Java
- Build tools and package managers

This allows CI/CD pipelines to run without manually setting up infrastructure.

---

# Who manages GitHub-hosted runners?

GitHub-hosted runners are **fully managed by GitHub**.

GitHub handles:

- Infrastructure provisioning
- Operating system setup
- Security patches
- Tool installation
- Runner lifecycle management

Developers only need to define the **workflow configuration**, and GitHub takes care of the rest.

---





#90DaysOfDevOps  
#DevOpsKaJosh  
#TrainWithShubham
