# Day 41 – Triggers & Matrix Builds

## Overview
Today I learned different ways to trigger GitHub Actions workflows and how to run jobs across multiple environments using matrix builds. I practiced pull request triggers, scheduled workflows using cron, manual workflow execution, and matrix builds with different Python versions and operating systems.

---

# Task 1 – Trigger on Pull Request

## Goal
Trigger a workflow whenever a pull request is opened or updated against the **main** branch.

## Workflow File
.github/workflows/pr-check.yml


```yaml
name: PR Check

on:
  pull_request:
    branches: [main]

jobs:
  pr-check:
    runs-on: ubuntu-latest
    steps:
      - name: Print PR branch
        run: echo "PR check running for branch: ${{ github.head_ref }}"
```

## What I Did
1. Created a new branch locally.
2. Added a commit and pushed it to GitHub.
3. Opened a Pull Request against the main branch.
4. The workflow triggered automatically.

## Verification
The workflow appeared:
- In the **Actions tab**
- On the **Pull Request page under checks**

---

# Task 2 – Scheduled Trigger

## Goal
Run a workflow automatically using cron scheduling.

Example schedule to run workflow **every day at midnight UTC**.

```yaml
on:
  schedule:
    - cron: '0 0 * * *'
```

## Cron Expression Explanation

Field order in cron:

Minute Hour Day-of-Month Month Day-of-Week

Expression used:

0 0 * * *

Meaning:
- Minute = 0
- Hour = 0
- Every day
- Every month
- Every weekday

So the workflow runs **daily at 00:00 UTC**.

## Cron Expression for Every Monday at 9 AM

0 9 * * 1

Explanation:

- Minute = 0
- Hour = 9
- Day-of-Month = *
- Month = *
- Day-of-Week = 1 (Monday)

---

# Task 3 – Manual Trigger

## Goal
Run a workflow manually and pass input parameters.

Workflow file:

.github/workflows/manual.yml

```yaml
name: Manual Workflow

on:
  workflow_dispatch:
    inputs:
      environment:
        description: "Enter environment name"
        required: true

jobs:
  manual-job:
    runs-on: ubuntu-latest
    steps:
      - name: Print selected environment
        run: echo "Environment selected: ${{ github.event.inputs.environment }}"
```

## What I Did

1. Created the workflow using `workflow_dispatch`.
2. Added an input field called **environment**.
3. Went to GitHub → **Actions tab**.
4. Selected the workflow and clicked **Run Workflow**.
5. Entered environment values such as:
   - staging
   - production

## Verification

The workflow printed the selected input value.

Example output:

Environment selected: staging

---

# Task 4 – Matrix Builds

## Goal
Run the same job across multiple Python versions.

Workflow file:

.github/workflows/matrix.yml

```yaml
name: Matrix Strategy Practice

on:
  workflow_dispatch:

jobs:
  check_python:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ["3.10", "3.11", "3.12"]
    steps:
      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}

      - name: Check Python Version
        run: python --version
```

## Result

GitHub created **3 parallel jobs**.

Python versions tested:

- Python 3.10
- Python 3.11
- Python 3.12

Each job installed the Python version and printed it in the logs.

---

# Extending Matrix with Operating Systems

I extended the matrix to include **two operating systems**:

- ubuntu-latest
- windows-latest

Matrix logic:

Python versions = 3  
Operating systems = 2  

Total jobs:

3 × 2 = 6 jobs

Example job combinations:

ubuntu + python 3.10  
ubuntu + python 3.11  
ubuntu + python 3.12  
windows + python 3.10  
windows + python 3.11  
windows + python 3.12  

GitHub executed **6 jobs in parallel**.

---

# Task 5 – Exclude & Fail-Fast

## Excluding a Matrix Combination

Sometimes a specific matrix combination should not run.

Example: exclude **Python 3.10 on Windows**.

```yaml
strategy:
  fail-fast: false
  matrix:
    python-version: ["3.10", "3.11", "3.12", "3.13"]
    os: [ubuntu-latest, windows-latest]

    exclude:
      - python-version: "3.10"
        os: windows-latest
```

## Result

Matrix combinations originally:

4 Python versions × 2 OS = 8 jobs

After exclusion:

8 − 1 = 7 jobs

Removed combination:

windows + python 3.10

---

# Understanding Fail-Fast

## Default Behavior – fail-fast: true

If any job in the matrix fails, GitHub **cancels all remaining jobs**.

Example scenario:

ubuntu + python 3.11 → failed  
Other matrix jobs → cancelled

Purpose:
- Saves CI resources
- Stops unnecessary jobs

---

## Behavior with fail-fast: false

If one job fails, **other matrix jobs continue running**.

Example:

ubuntu + python 3.11 → failed  
ubuntu + python 3.12 → success  
windows + python 3.12 → success  

This allows seeing results from **all environments**.

---

# Key Concepts Learned

- GitHub Actions workflows can be triggered using:
  - Pull Request events
  - Scheduled cron jobs
  - Manual triggers
- Matrix builds allow running jobs across multiple environments simultaneously.
- Matrix strategies are useful for testing different:
  - Language versions
  - Operating systems
- `exclude` removes specific matrix combinations.
- `fail-fast` controls whether other jobs stop when one job fails.

---

# Conclusion

Today I practiced multiple GitHub Actions triggers and matrix builds. I learned how CI pipelines can run the same job across multiple environments simultaneously and how to control matrix behavior using exclude rules and fail-fast settings. These concepts are important when designing real-world CI/CD pipelines.

---
