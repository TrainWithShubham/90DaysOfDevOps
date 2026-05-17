Day 40 – Your First GitHub Actions Workflow

Create these files:

.github/workflows/hello.yml
2026/day-40/day-40-first-workflow.md
Step 1 – Create Repository

Go to GitHub and create a new public repository:

github-actions-practice

Clone it locally:

git clone https://github.com/YOUR_USERNAME/github-actions-practice.git

cd github-actions-practice

Create workflow folders:

mkdir -p .github/workflows
Step 2 – First Workflow File

Create:

.github/workflows/hello.yml

name: First GitHub Actions Workflow

on:
  push:

jobs:
  greet:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Print Hello Message
        run: echo "Hello from GitHub Actions!"

Push the code:

git add .
git commit -m "Added first GitHub Actions workflow"
git push origin main

Now open:

GitHub Repo → Actions Tab

You should see a green successful workflow run ✅

Step 3 – Updated Workflow with More Steps

Update hello.yml

name: First GitHub Actions Workflow

on:
  push:

jobs:
  greet:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Print Hello Message
        run: echo "Hello from GitHub Actions!"

      - name: Print Date and Time
        run: date

      - name: Print Branch Name
        run: echo "Branch Name: ${{ github.ref_name }}"

      - name: List Files
        run: ls -la

      - name: Print Runner OS
        run: echo "Runner OS: $RUNNER_OS"

Push again:

git add .
git commit -m "Added more workflow steps"
git push origin main
Step 4 – Break the Pipeline On Purpose

Add this step temporarily:

      - name: Fail Intentionally
        run: exit 1

OR

      - name: Wrong Command
        run: somewrongcommand

Push again and check the Actions tab.

You will see:

Red ❌ workflow
Failed step highlighted
Error logs in detail

Fix the error and push again.

day-40-first-workflow.md
# Day 40 – First GitHub Actions Workflow

# Workflow YAML

```yaml
name: First GitHub Actions Workflow

on:
  push:

jobs:
  greet:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Print Hello Message
        run: echo "Hello from GitHub Actions!"

      - name: Print Date and Time
        run: date

      - name: Print Branch Name
        run: echo "Branch Name: ${{ github.ref_name }}"

      - name: List Files
        run: ls -la

      - name: Print Runner OS
        run: echo "Runner OS: $RUNNER_OS"
Workflow Anatomy
on:

Defines what event triggers the workflow.

Example:

push
pull_request
workflow_dispatch
jobs:

Defines the tasks the workflow will execute.

A workflow can have multiple jobs.

runs-on:

Defines which machine/environment will run the job.

Example:

ubuntu-latest
windows-latest
macos-latest
steps:

A sequence of actions executed inside a job.

Steps run one after another.

uses:

Used to reuse existing GitHub Actions.

Example:
actions/checkout@v4 downloads repository code to the runner.

run:

Executes shell commands on the runner machine.

Example:

echo "Hello"
name:

Gives readable names to workflows, jobs, or steps.

Makes logs easier to understand.

Failed Pipeline Observation

When a pipeline fails:

The workflow turns red
Failed steps are highlighted
Logs show exact errors
Remaining steps usually stop executing

Reading logs helps identify:

syntax errors
missing files
wrong commands
failed tests

A failed pipeline prevents broken code from moving forward.

Key Learnings
GitHub Actions automates CI/CD workflows
Every push can trigger automation
Pipelines run on cloud runners
Logs are very important for debugging
CI/CD catches problems early

---

For LinkedIn:

:::writing{variant="social_post" id="48216"}
🚀 Day 40 of #90DaysOfDevOps

Today I created my first GitHub Actions workflow and watched my CI pipeline run successfully in the cloud ✅

What I learned:
🔹 Workflow triggers
🔹 Jobs & steps
🔹 GitHub-hosted runners
🔹 Built-in GitHub variables
🔹 Reading pipeline logs
🔹 Understanding failed pipelines

Built a workflow that:
✔ Prints hello message
✔ Shows branch name
✔ Displays date/time
✔ Lists repository files
✔ Detects runner OS

Also intentionally broke the pipeline to understand how CI failures work 🔥

#DevOps #GitHubActions #CICD #Automation #Cloud #TrainWithShubham #90DaysOfDevOps
:::
