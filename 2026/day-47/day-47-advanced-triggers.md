# Day 47 – Advanced Triggers: PR Events, Cron Schedules & Event-Driven Pipelines

## Overview

In this exercise we explored **advanced workflow triggers in GitHub Actions**.  
Earlier workflows were triggered mainly by simple events like push or pull_request.  
However GitHub Actions supports many other event types that allow us to create **event-driven CI/CD pipelines**.

The goal of this task was to understand:

- Pull Request lifecycle events
- PR validation gates
- Scheduled workflows using cron
- Path and branch based workflow triggers
- Chaining workflows using workflow_run
- Triggering workflows from external systems using repository_dispatch

These features allow building **more intelligent pipelines that run only when needed**.

---

# Task 1 – Pull Request Lifecycle Events

## Objective

Create a workflow that reacts to different stages of a Pull Request lifecycle.

Workflow file created:

.github/workflows/pr-lifecycle.yml

## Trigger

The workflow was configured to listen to specific PR events:

opened  
synchronize  
reopened  
closed  

Meaning:

opened → when PR is created  
synchronize → when new commits are pushed to the PR  
reopened → when a closed PR is reopened  
closed → when PR is closed or merged

## Data extracted from PR

The workflow printed useful PR metadata using GitHub context variables.

github.event.action → shows which PR action triggered the workflow  
github.event.pull_request.title → title of the pull request  
github.event.pull_request.user.login → PR author  
github.event.pull_request.head.ref → source branch  
github.event.pull_request.base.ref → target branch

## Detecting Merge

A conditional step runs only when the PR is merged.

Condition used:

github.event.pull_request.merged == true

This ensures the step executes only when the PR is actually merged and not simply closed.

## Verification

Testing steps:

1. Create a pull request
2. Push new commits to the PR
3. Reopen PR if closed
4. Merge the PR

The workflow runs for each lifecycle event.

---

# Task 2 – PR Validation Workflow

## Objective

Create a workflow that acts as a **PR gate** and validates pull requests before they are merged.

Workflow file:

.github/workflows/pr-checks.yml

Trigger used:

pull_request → main branch

## Job 1 – File Size Validation

Purpose:

Prevent accidentally committing large files.

Steps performed:

1. Checkout repository
2. Identify changed files in the PR
3. Calculate file size
4. Fail workflow if file size is greater than 1MB

Logic:

If file_size > 1MB  
Fail workflow

This protects repositories from large artifacts and binaries.

---

## Job 2 – Branch Naming Validation

Purpose:

Ensure developers follow proper branch naming conventions.

Branch name read using:

github.head_ref

Allowed branch patterns:

feature/*  
fix/*  
docs/*

Examples:

feature/login → valid  
fix/payment-bug → valid  
docs/update-readme → valid  
testbranch → invalid

If the branch name does not follow the pattern, the workflow fails.

---

## Job 3 – PR Description Validation

Purpose:

Encourage developers to write meaningful PR descriptions.

PR description read using:

github.event.pull_request.body

Logic:

If PR body is empty  
Print warning message

The workflow does not fail but warns reviewers.

---

## Verification

To test the workflow:

1. Create a branch with incorrect name
2. Open a PR
3. Observe workflow failure due to branch naming violation

---

# Task 3 – Scheduled Workflows Using Cron

## Objective

Run workflows automatically at scheduled intervals.

Workflow file:

.github/workflows/scheduled-tasks.yml

## Trigger

Two cron schedules were added.

Schedule 1

30 2 * * 1

Meaning:

Every Monday at 02:30 UTC

Schedule 2

0 */6 * * *

Meaning:

Every 6 hours

## Manual Trigger

workflow_dispatch was added so the workflow can also be run manually.

This allows testing without waiting for the schedule.

---

## Printing Triggered Schedule

The workflow prints which cron schedule triggered it using:

github.event.schedule

Example output:

Schedule Triggered - 0 */6 * * *

---

## Health Check Step

A health check was implemented using curl.

Steps:

1. Send HTTP request to a URL
2. Capture HTTP response code
3. Validate service health

Logic:

status_code = curl response code

If status_code equals 200  
Service is healthy

Otherwise  
Fail the workflow

---

## Cron Expressions

### Every weekday at 9 AM IST

IST is UTC +5:30

9:00 IST equals 3:30 UTC

Cron expression:

30 3 * * 1-5

---

### First day of every month at midnight

Cron expression:

0 0 1 * *

---

## Why Scheduled Workflows May Be Delayed

GitHub mentions scheduled workflows may not run exactly on time because:

1. Scheduled workflows run only on the default branch
2. Runner infrastructure may experience heavy load
3. GitHub schedules cron jobs on a best-effort basis
4. Inactive repositories may have delayed execution

---

# Task 4 – Path and Branch Filters

## Objective

Run workflows only when relevant files change.

Workflow file:

.github/workflows/smart-triggers.yml

## Paths Filter

Paths filter ensures workflow runs only when specific directories change.

Configured paths:

src/**  
app/**

Meaning:

Workflow runs only when files inside src or app directories change.

Example behavior:

src/main.py → workflow runs  
app/server.js → workflow runs  
README.md → workflow skipped  
docs/setup.md → workflow skipped

---

## Paths Ignore

Second workflow used paths-ignore to skip documentation updates.

Ignored files:

*.md  
docs/**

Important rule:

Workflow is skipped only if ALL changed files match ignore patterns.

Example:

README.md → skipped  
docs/setup.md → skipped  
src/app.py → workflow runs

---

## Branch Filters

Workflows were restricted to specific branches.

main  
release/*

Example behavior:

Push to main → workflow runs  
Push to release/v1 → workflow runs  
Push to feature/login → workflow skipped

---

## When to Use Paths vs Paths Ignore

Use paths when:

Workflow should run only for specific directories.

Example:

Backend build runs only when backend code changes.

Use paths-ignore when:

Workflow should run normally but skip trivial changes.

Example:

Skip CI pipeline when only documentation changes.

---

# Task 5 – workflow_run (Workflow Chaining)

## Objective

Trigger a workflow after another workflow finishes.

Two workflows were created.

Workflow 1

tests.yml

Runs tests on every push.

Workflow 2

deploy-after-tests.yml

Runs only after tests workflow completes.

Trigger used:

workflow_run

Configuration:

workflow_run listens to completion of the test workflow.

---

## Conditional Deployment

Deployment should happen only if tests succeed.

Condition checked:

github.event.workflow_run.conclusion equals success

Logic:

If tests succeed  
Start deployment

If tests fail  
Print warning and stop workflow

---

## Execution Flow

Push code  
→ Test workflow runs  
→ Test workflow completes  
→ Deploy workflow triggers  
→ Deploy happens only if tests succeeded

This pattern ensures **deployment happens only after successful tests**.

---

## workflow_run vs workflow_call

workflow_run

Triggers when another workflow completes.

Used for workflow chaining.

workflow_call

Allows reusable workflows that can be called by other workflows.

Used for modular pipeline design.

---

# Task 6 – repository_dispatch (External Event Triggers)

## Objective

Trigger workflows from external systems.

Workflow file:

.github/workflows/external-trigger.yml

## Trigger

repository_dispatch

Event type used:

deploy-request

Meaning:

Workflow runs only when an external system sends a deploy-request event.

---

## Client Payload

External systems can send additional data with the event.

Example payload:

environment = production

The workflow reads it using:

github.event.client_payload.environment

Example output:

production

---

## Triggering Workflow Using GitHub CLI

An external event can be sent using GitHub CLI.

API request sends:

event_type = deploy-request  
client_payload.environment = production

GitHub receives the event and triggers the workflow.

---

## Real World Use Cases

repository_dispatch is used when an external system must trigger a GitHub workflow.

Examples:

Slack deployment bot  
Monitoring systems  
Release automation tools  
CI orchestrators  
Infrastructure automation

Example scenario:

Developer runs command in Slack:

/deploy production

Slack bot calls GitHub API which triggers the deployment workflow.

---

# Key Concepts Learned

Pull Request lifecycle events  
PR validation gates  
Scheduled cron workflows  
Path and branch filters  
Workflow chaining using workflow_run  
External workflow triggers using repository_dispatch

---

# Conclusion

Advanced GitHub Actions triggers allow building **event-driven automation pipelines**.

They help:

Run workflows only when needed  
Improve CI/CD efficiency  
Automate testing and deployments  
Integrate GitHub with external systems

These capabilities make GitHub Actions a **powerful automation platform for DevOps pipelines**.
