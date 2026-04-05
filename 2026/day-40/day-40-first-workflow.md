# ⚙️ Day 40 – My First GitHub Actions Workflow
> By Mohammad Adnan Khan | 90DaysOfDevOps

---

## 📌 Task 1: Setup

- Created public repo: `github-actions-practice` on GitHub
- Cloned it locally
- Created folder structure: `.github/workflows/`

---

## 📌 Task 2: Hello Workflow

**File:** `.github/workflows/hello.yml`
```yaml
name: Hello GitHub Actions

on:
  push:

jobs:
  greet:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Say Hello
        run: echo "Hello from GitHub Actions!"
```

✅ Pushed to GitHub → went to Actions tab → Pipeline ran green!

---

## 📌 Task 3: Workflow Anatomy

| Key | What it does |
|---|---|
| `on:` | Defines what event triggers the pipeline (push, pull_request, schedule) |
| `jobs:` | Contains all the jobs to run in the pipeline |
| `runs-on:` | Defines which machine/OS the job runs on (ubuntu-latest, windows-latest) |
| `steps:` | List of individual tasks to execute inside a job |
| `uses:` | Runs a pre-built action from GitHub Marketplace (e.g. actions/checkout) |
| `run:` | Executes a shell command directly on the runner |
| `name:` | A human-readable label for the step — shows in Actions tab |

---

## 📌 Task 4: Updated Workflow With More Steps
```yaml
name: Hello GitHub Actions

on:
  push:

jobs:
  greet:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Say Hello
        run: echo "Hello from GitHub Actions!"

      - name: Print current date and time
        run: date

      - name: Print branch name
        run: echo "Branch is ${{ github.ref_name }}"

      - name: List files in repo
        run: ls -la

      - name: Print runner OS
        run: echo "Runner OS is $RUNNER_OS"
```

✅ Pushed again → All steps ran successfully → Green pipeline!

---

## 📌 Task 5: Break It On Purpose

Added a failing step:
```yaml
      - name: This will fail
        run: exit 1
```

**What a failed pipeline looks like:**
- ❌ Red cross on the Actions tab
- The failed step shows in red with the error message
- All steps AFTER the failed step are skipped automatically
- GitHub sends an email notification about the failure
- Easy to read — click the failed step and see exact error output

**Fixed by removing `exit 1` → pushed again → back to green ✅**

---

## 🎯 Key Learnings from Day 40

1. **Workflow files live in `.github/workflows/`** — any `.yml` file there is automatically picked up by GitHub Actions
2. **Every push triggers a new run** — you can watch it live in the Actions tab
3. **`uses:` vs `run:`** — `uses` runs pre-built actions, `run` executes shell commands
4. **GitHub built-in variables** — `${{ github.ref_name }}` gives branch name, `$RUNNER_OS` gives OS
5. **Failed pipelines are helpful** — they tell you exactly which step failed and why

---

## 🔗 Repository
- GitHub: [github-actions-practice](https://github.com/AddyKhan257/github-actions-practice)

---

*Day 40 of 90DaysOfDevOps Challenge*
*#90DaysOfDevOps #DevOpsKaJosh #Trainwithshubham*
