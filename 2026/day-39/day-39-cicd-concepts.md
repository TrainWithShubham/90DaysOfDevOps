# 🚀 Day 39 – What is CI/CD?
> By Mohammad Adnan Khan | 90DaysOfDevOps

---

## 📌 Task 1: The Problem With Manual Deployments

### What can go wrong with 5 developers manually deploying?
- ❌ Two developers push conflicting code at the same time → app breaks completely
- ❌ Someone forgets to test before deploying → bugs go directly to production
- ❌ Code works on developer laptop but fails on the production server
- ❌ No rollback plan if deployment fails → website goes down for hours
- ❌ No one knows whose code caused the bug → blame game starts!
- ❌ Deployment takes hours → slow delivery to customers

### "It works on my machine" — Why is this a real problem?
Every developer has a different environment on their laptop — different OS version, different Node.js version, different environment variables, different installed packages. Code that runs perfectly locally can completely fail on the production server because the environments are different.

Docker solved this partially by packaging the app with its environment. CI/CD solves it completely by always running code in a standardized, controlled environment — the same every single time, for every developer.

### How many times can a team safely deploy manually?
| Manual Deployments | With CI/CD |
|---|---|
| 1-2 times per day maximum | 50-100+ times per day! |
| Slow, risky, error-prone | Fast, safe, automated |
| Hours to deploy | Minutes to deploy |

---

## 📌 Task 2: CI vs CD vs CD

### ✅ Continuous Integration (CI)
Developers merge code to a shared repo frequently (multiple times per day). Each merge automatically triggers a build and test process. CI catches integration bugs early — before they become big problems.

**What it does:** Builds code → Runs unit tests → Reports pass/fail

**Real-world example:** Netflix engineers push code 100+ times per day. Every push automatically runs thousands of tests within minutes.

---

### 🚚 Continuous Delivery (CD)
After CI passes, the code is automatically prepared and packaged for deployment. The app is always in a deployable state. However, the actual deployment to production requires a **manual approval** button press.

**What it does:** CI passes → Build artifact → Deploy to staging → Ready for production

**Real-world example:** A company runs CI/CD where every feature is tested and staged automatically, but a product manager clicks "Deploy to Production" manually for business reasons.

---

### 🤖 Continuous Deployment (CD)
Every change that passes all automated tests is automatically deployed to production — NO human approval needed. This is the most advanced stage. Only companies with very high test coverage and confidence use this.

**What it does:** CI passes → Deploy to staging → Auto-deploy to production

**Real-world example:** Amazon deploys to production every 11.7 seconds — fully automated!

---

### Quick Comparison

| Feature | CI | Continuous Delivery | Continuous Deployment |
|---|---|---|---|
| Auto Build | ✅ Yes | ✅ Yes | ✅ Yes |
| Auto Test | ✅ Yes | ✅ Yes | ✅ Yes |
| Auto Stage | ❌ No | ✅ Yes | ✅ Yes |
| Auto Prod Deploy | ❌ No | ❌ No (manual) | ✅ Yes (auto) |
| Human Approval | Build only | For production | Not needed |

---

## 📌 Task 3: Pipeline Anatomy

| Component | Definition | Example |
|---|---|---|
| 🎯 **Trigger** | The event that starts the pipeline automatically | git push, pull request, schedule |
| 📦 **Stage** | A logical phase/group in the pipeline | Build, Test, Deploy |
| ⚙️ **Job** | A unit of work inside a stage — runs on a runner | run-unit-tests, build-docker |
| 📝 **Step** | A single command or action inside a job | npm install, npm test |
| 🖥️ **Runner** | The machine/server that executes the job | ubuntu-latest, self-hosted |
| 🗂️ **Artifact** | Output produced by a job — passed to next stage | app.jar, docker image, test-report |

---

## 📌 Task 4: CI/CD Pipeline Diagram

**Scenario:** Developer pushes code to GitHub → App is tested → Built into Docker image → Deployed to staging server
```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  🔀 TRIGGER  │────▶│  🔨 BUILD   │────▶│  🧪 TEST    │────▶│  🐳 DOCKER  │────▶│  🚀 DEPLOY  │
│             │     │             │     │             │     │             │     │             │
│  git push   │     │ npm install │     │  npm test   │     │docker build │     │  SSH server │
│  to GitHub  │     │  npm build  │     │  coverage   │     │docker push  │     │  docker up  │
└─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘
```

### Detailed Breakdown

| Stage | Job | Steps | Status |
|---|---|---|---|
| 🔀 Trigger | on: push to main | GitHub detects git push, starts pipeline | ⚡ Auto |
| 🔨 Build | install-and-build | checkout code, npm install, npm run build | ✅ Pass/Fail |
| 🧪 Test | run-tests | npm test, generate coverage, report results | ✅ Pass/Fail |
| 🐳 Docker | build-and-push | docker build, docker tag, docker push to Hub | ✅ Pass/Fail |
| 🚀 Deploy | deploy-staging | SSH to server, docker pull, docker-compose up | 🎉 Live! |

---

## 📌 Task 5: Explore in the Wild — FastAPI

**Repo explored:** `tiangolo/fastapi` on GitHub
**Workflow file:** `.github/workflows/test.yml`

| Question | Answer |
|---|---|
| What triggers it? | push and pull_request events on main branch |
| How many jobs? | Multiple — lint, test (matrix: Python 3.8, 3.9, 3.10, 3.11), coverage |
| What does it do? | Installs FastAPI dependencies, runs pytest across multiple Python versions simultaneously using matrix strategy, uploads coverage to Codecov |
| Key learning | Matrix strategy runs same tests across multiple Python versions in parallel — saves time and ensures compatibility! |

---

## 🎯 Key Learnings from Day 39

1. **CI/CD is a practice, not a tool** — GitHub Actions, Jenkins, GitLab CI are tools that implement CI/CD. The practice is about automating build, test, and deploy.
2. **A failing pipeline is a good thing!** — CI/CD catching a bug before production is exactly what it is designed to do.
3. **CI vs Delivery vs Deployment** — CI = auto test. Delivery = auto stage + manual prod. Deployment = fully automatic.
4. **Pipeline anatomy** — Trigger → Stage → Job → Step → Runner → Artifact.
5. **Real teams deploy frequently** — Amazon: every 11.7 seconds. Netflix: 100s of times per day. Only possible with CI/CD!

---

## 🔧 Popular CI/CD Tools

| Tool | Best For | Key Feature |
|---|---|---|
| GitHub Actions | GitHub repos, open source | Built into GitHub, free for public repos |
| Jenkins | Enterprise, self-hosted | Most flexible, 1800+ plugins |
| GitLab CI | GitLab users | All-in-one DevOps platform |
| CircleCI | Fast builds | Very fast, great Docker support |
| ArgoCD | Kubernetes deployments | GitOps approach, K8s native |

---

*Day 39 of 90DaysOfDevOps Challenge*
*#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham*
