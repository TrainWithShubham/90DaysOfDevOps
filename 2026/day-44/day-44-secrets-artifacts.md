# Day 44 – Secrets, Artifacts & Running Real Tests in CI

## Overview
Today we learned how to make CI pipelines perform real tasks like:

- Storing sensitive values using **GitHub Secrets**
- Passing secrets securely to workflow steps
- Saving files using **Artifacts**
- Sharing artifacts between jobs
- Running **real scripts/tests in CI**
- Speeding up workflows using **Cache**

---

# Task 1 – GitHub Secrets

## Objective
Store sensitive information securely and use it in workflows without exposing the value.

## Steps

1. Go to

Repository → Settings → Secrets and variables → Actions

2. Create a secret

MY_SECRET_MESSAGE

3. Access the secret in workflow

Example:

${{ secrets.MY_SECRET_MESSAGE }}

4. Check if the secret exists without printing it

Example:

if [ -n "${{ secrets.MY_SECRET_MESSAGE }}" ]; then
 echo "The secret is set: true"
else
 echo "The secret is set: false"
fi

## Experiment

If we try to print the secret

echo ${{ secrets.MY_SECRET_MESSAGE }}

GitHub shows

***

## Screenshot

Add screenshot of the **secret created in GitHub settings**

<img width="806" height="533" alt="image" src="https://github.com/user-attachments/assets/1b1d924c-4cc1-481f-a073-71d0eb0f3302" />


---

## Why Secrets Should Never Be Printed

Reasons:

- CI logs may be visible to multiple users
- Logs can be stored for a long time
- Secrets may leak accidentally
- Security best practice is to never expose credentials

GitHub masks secret values automatically.

---

# Task 2 – Using Secrets as Environment Variables

## Objective
Use secrets in commands without hardcoding values.

## Secrets Created

APP_USERNAME  
APP_TOKEN  

Example workflow usage

env:
 USERNAME: ${{ secrets.APP_USERNAME }}
 TOKEN: ${{ secrets.APP_TOKEN }}

Use in shell command

echo $USERNAME
echo $TOKEN

GitHub will mask the output as

***

## Screenshot

Add screenshot of workflow logs showing **masked secret output**

<img width="1361" height="509" alt="image" src="https://github.com/user-attachments/assets/13783973-1a93-41f1-b657-aef0294e01ad" />

---

# Task 3 – Upload Artifacts

## Objective
Save files generated during a workflow.

Artifacts can store:

- test reports
- build outputs
- logs
- coverage reports

## Example Step

Generate a file

mkdir reports
echo "Automation Test Report - Build Successful" > reports/test-report.txt

Upload artifact

uses: actions/upload-artifact@v4
with:
 name: test-report
 path: reports/test-report.txt

## Verification

After workflow runs

GitHub → Actions → Workflow Run → Artifacts

Download the artifact and verify the file exists.

## Screenshot

Add screenshot of artifact visible in GitHub Actions

<img width="1332" height="453" alt="image" src="https://github.com/user-attachments/assets/322e1f74-9b6f-45d4-99b4-0002be0b5216" />

Add screenshot after downloading artifact

<img width="1347" height="692" alt="image" src="https://github.com/user-attachments/assets/1614e7b5-ca58-49c1-aa90-25b0621008d3" />

---

# Task 4 – Download Artifacts Between Jobs

## Objective
Share files between jobs.

Important:

Each job runs on a **separate runner**, so files are not shared automatically.

Artifacts allow file transfer between jobs.

## Workflow Logic

Job 1
Generate file  
Upload artifact

Job 2
Download artifact  
Use the file

## Upload

uses: actions/upload-artifact@v4

## Download

uses: actions/download-artifact@v4

Example command

cat test-report.txt

## Screenshot

Add screenshot of logs showing **artifact downloaded and file printed**

<img width="1338" height="612" alt="image" src="https://github.com/user-attachments/assets/5d1f8d14-65be-44af-b33d-f20de8bfbe06" />


---

# Task 5 – Run Real Tests in CI

## Objective
Run actual scripts in CI pipeline.

## Steps

Add script to repo

scripts/test-script.sh

Example script

#!/bin/bash

echo "Running CI test script..."
echo "All checks passed"

## Workflow Steps

Checkout code

uses: actions/checkout@v4

Run script

bash scripts/test-script.sh

## Pipeline Result

If script succeeds

exit code = 0

Pipeline → SUCCESS

If script fails

exit code ≠ 0

Pipeline → FAILED

## Test the Pipeline

Break the script

exit 1

Pipeline becomes RED

Fix the script

Pipeline becomes GREEN

This confirms CI detects failures correctly.

## Screenshots

Add screenshot of **failed pipeline**

<img width="1360" height="542" alt="image" src="https://github.com/user-attachments/assets/e3f650be-643d-45af-babd-d20280711550" />

Add screenshot of **successful pipeline**

<img width="1326" height="458" alt="image" src="https://github.com/user-attachments/assets/3af8a1d6-65b6-45c4-abc2-0e0d81945c06" />

---

# Task 6 – Caching

## Objective
Speed up workflows by storing dependencies between runs.

Without caching

Run 1 → install dependencies  
Run 2 → install again  
Run 3 → install again

With caching

Run 1 → install dependencies → cache saved  
Run 2 → cache restored → faster run  
Run 3 → cache restored

## Example Cache Step

uses: actions/cache@v4
with:
 path: ~/demo-cache
 key: demo-cache

## First Run

Cache not found

Directory created

Cache saved

## Second Run

Cache restored

Directory already exists

## What Is Cached

Directory example

~/demo-cache

Containing files created during workflow.

## Where Cache Is Stored

Cache is stored in **GitHub cache storage**, not on the runner.

Because runners are temporary machines.

## Screenshot

Add screenshot showing **cache restored message**

<img width="956" height="268" alt="image" src="https://github.com/user-attachments/assets/92bf96d6-f87d-4e0e-9e83-2bc50ae55808" />


---

# Key Learnings

Secrets
Secure way to store credentials in GitHub.

Environment Variables
Safely pass secrets to workflow steps.

Artifacts
Store files generated during workflows.

Artifact Sharing
Transfer files between jobs.

CI Testing
Run scripts/tests automatically in pipelines.

Caching
Reuse dependencies to make pipelines faster.

---

# Real CI Pipeline Flow

Push code
↓
CI pipeline starts
↓
Checkout code
↓
Restore cache
↓
Install dependencies
↓
Run tests
↓
Upload artifacts
↓
Deploy application

---
