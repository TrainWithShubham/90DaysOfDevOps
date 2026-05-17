Day 44 – Secrets, Artifacts & Running Real Tests in CI

Create these files in your repo:

.github/workflows/secrets.yml
.github/workflows/artifacts.yml
.github/workflows/test-ci.yml
2026/day-44/day-44-secrets-artifacts.md
Task 1 – GitHub Secrets

Go to:

GitHub Repo → Settings → Secrets and variables → Actions

Create these secrets:

MY_SECRET_MESSAGE
DOCKER_USERNAME
DOCKER_TOKEN
Workflow: secrets.yml

Create:

.github/workflows/secrets.yml

name: Secrets Demo

on:
  push:

jobs:
  secrets-job:
    runs-on: ubuntu-latest

    steps:
      - name: Check Secret Exists
        run: |
          if [ -n "${{ secrets.MY_SECRET_MESSAGE }}" ]; then
            echo "The secret is set: true"
          else
            echo "The secret is missing"
          fi

      - name: Secret as Environment Variable
        env:
          MY_SECRET: ${{ secrets.MY_SECRET_MESSAGE }}
        run: |
          echo "Using secret securely in environment variable"

      - name: Try Printing Secret
        run: echo "${{ secrets.MY_SECRET_MESSAGE }}"
Important Observation

If you try to print the secret directly:

echo "${{ secrets.MY_SECRET_MESSAGE }}"

GitHub masks it like this:

***
Why You Should Never Print Secrets

Never print secrets because:

CI logs are visible to collaborators
Secrets may leak publicly
Attackers can misuse credentials
Tokens/passwords can compromise infrastructure

Secrets should always remain hidden.

Task 2 – Use Secrets as Environment Variables

Already done above using:

env:
  MY_SECRET: ${{ secrets.MY_SECRET_MESSAGE }}

This is the correct secure approach.

Task 3 – Upload Artifacts

Create:

.github/workflows/artifacts.yml

name: Artifact Demo

on:
  push:

jobs:
  create-artifact:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Create Report File
        run: |
          echo "CI Test Report" > report.txt
          echo "Pipeline executed successfully" >> report.txt

      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: test-report
          path: report.txt
Download Artifact

After workflow completes:

GitHub Actions → Workflow Run → Artifacts section

Download:

test-report.zip

Verify:

File exists
Contents are correct
Task 4 – Download Artifacts Between Jobs

Update artifacts.yml

name: Artifact Sharing Demo

on:
  push:

jobs:
  generate-file:
    runs-on: ubuntu-latest

    steps:
      - name: Create File
        run: echo "Hello from Job 1" > output.txt

      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: shared-file
          path: output.txt

  use-file:
    needs: generate-file
    runs-on: ubuntu-latest

    steps:
      - name: Download Artifact
        uses: actions/download-artifact@v4
        with:
          name: shared-file

      - name: Print File Content
        run: cat output.txt
Real-world Uses of Artifacts

Artifacts are used for:

test reports
build packages
Docker image metadata
deployment files
logs
sharing files between jobs

Example:
Build job creates an application package → Deploy job downloads and deploys it.

Task 5 – Run Real Tests in CI

Example Python Script:

Create:

app.py

print("Application is running successfully")

Create:

test_app.py

print("Running tests...")

x = 5
y = 5

assert x == y

print("Tests passed")
Workflow: test-ci.yml
name: Python Test CI

on:
  push:

jobs:
  run-tests:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.12'

      - name: Install Dependencies
        run: |
          python -m pip install --upgrade pip

      - name: Run Application
        run: python app.py

      - name: Run Tests
        run: python test_app.py
Break Pipeline Intentionally

Modify:

assert x == 10

Push again.

Pipeline becomes:

Red ❌
Failed in test step

Fix it back:

assert x == y

Push again → Green ✅

Task 6 – Caching

Update workflow:

- name: Cache Pip Dependencies
  uses: actions/cache@v4
  with:
    path: ~/.cache/pip
    key: ${{ runner.os }}-pip-${{ hashFiles('**/requirements.txt') }}
    restore-keys: |
      ${{ runner.os }}-pip-
What is Being Cached?

Cached:

downloaded Python packages
dependency files

Stored:

on GitHub-hosted cache storage

Benefit:

Faster workflow execution
Reduced dependency download time

First run:

slower

Second run:

faster due to cache reuse
day-44-secrets-artifacts.md
# Day 44 – Secrets, Artifacts & Running Real Tests in CI

# What I Learned About Secrets

GitHub Secrets securely stores sensitive values like:
- passwords
- tokens
- API keys
- Docker credentials

Secrets should never be hardcoded or printed in logs.

GitHub automatically masks secrets in workflow logs.

---

# Artifact Learning

Artifacts allow workflows to:
- save files
- share files between jobs
- download reports/logs later

Examples:
- test reports
- build outputs
- deployment packages

---

# Real Test Execution in CI

Today I:
- ran Python scripts inside GitHub Actions
- intentionally failed tests
- observed failed pipelines
- fixed errors and verified successful runs

This showed how CI catches issues automatically before deployment.

---

# Cache Learning

Caching stores dependencies between workflow runs.

Benefits:
- faster pipelines
- less downloading
- improved CI performance

---



CI/CD is finally starting to feel real now 🚀

#DevOps #GitHubActions #CICD #Python #Automation #Cloud #TrainWithShubham #90DaysOfDevOps
