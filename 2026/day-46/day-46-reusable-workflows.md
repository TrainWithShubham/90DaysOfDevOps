# 📘 Day 46 – Task 1 Answers

## 1. 🔁 What is a reusable workflow?

A reusable workflow is a GitHub Actions workflow that can be called by other workflows instead of rewriting the same steps again and again.

👉 It helps:
- Avoid duplicate code  
- Standardize CI/CD across projects  
- Save time  

📌 Example:  
You write build + test logic once, and reuse it in multiple repos.

---

## 2. ⚙️ What is `workflow_call` trigger?

`workflow_call` is a special trigger that allows a workflow to be invoked by another workflow.

👉 Instead of running on push or pull request:


on:
  workflow_call:


## 3. 🔄 Difference: reusable workflow vs regular action (`uses:`)

| Feature | Reusable Workflow | Regular Action |
|--------|------------------|----------------|
| Level | Full workflow (jobs + steps) | Single step |
| Usage | `uses: ./.github/workflows/file.yml` | `uses: actions/checkout@v4` |
| Structure | Contains jobs | Contains steps |
| Purpose | Reuse entire CI/CD pipeline | Reuse small functionality |

👉 **Simple:**
- Reusable workflow = big function (multiple jobs)  
- Action = small function (single task)



##  4. 📁 Where must it live?

.github/workflows/reusable.yml





## 📊 Task 6: Reusable Workflow vs Composite Action

| | Reusable Workflow | Composite Action |
|---|---|---|
| Triggered by | `workflow_call` | `uses:` in a step |
| Can contain jobs? | Yes | No |
| Can contain multiple steps? | Yes (inside jobs) | Yes |
| Lives where? | `.github/workflows/` | `.github/actions/<action-name>/` |
| Can accept secrets directly? | Yes | No (must be passed as inputs) |
| Best for | Reusing full CI/CD pipelines | Reusing small sets of steps |

---
