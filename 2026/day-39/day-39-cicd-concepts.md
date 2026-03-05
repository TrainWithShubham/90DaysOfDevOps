# Day 39 – What is CI/CD?

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham

---

# 1️⃣ The Problem Before CI/CD

Imagine:

- 5 developers
- Same GitHub repository
- Manual deployment to production

## What Can Go Wrong?

- Merge conflicts
- Undetected bugs reaching production
- Human errors during deployment
- Environment mismatch (Dev ≠ Staging ≠ Prod)
- No deployment history or traceability
- Overwriting someone else's changes

---

## What Does “It Works on My Machine” Mean?

It means:

The application works in the developer’s local environment  
but fails in staging or production.

### Why?

- Different OS versions
- Different dependency versions
- Missing environment variables
- Different database versions
- Hidden local configurations

This is dangerous because production servers are clean and strict environments.

---

## Manual Deployment Limitations

Manual deployment involves:

- Logging into server
- Pulling code
- Installing dependencies
- Building application
- Restarting services
- Testing manually

Safe manual deployments per day:
- Usually 1–3 times

Beyond that:
- Risk increases
- Mistakes increase
- Rollbacks become difficult

---

# 2️⃣ CI vs CD vs Continuous Deployment

## 🔹 Continuous Integration (CI)

Continuous Integration is the practice where developers frequently merge code into a shared repository and automated builds and tests run on every change to detect issues early.

### What It Does:
- Runs on every push / PR
- Builds application
- Runs automated tests
- Fails fast if something breaks

### Real-World Example:
A developer pushes code → GitHub Actions runs tests → If tests fail, merge is blocked.

---

## 🔹 Continuous Delivery

Continuous Delivery means that after CI passes, the application is automatically prepared and ready for deployment, but deployment to production requires manual approval.

### What It Does:
- Automatically builds and packages app
- Deploys to staging
- Waits for human approval for production

### Real-World Example:
CI passes → Docker image built → Deployed to staging → Manager approves → Production deploy.

---

## 🔹 Continuous Deployment

Continuous Deployment means every change that passes CI is automatically deployed to production without human intervention.

### What It Does:
- No manual approval
- Fully automated release

### Real-World Example:
Code pushed → Tests pass → Automatically deployed to production.

---

## 🔥 Key Difference

| Continuous Delivery | Continuous Deployment |
|--------------------|----------------------|
| Manual approval required | No approval |
| Human decides release time | Fully automatic |
| Common in banking & enterprises | Used by high-maturity tech companies |

Banking systems prefer Continuous Delivery due to:
- Sensitive data
- Compliance requirements
- Audit needs
- Risk control

---

# 3️⃣ Pipeline Anatomy

## Trigger
The event that starts the pipeline.
Examples:
- Push to main branch
- Pull request
- Scheduled cron
- Manual trigger

---

## Stage
A logical phase in the pipeline.
Examples:
- Build
- Test
- Dockerize
- Deploy

---

## Job
A collection of steps that run on the same runner inside a stage.

Example:
Stage: Test  
- Job 1: Unit Tests  
- Job 2: Integration Tests  

---

## Step
A single command or action inside a job.

Example:
- Checkout code
- Install dependencies
- Run tests

---

## Runner
The machine (virtual or physical) that executes the job.

Examples:
- ubuntu-latest
- Self-hosted runner

---

## Artifact
A meaningful output produced by a job that can be stored and reused later.

Examples:
- Compiled JAR file
- Docker image
- Test report
- Security report

Artifact = Reusable pipeline output  
Side effect (Slack message, GitHub comment) ≠ Artifact

---

# 4️⃣ CI/CD Pipeline Diagram

Scenario:
Developer pushes code → App tested → Docker image built → Deployed to staging

```
            Developer Pushes Code
                    │
                    ▼
         ┌─────────────────────┐
         │     Trigger:        │
         │ Push to main branch │
         └─────────────────────┘
                    │
                    ▼
         ┌─────────────────────┐
         │     Stage 1: Build  │
         │ - Install deps      │
         │ - Compile app       │
         └─────────────────────┘
                    │
                    ▼
         ┌─────────────────────┐
         │     Stage 2: Test   │
         │ - Run unit tests    │
         │ - Fail if broken    │
         └─────────────────────┘
                    │
                    ▼
         ┌─────────────────────┐
         │  Stage 3: Docker    │
         │ - Build image       │
         │ - Tag image         │
         └─────────────────────┘
                    │
                    ▼
         ┌─────────────────────┐
         │ Stage 4: Deploy     │
         │ - Pull image        │
         │ - Restart container │
         └─────────────────────┘
                    │
                    ▼
               Staging Server
```

---

# 5️⃣ Real GitHub Workflow Analysis (FastAPI)

Workflow Name: Add to Project

### Trigger:
- pull_request_target
- issues (opened, reopened)

### Jobs:
- 1 job → add-to-project

### What It Does:
Automatically adds new Issues or Pull Requests to a GitHub Project board.

### Important Insight:
Not all GitHub workflows are CI/CD pipelines.

This workflow:
- Does not build code
- Does not run tests
- Does not deploy
- Does not produce artifacts

It is repository automation, not CI/CD.

---

# 🔥 Final DevOps Mindset

- CI/CD is a practice, not just a tool.
- Pipeline failure is success if it prevents broken code from reaching production.
- Automation reduces human error.
- Small frequent deployments reduce risk.
- Artifact = reusable output.
- Side effect ≠ artifact.

---

# 📌 Personal Learning Reflection

Today I understood:

- Why CI/CD exists
- Integration problems before CI
- Difference between Delivery and Deployment
- Pipeline anatomy clearly
- What artifact really means
- That failure in CI is protection, not a problem

CI/CD is about:
Consistency  
Automation  
Early detection  
Risk reduction  
Confidence in releases  

---

Happy Learning 🚀  
TrainWithShubham
