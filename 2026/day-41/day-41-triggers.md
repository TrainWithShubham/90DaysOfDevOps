# Day 41 – Triggers & Matrix Builds

## What I Learned Today

GitHub Actions supports multiple trigger types and matrix builds to run jobs across multiple environments in parallel. Today I explored matrix strategies, excludes, and fail-fast behaviour using a single workflow file.

---

## Workflow File: `.github/workflows/pr-check.yml`

```yaml
name: "pr checks"

on:
  workflow_dispatch:

jobs:                       
  print_input:                 
    runs-on: ubuntu-latest  
    strategy:
       matrix:
         python-version: [ '3.10' , '3.11' , '3.12' ]
         exclude:
         - python-version: 3.10
    steps:           
      - name: set up python versions
        uses: actions/setup-python@v4
        with:
          python-version: ${{ matrix.python-version }}
         
      - name: Force failure on Python 3.11
        if: matrix.python-version == '3.11'
        run: exit 1

      - name: print python version
        run: python --version
```

---

## What This Workflow Does

- **Trigger:** `workflow_dispatch` — runs manually from the Actions tab
- **Matrix:** Runs the job across Python `3.11` and `3.12` (3.10 is excluded)
- **Exclude:** Removes Python `3.10` from the matrix so it never runs
- **Force failure:** The job deliberately fails on Python `3.11` using `exit 1`
- **Result:** Python `3.12` job passes, Python `3.11` job fails

---

## Matrix Job Count

| Python Version | Excluded? | Runs? |
|----------------|-----------|-------|
| 3.10 | Yes | No |
| 3.11 | No | Yes (fails) |
| 3.12 | No | Yes (passes) |

**Total jobs that run: 2**

---

## Key Concepts

### fail-fast: true vs false

| Setting | Behaviour |
|---------|-----------|
| `fail-fast: true` (default) | If any job fails, GitHub **immediately cancels** all remaining jobs |
| `fail-fast: false` | All jobs run to completion even if one fails — useful to see which combinations break |

Since `fail-fast` is not set in my workflow, it defaults to `true`. This means when Python `3.11` fails, GitHub cancels any remaining jobs.

### Cron Expression Answer (Task 2 Notes)

| Schedule | Cron Expression |
|----------|----------------|
| Every day at midnight UTC | `0 0 * * *` |
| Every Monday at 9 AM UTC | `0 9 * * 1` |

---

## Learn in Public

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`
