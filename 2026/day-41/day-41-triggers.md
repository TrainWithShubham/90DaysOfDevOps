# ⚙️ Day 41 – Triggers & Matrix Builds
> By Mohammad Adnan Khan | 90DaysOfDevOps

---

## 📌 Task 1: PR Trigger

**File:** `.github/workflows/pr-check.yml`
```yaml
name: PR Check

on:
  pull_request:
    branches: [main]
    types: [opened, synchronize]

jobs:
  pr-check:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Print branch name
        run: echo "PR check running for branch ${{ github.head_ref }}"
```

**How it works:**
- Triggers when PR is opened or updated against `main`
- `synchronize` = new commits pushed to the PR branch
- `github.head_ref` = the branch name of the PR

---

## 📌 Task 2: Scheduled Trigger

**File:** `.github/workflows/schedule.yml`
```yaml
name: Scheduled Job

on:
  schedule:
    - cron: '0 0 * * *'
  push:
    branches: [main]

jobs:
  scheduled:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Print schedule info
        run: echo "Scheduled job running at $(date)"
```

**Cron expression for every Monday at 9 AM:**
```
0 9 * * 1
```

| Field | Value | Meaning |
|---|---|---|
| Minute | 0 | At minute 0 |
| Hour | 9 | At 9 AM UTC |
| Day | * | Any day |
| Month | * | Any month |
| Weekday | 1 | Monday |

---

## 📌 Task 3: Manual Trigger

**File:** `.github/workflows/manual.yml`
```yaml
name: Manual Deploy

on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Choose environment'
        required: true
        default: 'staging'
        type: choice
        options:
          - staging
          - production

jobs:
  manual:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Print environment
        run: echo "Deploying to ${{ github.event.inputs.environment }}"
```

**How to trigger manually:**
1. Go to GitHub repo → Actions tab
2. Find "Manual Deploy" workflow
3. Click "Run workflow"
4. Select staging or production
5. Click green "Run workflow" button ✅

---

## 📌 Task 4: Matrix Builds

**File:** `.github/workflows/matrix.yml`
```yaml
name: Matrix Build

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        python-version: ["3.10", "3.11", "3.12"]
        os: [ubuntu-latest, windows-latest]

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Python ${{ matrix.python-version }}
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}

      - name: Print Python version
        run: python --version
```

**Total jobs = 3 versions × 2 OS = 6 jobs in parallel!** 🔥

---

## 📌 Task 5: Exclude & Fail-Fast

**File:** `.github/workflows/matrix-exclude.yml`
```yaml
name: Matrix with Exclude

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ${{ matrix.os }}
    strategy:
      fail-fast: false
      matrix:
        python-version: ["3.10", "3.11", "3.12"]
        os: [ubuntu-latest, windows-latest]
        exclude:
          - os: windows-latest
            python-version: "3.10"

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}

      - name: Print version
        run: python --version
```

**fail-fast: true vs false:**

| | fail-fast: true (default) | fail-fast: false |
|---|---|---|
| One job fails | All other jobs cancelled | All jobs continue |
| Use when | Save time | See all results |

**Total jobs after exclude = 6 - 1 = 5 jobs!**

---

## 🎯 Key Learnings from Day 41

1. **push** — triggers on every git push to specified branch
2. **pull_request** — triggers when PR is opened or updated
3. **schedule** — triggers on cron schedule (like a cron job)
4. **workflow_dispatch** — manual trigger with optional inputs
5. **Matrix builds** — run same job across multiple environments in parallel
6. **fail-fast: false** — all jobs run even if one fails
7. **exclude** — skip specific combinations in matrix

---

## 🔗 References
- GitHub: [AddyKhan257/90DaysOfDevOps](https://github.com/AddyKhan257/90DaysOfDevOps)

---

*Day 41 of 90DaysOfDevOps Challenge*
*#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham*
