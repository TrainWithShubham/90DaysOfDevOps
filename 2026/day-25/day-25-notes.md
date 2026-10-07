# Day 25 - Git Reset vs Revert & Branching Strategies

## Task 1 & 2: Undo Operations in Git

### `git reset` (The Time Machine)
* `--soft`: Un-commits the files but leaves them in the staging area.
* `--mixed`: (Default) Un-commits and un-stages the files, putting them back in the working directory.
* `--hard`: Destructive. Un-commits, un-stages, and completely deletes the changes from the hard drive. 
* **Rule:** Never use `git reset` on commits that have already been pushed to a shared remote repository.

### `git revert` (The Safe Undo)
* Undoes the changes introduced by a specific commit by creating a brand new commit that does the exact opposite.
* **Rule:** Always use `git revert` for shared branches because it preserves the repository history and only moves the timeline forward.

## Task 3: Reset vs Revert Summary

| Feature | `git reset` | `git revert` |
| :--- | :--- | :--- |
| **What it does** | Rewinds the timeline to a previous state. | Adds a new commit to undo specific past changes. |
| **Removes commit from history?** | Yes. | No, the original commit remains in history. |
| **Safe for shared/pushed branches?**| No. | Yes. |
| **When to use** | Fixing un-pushed, local mistakes. | Fixing bugs in production or shared branches. |

## Task 4: Branching Strategies

**1. GitFlow**
* **How it works:** A strict model with multiple long-lived branches (`main`, `develop`) and short-lived branches (`feature`, `release`, `hotfix`).
* **When to use:** Large engineering teams working on monolithic applications with strict, scheduled release cycles.

**2. GitHub Flow**
* **How it works:** A simplified model with a single long-lived `main` branch. Developers branch off `main` to create features, open Pull Requests, and merge directly back into `main` to deploy.
* **When to use:** Startups and Agile teams practicing CI/CD who want to ship fast and deploy multiple times a day.

**3. Trunk-Based Development**
* **How it works:** Developers push code directly to the `main` branch (the "trunk") multiple times a day, often using feature flags to hide unfinished code. 
* **When to use:** Elite DevOps teams with highly automated testing pipelines.

### Scenario Answers:
* **Startup shipping fast:** GitHub Flow.
* **Large team with scheduled releases:** GitFlow.
* **Favorite Open-Source Project:** Most large open-source projects (like Kubernetes) use a variation of the Forking Workflow combined with GitHub Flow (where contributors fork the repo and submit PRs to the main project).