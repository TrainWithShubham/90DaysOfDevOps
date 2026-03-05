# Day 40 – Your First GitHub Actions Workflow

## Overview

On Day 40 of the **#90DaysOfDevOps** challenge, I created and executed my **first GitHub Actions CI workflow**.  
This exercise helped me understand how Continuous Integration works using GitHub Actions.

The workflow was designed to automatically run whenever code is pushed to the repository.

---

# Repository

Repository Name:

github-actions-zero-to-hero

Workflow Location:

.github/workflows/hello.yml

---

# Workflow YAML

```yaml
name: First GitHub Actions Workflow

on: push

jobs:
  greet:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Print Greeting
        run: echo "Hello from GitHub Actions!"

      - name: Show Date and Time
        run: date

      - name: Show Branch Name
        run: echo "Branch name is ${{ github.ref_name }}"

      - name: List Repository Files
        run: ls -la

      - name: Show Runner OS
        run: echo "Runner OS is $RUNNER_OS"
```

---

# Pipeline Execution

After pushing the workflow file to the repository, GitHub automatically triggered the pipeline.

Steps executed in the workflow:

1. Set up job  
2. Checkout repository  
3. Print greeting  
4. Show date and time  
5. Show branch name  
6. List repository files  
7. Show runner OS  
8. Post checkout cleanup  
9. Complete job  

The pipeline completed successfully and showed a **green check mark** in the GitHub Actions tab.

---

# Screenshot of Successful Run

(Add your screenshot here)

Example path if stored in the repository:

images/day40-success.png

---

# Understanding Key Workflow Components

## on

on: push

This defines the **event that triggers the workflow**.  
In this case, the workflow runs automatically whenever code is pushed to the repository.

---

## jobs

jobs:

A workflow is composed of **jobs**.  
Each job represents a group of tasks that will run on a runner machine.

Multiple jobs can run **independently or in parallel**.

---

## runs-on

runs-on: ubuntu-latest

This specifies the **type of machine (runner)** that will execute the job.

In this workflow, GitHub creates a temporary **Ubuntu Linux virtual machine** to run the steps.

---

## steps

steps:

Steps are **individual tasks executed sequentially inside a job**.

Each step can either run commands or use reusable GitHub Actions.

---

## uses

uses: actions/checkout@v4

The `uses` keyword allows us to **use a pre-built GitHub Action**.

`actions/checkout` downloads the repository code into the runner so that the workflow can access the project files.

---

## run

run: echo "Hello from GitHub Actions!"

The `run` keyword executes **shell commands directly on the runner machine**.

This is useful for running scripts, installing dependencies, or executing build commands.

---

## name (step name)

name: Print Greeting

The `name` field gives a **human-readable label to a step**.

This makes it easier to identify steps when viewing logs in the GitHub Actions interface.

---

# Breaking the Pipeline (Learning Exercise)

To understand pipeline failures, a step was intentionally added:

- name: Break the Pipeline  
  run: exit 1

This caused the workflow to fail with the message:

Process completed with exit code 1

This helped demonstrate how CI systems detect errors using **exit codes**.

After observing the failure, the step was removed and the pipeline ran successfully again.

---

# Key Learnings

- How to create a **GitHub Actions workflow**
- Understanding **workflow triggers**
- How **jobs and steps** work
- How to run **commands inside CI runners**
- Viewing and debugging **pipeline logs**
- Understanding **exit codes and pipeline failures**

---

# CI Workflow Process

git push  
↓  
GitHub detects workflow  
↓  
Runner VM is created  
↓  
Workflow steps execute  
↓  
Logs generated  
↓  
Runner destroyed after job completion  

---

# Conclusion

This exercise provided hands-on experience with **GitHub Actions CI pipelines**.  
I learned how workflows are structured, how jobs run on GitHub runners, and how to debug pipeline failures.

This is an important foundation for building **real CI/CD pipelines in DevOps workflows**.

---

# Hashtags

#90DaysOfDevOps  
#DevOpsKaJosh  
#TrainWithShubham  
#GitHubActions  
#DevOps
