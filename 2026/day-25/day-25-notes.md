# Day 25: Git Reset, Revert & Branching Strategies

## Task 1: Git Reset — Hands-On

**Q: Use `git reset --soft` to go back one commit — what happens to the changes?**
*Answer:* When I ran this, the commit was deleted, but my file changes stayed intact and were left in the Staging Area (green status). It's like undoing just the commit message but keeping the work ready to commit again.

**Q: Re-commit, then use `git reset --mixed` to go back one commit — what happens now?**
*Answer:* This deleted the commit and also unstaged my changes. My file modifications were still safe in my working directory, but they turned red in `git status` (not ready for commit yet). I observed that this is Git's default reset behavior.

**Q: Re-commit, then use `git reset --hard` to go back one commit — what happens this time?**
*Answer:* This completely nuked the commit AND deleted my physical file changes. The code was permanently gone from my working directory. 

**Q: What is the difference between `--soft`, `--mixed`, and `--hard`?**
*Answer:* It's all about where my files end up after the commit is deleted. `--soft` keeps them staged, `--mixed` keeps them in the working directory (unstaged), and `--hard` deletes them entirely.

**Q: Which one is destructive and why?**
*Answer:* `--hard` is highly destructive because it deletes the actual code I wrote in my local files, not just the commit history. If I haven't backed it up, it's gone forever.

**Q: When would you use each one?**
*Answer:* I'd use `--soft` if I just messed up a commit message and want to quickly re-commit. I'd use `--mixed` if I want to unstage files and modify my code before committing again. I'd use `--hard` only when my recent code is complete garbage and I want to start fresh from the last good commit.

**Q: Should you ever use `git reset` on commits that are already pushed?**
*Answer:* Absolutely NOT. If I reset pushed commits, I rewrite history. When my team tries to pull, it will break their local repositories and cause massive merge conflicts.

---

## Task 2: Git Revert — Hands-On

**Q: Revert commit Y (the middle one) — what happens?**
*Answer:* Git created a brand new commit that did the exact opposite of what Commit Y did (it removed the file I added). It didn't delete the old commit; it just pushed a new "undo" commit on top.

**Q: Check `git log` — is commit Y still in the history?**
*Answer:* Yes! When I checked the log, Commit Y was still sitting exactly where it was. The new `Revert "Commit Y..."` was added at the top of the history safely.

**Q: How is `git revert` different from `git reset`?**
*Answer:* `reset` deletes history by moving backward. `revert` preserves history by moving forward and adding a new commit that cancels out the old changes.

**Q: Why is revert considered safer than reset for shared branches?**
*Answer:* Because it doesn't rewrite the past. Since it just adds a new commit, my team can simply run `git pull` to safely get my "undo" changes without their local repo breaking or complaining about mismatched histories.

**Q: When would you use revert vs reset?**
*Answer:* I use `reset` for my local, unpushed branches when I want to clean up my messy history. I use `revert` for public/shared branches (like `main`) when I need to undo a bug that has already been pushed to GitHub.

---

## Task 3: Reset vs Revert Summary

| Feature | `git reset` | `git revert` |
| :--- | :--- | :--- |
| **What it does?** | Rewinds and removes commits from history. | Adds a new commit that undoes the changes. |
| **Destructive?** | Yes (especially `--hard`). | No (History keeps moving forward). |
| **Safe for Shared/Pushed?** | ❌ NO. Breaks history for other devs. | ✅ YES. Safe for active collaboration. |
| **When to use?** | Fixing local mistakes before pushing. | Undoing bugs on public/shared branches. |

---

## Task 4: Branching Strategies

### 1. GitFlow
* **How it works:** Strict structure using `main`, `develop`, `feature`, `release`, and `hotfix` branches.
* **When to use:** Enterprise software with scheduled, versioned releases (e.g., v1.0, v2.0).
* **Pros & Cons:** Highly organized and safe, but can be slow and bureaucratic.

### 2. GitHub Flow
* **How it works:** Extremely simple. One always-deployable `main` branch, and developers create temporary `feature` branches for PRs.
* **When to use:** Agile teams deploying multiple times a day (Continuous Deployment).
* **Pros & Cons:** Fast and lightweight, but requires rigorous automated testing.

### 3. Trunk-Based Development
* **How it works:** Developers push code directly to the main trunk (`main`) multiple times a day using feature flags. Short-lived branches only.
* **When to use:** High-performing tech giants (Netflix, Google).
* **Pros & Cons:** Zero "merge hell", but requires elite-level CI/CD pipelines.

**Q: Which strategy would you use for a startup shipping fast?**
*Answer:* I would choose GitHub Flow or Trunk-Based Development. They remove bottlenecks and allow rapid deployment.

**Q: Which strategy would you use for a large team with scheduled releases?**
*Answer:* I would use GitFlow. It provides the strict structure needed to manage multiple environments and versioned releases safely.

**Q: Which one does your favorite open-source project use?**
*Answer:* Most open-source projects on GitHub (like React or Kubernetes) use a variation of **GitHub Flow** (specifically, the Fork and Pull Request model). 
