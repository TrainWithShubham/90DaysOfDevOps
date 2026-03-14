# Day 46 – Reusable Workflows & Composite Actions

## Overview

In real DevOps environments, teams avoid repeating the same CI/CD logic in multiple repositories. Instead, they create **reusable workflows** and **composite actions** so the same logic can be reused across pipelines.

Today’s focus was on:
- Creating **Reusable Workflows**
- Calling workflows from other workflows using **workflow_call**
- Passing **inputs, secrets, and outputs**
- Creating a **Composite Action**
- Understanding the difference between **Reusable Workflows vs Composite Actions**

---

# Task 1 – Understanding `workflow_call`

### 1. What is a reusable workflow?

A **Reusable Workflow** is a workflow that can be defined once and reused by other workflows across the same repository or different repositories.

Instead of rewriting the same CI/CD logic multiple times, workflows can call reusable workflows like functions.

Example use cases:
- Standard build pipelines
- Docker image builds
- Deployment pipelines
- Security scans

---

### 2. What is `workflow_call` trigger?

`workflow_call` is a trigger used to allow a workflow to be called by another workflow.

Example:

```yaml
on:
  workflow_call:
```

This means the workflow **cannot run independently**.  
It will only run when another workflow calls it.

---

### 3. How is calling a reusable workflow different from using a regular action?

| Feature | Reusable Workflow | Regular Action |
|------|------|------|
Scope | Entire workflow/job | Individual step |
Contains jobs | Yes | No |
Usage location | jobs section | steps section |
Used for | Full pipelines | Small reusable tasks |

Example:

Reusable workflow:

```yaml
jobs:
  build:
    uses: ./.github/workflows/reusable-build.yml
```

Regular action:

```yaml
steps:
  - uses: actions/checkout@v4
```

---

### 4. Where must a reusable workflow file live?

Reusable workflows must be placed inside:

```
.github/workflows/
```

Example:

```
.github/workflows/reusable-build.yml
```

---

# Task 2 – Create a Reusable Workflow

File:

```
.github/workflows/reusable-build.yml
```

```yaml
name: Reusable Build Workflow

on:
  workflow_call:
    inputs:
      app_name:
        required: true
        type: string
      environment:
        required: false
        type: string
        default: staging
    secrets:
      docker_token:
        required: true
    outputs:
      build_version:
        description: Generated build version
        value: ${{ jobs.build.outputs.build_version }}

jobs:
  build:
    runs-on: ubuntu-latest

    outputs:
      build_version: ${{ steps.version.outputs.build_version }}

    steps:

      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Print Build Info
        run: echo "Building ${{ inputs.app_name }} for ${{ inputs.environment }}"

      - name: Verify Docker Token Exists
        env:
          DOCKER_TOKEN: ${{ secrets.docker_token }}
        run: |
          if [ -n "$DOCKER_TOKEN" ]; then
            echo "Docker token is set: true"
          else
            echo "Docker token is missing"
            exit 1
          fi

      - name: Generate Build Version
        id: version
        run: |
          short_sha=${GITHUB_SHA::7}
          version="v1.0-$short_sha"
          echo "build_version=$version" >> $GITHUB_OUTPUT
```

---

# Task 3 – Caller Workflow

This workflow calls the reusable workflow.

File:

```
.github/workflows/call-build.yml
```

```yaml
name: Call Reusable Workflow

on:
  push:
    branches:
      - main

jobs:

  build:
    uses: ./.github/workflows/reusable-build.yml
    with:
      app_name: "my-web-app"
      environment: "production"
    secrets:
      docker_token: ${{ secrets.DOCKER_TOKEN }}

  print_version:
    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Print Build Version
        run: echo "Build Version = ${{ needs.build.outputs.build_version }}"
```

---

# Task 4 – Reusable Workflow Outputs

Outputs allow workflows to pass data between jobs.

Output flow:

```
Step Output → Job Output → Workflow Output → Caller Workflow
```

Example output generated:

```
v1.0-a3f91c2
```

Caller workflow accesses it using:

```yaml
${{ needs.build.outputs.build_version }}
```

---

# Task 5 – Composite Action

Composite actions allow us to bundle multiple steps into a reusable action.

Location:

```
.github/actions/setup-and-greet/action.yml
```

```yaml
name: Setup and Greet
description: Composite action to greet users

inputs:
  name:
    description: Name of the person
    required: true

  language:
    description: Greeting language
    required: false
    default: EN

outputs:
  greeted:
    description: Greeting completed
    value: ${{ steps.greet.outputs.greeted }}

runs:
  using: composite

  steps:

    - name: Print greeting
      shell: bash
      run: |
        if [ "${{ inputs.language }}" = "HI" ]; then
          echo "Namaste!! Kaise Ho ${{ inputs.name }}"
        else
          echo "Hello ${{ inputs.name }}, How are you?"
        fi

    - name: Print current date and runner OS
      shell: bash
      run: |
        echo "Current Date - $(date)"
        echo "Runner OS - $(uname)"

    - name: Set greeted output
      id: greet
      shell: bash
      run: |
        echo "greeted=true" >> $GITHUB_OUTPUT
```

---

# Workflow to Use Composite Action

Example workflow:

```yaml
name: Greetings Workflow

on:
  workflow_dispatch:

jobs:
  greetings:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Run Greeting Action
        uses: ./.github/actions/setup-and-greet
        with:
          name: Shiv
          language: HI
```

Expected output:

```
Namaste!! Kaise Ho Shiv
Current Date - <date>
Runner OS - Linux
```

---

# Task 6 – Reusable Workflow vs Composite Action

| Feature | Reusable Workflow | Composite Action |
|------|------|------|
Triggered by | `workflow_call` | `uses:` inside steps |
Can contain jobs? | Yes | No |
Can contain multiple steps? | Yes | Yes |
Lives where? | `.github/workflows/` | `.github/actions/<action-name>/` |
Can accept secrets directly? | Yes | No (passed through workflow) |
Best for | Full CI/CD pipelines | Reusable step logic |

---

# Repository Structure

```
.github
 ├ workflows
 │   ├ reusable-build.yml
 │   ├ call-build.yml
 │   └ greetings.yml
 │
 └ actions
     └ setup-and-greet
         └ action.yml
```

---

# Key Concepts Learned

### Reusable Workflows
- Define once
- Reuse across pipelines
- Triggered using `workflow_call`

### Inputs
Passed using:

```yaml
with:
```

### Secrets
Passed using:

```yaml
secrets:
```

### Outputs
Used to pass data between jobs.

```yaml
$GITHUB_OUTPUT
```

### Composite Actions
Reusable step groups used inside workflows.

---

# Real DevOps Use Cases

Reusable workflows are used for:

- Standard build pipelines
- Docker image build and push
- Infrastructure deployments
- Security scanning pipelines

Composite actions are used for:

- Environment setup
- Installing dependencies
- Standard CI validation steps

---

# Conclusion

Today we learned how to reduce duplication in CI/CD pipelines using:

- Reusable workflows
- Workflow outputs
- Composite actions

These techniques help DevOps teams maintain **clean, reusable, and scalable pipelines**.

---
