# Day 48 – GitHub Actions Project: End-to-End CI/CD Pipeline

## Overview

This is the GitHub Actions capstone for the 90 Days of DevOps challenge. I built a complete, production-style CI/CD pipeline for my **Task Manager** Flask app using everything learned from Day 40 to Day 47 — reusable workflows, secrets, Docker builds, environments, and scheduled health checks.

**Repo:** https://github.com/SinghAkashdeep16/github_actions_practice  
**App folder:** `Task-Manager/`  
**Docker Hub:** https://hub.docker.com/r/akashjaura16/task-manager  

---

## Pipeline Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│  PR opened / updated (pull_request → main)                          │
│                                                                     │
│   pr-pipeline.yml                                                   │
│     └── call-build  ──►  reusable-build-test.yml                   │
│           └── Checkout → Setup Python → Install deps → pytest       │
│     └── pr-comment (needs: call-build)                              │
│           └── "PR checks passed for branch: <branch>"              │
│                                                                     │
│   ❌ No Docker build or push on PRs                                 │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│  Merge to main (push → main)                                        │
│                                                                     │
│   main-pipeline.yml                                                 │
│     └── call-build  ──►  reusable-build-test.yml                   │
│           └── Checkout → Setup Python → Install deps → pytest       │
│     └── call-docker (needs: call-build)  ──►  reusable-docker.yml  │
│           └── Checkout → Docker login → Build & Push image         │
│     └── deploy (needs: call-docker)                                 │
│           └── environment: production                               │
│           └── "Deploying image: <image_url> to production"         │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│  Every 12 hours + manual trigger                                    │
│                                                                     │
│   health-check.yml                                                  │
│     └── Checkout → Build image → Run container → curl :5000        │
│     └── Cleanup container (always)                                  │
│     └── Write $GITHUB_STEP_SUMMARY (always)                        │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Workflow Files

### 1. `reusable-build-test.yml`

```yaml
name: Reusable – Build and Test

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
    outputs:
      test_result:
        description: "Result of the test run: passed or failed"
        value: ${{ jobs.build.outputs.test_result }}

jobs:
  build:
    runs-on: ubuntu-latest
    outputs:
      test_result: ${{ steps.set_outputs.outputs.test_result }}
    defaults:
      run:
        working-directory: ./Task-Manager
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Python ${{ inputs.python_version }}
        uses: actions/setup-python@v4
        with:
          python-version: ${{ inputs.python_version }}

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt
          pip install pytest flask-sqlalchemy

      - name: Run tests
        if: ${{ inputs.run_tests }}
        run: pytest tests/ -v

      - name: Set output
        id: set_outputs
        if: always()
        run: |
          if [ "${{ job.status }}" = "success" ]; then
            echo "test_result=passed" >> $GITHUB_OUTPUT
          else
            echo "test_result=failed" >> $GITHUB_OUTPUT
          fi
```

---

### 2. `reusable-docker.yml`

```yaml
name: Reusable – Docker Build and Push

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
      DOCKER_USERNAME:
        required: true
      DOCKER_TOKEN:
        required: true
    outputs:
      image_url:
        description: "Full Docker image path including tag"
        value: ${{ jobs.build.outputs.image_url }}

jobs:
  build:
    runs-on: ubuntu-latest
    outputs:
      image_url: ${{ steps.set_outputs.outputs.image_url }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Log in to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_TOKEN }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: ./Task-Manager
          push: true
          tags: ${{ inputs.image_name }}:${{ inputs.tag }}

      - name: Set output
        id: set_outputs
        run: echo "image_url=${{ inputs.image_name }}:${{ inputs.tag }}" >> $GITHUB_OUTPUT
```

---

### 3. `pr-pipeline.yml`

```yaml
name: PR Pipeline

on:
  pull_request:
    branches:
      - main
    types: [opened, synchronize]

jobs:
  build:
    uses: ./.github/workflows/reusable-build-test.yml
    with:
      python_version: "3.10"
      run_tests: true
    secrets: inherit

  pr-comment:
    runs-on: ubuntu-latest
    needs: [build]
    steps:
      - name: Print PR summary
        run: echo "PR checks passed for branch: ${{ github.head_ref }}"
```

---

### 4. `main-pipeline.yml`

```yaml
name: Main Pipeline

on:
  push:
    branches:
      - main

jobs:
  call-build:
    uses: ./.github/workflows/reusable-build-test.yml
    with:
      python_version: "3.10"
      run_tests: true
    secrets: inherit

  call-docker:
    needs: [call-build]
    uses: ./.github/workflows/reusable-docker.yml
    with:
      image_name: "akashjaura16/task-manager"
      tag: "sha-${{ github.sha }}"
    secrets:
      DOCKER_USERNAME: ${{ secrets.DOCKER_USERNAME }}
      DOCKER_TOKEN: ${{ secrets.DOCKER_TOKEN }}

  deploy:
    needs: [call-docker]
    runs-on: ubuntu-latest
    environment: production
    steps:
      - name: Print deploy info
        run: |
          echo "Deploying image: ${{ needs.call-docker.outputs.image_url }} to production"
```

---

### 5. `health-check.yml`

```yaml
name: Health Check

on:
  workflow_dispatch:
  schedule:
    - cron: '0 */12 * * *'

jobs:
  health-check:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Build Task-Manager image locally
        run: docker build -t task-manager:health-check ./Task-Manager

      - name: Run Task-Manager container
        run: docker run -d -p 5000:5000 --name task-manager-test task-manager:health-check

      - name: Wait for container to be ready
        run: sleep 5

      - name: Health check
        run: |
          response=$(curl -o /dev/null -s -w "%{http_code}" http://localhost:5000)
          echo "HTTP response: $response"
          if [ "$response" -eq 200 ]; then
            echo "HEALTH_STATUS=PASSED" >> $GITHUB_ENV
            echo "Health check passed!"
          else
            echo "HEALTH_STATUS=FAILED" >> $GITHUB_ENV
            echo "Health check failed with status: $response"
            exit 1
          fi

      - name: Stop and remove container
        if: always()
        run: |
          docker stop task-manager-test
          docker rm task-manager-test

      - name: Create summary report
        if: always()
        run: |
          echo "## Health Check Report" >> $GITHUB_STEP_SUMMARY
          echo "- Image: task-manager:health-check" >> $GITHUB_STEP_SUMMARY
          echo "- Status: $HEALTH_STATUS" >> $GITHUB_STEP_SUMMARY
          echo "- Time: $(date)" >> $GITHUB_STEP_SUMMARY
```

---

## App: Task Manager

A Flask + SQLAlchemy task manager app with full CRUD operations.

**Stack:** Python 3.10 · Flask 2.2.5 · SQLAlchemy 2.0 · SQLite · Docker · Gunicorn

**Routes:**

| Method | Route | Description |
|--------|-------|-------------|
| GET/POST | `/` | List all tasks / create a new task |
| GET | `/delete/<id>` | Delete a task by ID |
| GET/POST | `/update/<id>` | Update a task by ID |

**Tests (`Task-Manager/tests/test_app.py`):**

| Test | Checks |
|------|--------|
| `test_homepage_loads` | GET / returns 200 |
| `test_create_task` | POST / redirects (302) after creating |
| `test_delete_nonexistent_task` | DELETE missing id returns 404 |
| `test_update_nonexistent_task` | UPDATE missing id returns 404 |

---

## Key Learnings & Bugs Fixed

- **Hyphen vs underscore in inputs** — GitHub Actions treats `python-version` and `python_version` as different names. Standardised everything to underscores across all workflow files.
- **Missing job-level + workflow-level outputs** — both are required for reusable workflow outputs to be readable by callers. Missing either one means the value is always empty string.
- **`uses:` and `run:` cannot mix in the same job** — a job either calls a reusable workflow (`uses:`) or defines its own steps, never both at the same level.
- **`defaults: run: working-directory`** — set at the job level so every run step automatically executes from `Task-Manager/` without repeating it per step.
- **`context: ./Task-Manager`** in Docker build — without this Docker looks for the Dockerfile at repo root and the build fails.
- **`if: always()` on cleanup and output steps** — ensures steps run even when a previous step fails, preventing dangling containers and empty output values.
- **Flask test client inside `app_context()`** — Flask 2.2.x has a known issue with calling `test_client()` inside an `app_context()` block. Fixed by creating the client at module level instead.

---

## What I'd Add Next

- **Slack notifications** — post to a channel when the pipeline passes or fails
- **Multi-environment** — add a `staging` environment before `production` with auto-deploy to staging and manual approval gate for production
- **Rollback workflow** — triggered manually, redeploys the previous image tag if production breaks
- **Trivy security scan** — scan the Docker image for CVEs after build (Day 49 preview)
- **Matrix builds** — test across Python 3.9, 3.10, 3.11 simultaneously

---




