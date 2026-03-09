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

## Task 2: Explore Pre-installed Tools

## Overview
In this task I explored what tools are already available on the **ubuntu-latest GitHub-hosted runner**.  
GitHub provides runners with many development tools pre-installed so workflows can run immediately without installing everything from scratch.

---

## Goal
Run commands in a workflow step to print versions of common tools that are already installed on the runner.

Tools checked:

- Docker
- Python
- Node.js
- Git

---

# Workflow Step Used

Example step used inside the workflow:

```
- name: Check preinstalled tools
  run: |
    echo "Docker version:"
    docker --version

    echo "Python version:"
    python --version

    echo "Node version:"
    node --version

    echo "Git version:"
    git --version
```

---

# Example Output

Docker version:
Docker version 24.x.x

Python version:
Python 3.x.x

Node version:
v20.x.x

Git version:
git version 2.x.x

This confirms that these tools are already available on the runner without needing installation.

---

# Full List of Pre-installed Software

GitHub provides documentation listing all software installed on the Ubuntu runner image.

Official documentation:

https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Readme.md

This documentation includes:

- Programming languages
- DevOps tools
- Build tools
- Browsers
- Package managers
- System utilities

Examples of tools available on ubuntu-latest:

Programming languages:
- Python
- Node.js
- Java
- Go
- Ruby
- .NET

DevOps tools:
- Docker
- Git
- Azure CLI
- Kubernetes tools

Build tools:
- Make
- GCC
- CMake
- Gradle
- Maven

Browsers:
- Chrome
- Edge
- Firefox

Package managers:
- apt
- pip
- npm
- yarn

---

# Why It Matters That Runners Come With Tools Pre-installed

Pre-installed tools are important for several reasons.

### 1. Faster CI/CD pipelines
Since tools like Docker, Python, Node, and Git are already installed, workflows start immediately without spending time installing dependencies.

### 2. Reduced setup complexity
Developers do not need to manually configure environments. The runner already contains common development tools.

### 3. Consistent environments
Every workflow run starts with the same environment configuration, which reduces issues caused by environment differences.

### 4. Better developer productivity
Teams can focus on building and testing applications instead of maintaining build infrastructure.

### 5. Lower infrastructure management effort
GitHub manages the runner images and keeps the tools updated, so developers do not need to maintain servers.

---

# Key Learning

- GitHub-hosted runners include many common development tools pre-installed.
- Tools like Docker, Python, Node.js, and Git are available by default.
- The full list of installed tools is documented in the GitHub **runner-images repository**.
- Pre-installed tools make CI pipelines faster, easier to maintain, and more reliable.
