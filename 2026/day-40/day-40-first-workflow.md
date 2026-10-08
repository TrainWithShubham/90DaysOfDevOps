# Day 40 – My First GitHub Actions Workflow

Today I created my first GitHub Actions workflow and watched the pipeline run successfully in the cloud.

This was my first real CI/CD automation workflow using GitHub Actions.

---

# Repository Setup

I created a public repository:

github-actions-practice

Then I created the workflow folder:

.github/workflows/

Inside this folder I created:

hello.yml

---

# My First Workflow YAML

name: My First Workflow

on:
push:

jobs:
greet:
runs-on: ubuntu-latest

```
steps:
  - name: Checkout Repository
    uses: actions/checkout@v4

  - name: Print Hello Message
    run: echo "Hello from GitHub Actions!"
```

---

# What Happens Internally?

When I push code to GitHub:

1. GitHub detects code change
2. GitHub reads workflow YAML file
3. Runner machine starts automatically
4. Repository code downloads on runner
5. Steps execute one by one
6. Logs generate in Actions tab
7. Workflow status becomes success or failed

Everything runs automatically in cloud environment.

---

# Understanding Workflow Anatomy

## name:

Defines workflow name shown in Actions tab.

Example:

name: My First Workflow

---

## on:

Defines trigger event.

Example:

on:
push:

This means workflow runs whenever code is pushed.

---

## jobs:

Contains all jobs inside workflow.

Example:

jobs:
greet:

A workflow can contain multiple jobs.

---

## runs-on:

Defines operating system for runner machine.

Example:

runs-on: ubuntu-latest

GitHub creates Ubuntu virtual machine to run workflow.

---

## steps:

Defines sequence of actions executed inside job.

Example:

steps:

Steps execute one by one.

---

## uses:

Uses prebuilt GitHub Action.

Example:

uses: actions/checkout@v4

This downloads repository code to runner.

---

## run:

Executes shell command.

Example:

run: echo "Hello"

Used to run Linux commands or scripts.

---

## Step name

Helps identify step inside Actions logs.

Example:

- name: Print Hello Message

Makes workflow easier to read.

---

# Additional Workflow Steps

I later added more steps:

- print current date and time
- print branch name
- list repository files
- print runner operating system

This helped me understand runner environment better.

---

# Example Additional Commands

Print date:

date

Print branch name:

echo ${{ github.ref_name }}

List files:

ls -la

Print operating system:

uname -a

---

# What is Runner?

Runner is virtual machine created by GitHub to execute workflow.

Runner:

- downloads repository
- installs dependencies
- runs commands
- executes build and tests

After workflow completes, runner is destroyed automatically.

---

# What is actions/checkout?

actions/checkout downloads repository code onto runner machine.

Without checkout:

- runner cannot access project files

This is usually first step in most workflows.

---

# Failed Pipeline Understanding

I intentionally broke workflow using wrong command.

Example:

run: wrongcommand

Pipeline became red and failed.

I checked:

- error logs
- failed step
- command output

Then I fixed issue and pushed again.

---

# What I Learned From Failed Pipeline

Failed pipeline is useful because:

- it catches problems early
- prevents broken deployment
- helps debugging

Pipeline failure is part of CI/CD process.

---

# What I Learned

1. GitHub Actions automates workflows.
2. GitHub automatically creates runner machine.
3. Workflow steps execute sequentially.
4. Logs help debug pipeline issues.
5. CI/CD becomes real after watching pipeline run.

---

# Important Interview Concepts

## What happens after git push?

- GitHub detects event
- workflow starts
- runner machine launches
- repository downloads
- commands execute
- logs generate
- pipeline succeeds or fails

---

## Why GitHub Actions is useful?

- automates CI/CD
- reduces manual work
- improves consistency
- catches bugs early
- speeds up deployment process

---

# My Understanding

Today was important because CI/CD became practical instead of only theory.

Watching first green pipeline run helped me understand:

- automation
- workflow execution
- runner concept
- pipeline logs
- CI/CD process internally
