# Day 42 – Runners: GitHub-Hosted & Self-Hosted


## Task 1: GitHub Hosted Runners

## Overview
In this task I learned how GitHub Actions workflows run on **GitHub-hosted runners** and how the same workflow can execute jobs on different operating systems.  
I created a workflow that runs **three jobs in parallel** on Ubuntu, Windows, and macOS runners and prints information about each runner.

---

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

---

## Task 3 – Self-Hosted Runner Setup

## Overview
In this task I learned how to set up a **self-hosted runner** for GitHub Actions.  
Unlike GitHub-hosted runners, a self-hosted runner runs workflows on **my own machine or cloud server**.  
I configured a self-hosted runner on an **Ubuntu EC2 instance** and connected it to my GitHub repository.

---

## Goal
Set up a self-hosted runner for a GitHub repository and verify that it appears in the runner list and is ready to accept jobs.

Steps required:

1. Go to repository → **Settings**
2. Navigate to **Actions → Runners**
3. Click **New self-hosted runner**
4. Choose **Linux** as the operating system
5. Follow the setup instructions on the machine where the runner will run

---

# Environment Used

Runner hosted on:

- **AWS EC2 instance**
- Operating System: **Ubuntu Linux**
- Architecture: **x64**

The runner was configured inside a directory called:

actions-runner

---

# Commands Used to Set Up the Runner

### Download Runner Package

```
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64.tar.gz -L https://github.com/actions/runner/releases/download/vX.X.X/actions-runner-linux-x64-X.X.X.tar.gz
tar xzf ./actions-runner-linux-x64.tar.gz
```

### Configure Runner

```
./config.sh
```

During configuration I provided:

- GitHub repository URL
- Registration token
- Runner name

Example runner name:

shiv-ubuntu-runner

---

# Start the Runner

To start the runner:

```
./run.sh
```

Example output:

```
Connected to GitHub
Current runner version: 2.332.0
Listening for Jobs
```

This confirms the runner successfully connected to GitHub.

---

# Verification in GitHub

After starting the runner:

1. Go to **Repository → Settings**
2. Open **Actions → Runners**

The runner appears in the list.

Example:

Runner name: **shiv-ubuntu-runner**

Labels shown:

- self-hosted
- Linux
- X64
- prod

Status:

● Idle (green dot)

This means the runner is **online and ready to execute workflow jobs**.

---

# What is a Self-Hosted Runner?

A **self-hosted runner** is a machine that you manage yourself and register with GitHub to run workflow jobs.

It can run on:

- Local machines
- Cloud servers (AWS, Azure, GCP)
- Virtual machines
- On-premise infrastructure

---

# GitHub-Hosted vs Self-Hosted Runners

| Feature | GitHub Hosted Runner | Self Hosted Runner |
|------|------|------|
| Managed by | GitHub | User |
| Infrastructure | GitHub cloud | Your machine or server |
| Setup required | No | Yes |
| Custom tools | Limited | Fully customizable |
| Cost | Included in GitHub Actions limits | Depends on your infrastructure |

---

# Why Use Self-Hosted Runners?

Self-hosted runners are useful when:

1. You need **custom tools or software**
2. You require **specific hardware**
3. Workflows need access to **private networks**
4. You want **more control over the environment**
5. Large builds require **more resources**

---

# Key Learnings

- A self-hosted runner allows workflows to run on machines managed by the user.
- It must be **downloaded, configured, and started manually**.
- Once started, it connects to GitHub and waits for jobs.
- GitHub shows the runner status as **Idle** when it is ready.
- A green dot in the runner list confirms the runner is **online and active**.

---
