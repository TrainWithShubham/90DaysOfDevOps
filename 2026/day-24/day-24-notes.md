# Day 24 – Advanced Git

## Merge

Fast-forward merge happens when main has no new commits.

Merge commit happens when both branches have new commits.

Merge conflict occurs when the same line of a file is modified in two branches.

---

## Rebase

Rebase moves commits from one branch onto another base commit.

It creates a clean linear history.

Never rebase shared commits because it rewrites history.

---

## Squash Merge

Squash merge combines multiple commits into one.

Useful for cleaning messy feature branch history.

Tradeoff: you lose detailed commit history.

---

## Git Stash

Stash temporarily saves uncommitted changes.

`git stash pop` → apply + remove stash  
`git stash apply` → apply but keep stash.

Used when switching branches with unfinished work.

---

## Cherry Pick

Cherry-pick applies a specific commit from one branch to another.

Used when a single fix is needed in another branch.

Risk: duplicate commits or conflicts.
