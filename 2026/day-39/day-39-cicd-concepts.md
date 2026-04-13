# Day 39 – What is CI/CD?

## Task 1: The Problem with Manual Deployments

### What can go wrong?
When 5 developers all push code and manually deploy to production:
- **More developers = more demand** on the deployment process — supply of deploys can't keep up
- **Merge conflicts** — multiple developers working on branches that need to be integrated
- **Configuration errors** — wrong environment variables, mismatched settings
- **Two developers deploying at the same time** can overwrite each other's changes
- **No accountability** — if broken code goes out, it's hard to know who deployed what
- **Deployment fatigue** — manual steps are error-prone, especially under pressure

### "It works on my machine" — Why is it a real problem?
Each developer's local machine has its own:
- OS version
- Python/Node version
- Environment variables
- Locally installed dependencies

Code runs fine locally but breaks in production because the environments are different. With 5 developers, you have 5 different "machines" — and production is a 6th. Without a consistent, automated environment, this problem multiplies.

### How many times can a team safely deploy manually per day?
Realistically **1–2 times** before fatigue, coordination overhead, and mistakes creep in.  
With CI/CD, teams like Netflix and Amazon deploy **hundreds of times per day**.

---

## Task 2: CI vs CD vs CD

### Continuous Integration (CI)
Developers push code to the main branch frequently. Every push automatically triggers a **build and test** process. If something breaks, the team finds out in minutes — not days.

**Real-world example:** A developer pushes a bug fix to FastAPI's `master` branch. GitHub Actions automatically runs the test suite. If any test fails, the push is flagged immediately.

### Continuous Delivery
The pipeline automates build and test, but a **human manually approves** the final release to production. The code is always *ready* to deploy — but someone clicks the button.

**Real-world example:** A banking app automatically builds and tests every PR, but a release manager reviews and manually triggers the production deploy each Friday.

**When to use it:** High-risk or regulated industries — healthcare, banking, government — where a human approval gate is required before changes reach real users.

### Continuous Deployment
Fully automated — code goes from commit to production with **zero human involvement**, as long as all tests pass.

**Real-world example:** A SaaS startup pushes a UI fix. Tests pass. The app is live for users within minutes — no one clicked anything.

**When to use it:** Fast-moving web apps where speed matters and risk is manageable.

---

## Task 3: Pipeline Anatomy

| Term | What it does |
|------|-------------|
| **Trigger** | The event that starts the pipeline (e.g. `push`, `pull_request`, `workflow_dispatch`, scheduled cron) |
| **Stage** | A logical phase in the pipeline — e.g. Build, Test, Deploy |
| **Job** | A unit of work inside a stage — e.g. inside Test stage: run unit tests, run security scan |
| **Step** | A single command or action inside a job — e.g. `pip install -r requirements.txt`, then `pytest tests/` |
| **Runner** | The machine that executes the job — e.g. `runs-on: ubuntu-latest` (GitHub's servers or self-hosted) |
| **Artifact** | The output produced by a job — e.g. a Docker image, test report, or compiled binary passed to the next stage |

---

## Task 4: Pipeline Diagram

**Scenario:** Developer pushes code → app is tested → built into Docker image → deployed to staging

```
Developer pushes code to GitHub
            │
            ▼
    ┌───────────────┐
    │   TRIGGER     │  push / pull_request
    └───────┬───────┘
            │
            ▼
    ┌───────────────────────────────────────────────────┐
    │  STAGE 1: BUILD                                   │
    │  Job: Build App                                   │
    │    Step 1: checkout code                          │
    │    Step 2: install dependencies                   │
    │    Step 3: build Docker image                     │
    │  Artifact: Docker image                           │
    └───────────────────────┬───────────────────────────┘
                            │
                            ▼
    ┌───────────────────────────────────────────────────┐
    │  STAGE 2: TEST                                    │
    │  Job 1: Unit Tests                                │
    │    Step 1: run pytest / jest                      │
    │  Job 2: Security Scan                             │
    │    Step 1: run vulnerability scanner              │
    │  Artifact: test report + coverage report          │
    └───────────────────────┬───────────────────────────┘
                            │
                    ┌───────┴───────┐
                 PASS?           FAIL?
                    │               │
                    ▼               ▼
            Continue          ❌ Pipeline stops
                    │            Team is notified
                    ▼
    ┌───────────────────────────────────────────────────┐
    │  STAGE 3: DEPLOY                                  │
    │  Job: Deploy to Staging                           │
    │    Step 1: push Docker image to registry          │
    │    Step 2: pull image on staging server           │
    │    Step 3: restart container                      │
    │  Result: App live on staging ✅                   │
    └───────────────────────────────────────────────────┘

Runner: ubuntu-latest (GitHub-hosted) for all stages
```

---

## Task 5: Open Source in the Wild — FastAPI

**Repo:** https://github.com/fastapi/fastapi  
**Workflow file:** `.github/workflows/test.yml`

### Triggers
- `push` to `master` branch
- `pull_request` when opened or updated (`opened`, `synchronize`)
- `schedule` — runs automatically every Monday (cron: `0 0 * * 1`)

### Jobs (5 total)
1. `changes` — checks if relevant source files were changed (avoids running tests for docs-only changes)
2. `test` — runs the full test suite across multiple OS (Windows, macOS, Ubuntu) and multiple Python versions (3.10 → 3.14)
3. `benchmark` — runs performance benchmarks using CodSpeed
4. `coverage-combine` — combines coverage reports from all test matrix runs
5. `check` — final gate job used for branch protection; confirms all required jobs passed

### What does it do? (Plain English)
When anyone opens a pull request on FastAPI, this pipeline automatically runs tests across every supported OS and Python version. If any test fails, the PR **cannot be merged** — this protects the `master` branch from broken code. It also tracks test coverage and requires 100% coverage to pass. This is CI doing its job.

### Key Observation
The `test` job uses a **matrix strategy** — it runs the same tests on Windows, macOS, and Ubuntu, across Python 3.10 to 3.14. This is how a real production project guarantees "it works on MY machine" is never an excuse.

---

## Key Takeaways

- **CI/CD is a practice, not just a tool** — GitHub Actions, Jenkins, GitLab CI are just tools that implement it
- A **pipeline failing is not a problem** — it's CI/CD doing its job, catching issues before they reach users
- Manual deployments cap out at ~1–2 per day safely; CI/CD enables hundreds
- The difference between Delivery and Deployment is one thing: **the human approval gate**

---

