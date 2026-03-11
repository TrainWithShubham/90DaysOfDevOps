# Day 25 – Git Reset vs Revert & Branching Strategies

---

# Task 1: Git Reset — Hands-On

## After `git reset --soft HEAD~1`

**What happens:**

* `HEAD` moves back one commit.
* Changes from the removed commit remain **staged** (in the index).
* Working directory is unchanged.

**State after command:**

* Commit removed from history.
* Changes ready to recommit immediately.

---

## After `git reset --mixed HEAD~1` (default mode)

**What happens:**

* `HEAD` moves back one commit.
* Changes from the removed commit remain in the **working directory**.
* Changes are **unstaged**.

**State after command:**

* Commit removed from history.
* You must run `git add` before recommitting.

---

## After `git reset --hard HEAD~1`

**What happens:**

* `HEAD` moves back one commit.
* Index reset.
* Working directory reset.
* Changes from the removed commit are **deleted**.

**State after command:**

* Commit removed from history.
* File changes are gone (unless recoverable via `git reflog`).

---

## Difference Between `--soft`, `--mixed`, `--hard`

| Mode    | Moves HEAD | Resets Index | Resets Working Directory |
| ------- | ---------- | ------------ | ------------------------ |
| --soft  | Yes        | No           | No                       |
| --mixed | Yes        | Yes          | No                       |
| --hard  | Yes        | Yes          | Yes                      |

---

## Which One Is Destructive?

`--hard` is destructive because it permanently discards working directory changes.
Data loss occurs unless recovered via `git reflog`.

---

## When to Use Each

**--soft**

* Squashing commits
* Fixing last commit message/content
* Reorganizing commits without losing staged state

**--mixed**

* Unstage changes but keep file edits
* Rework a commit cleanly

**--hard**

* Throw away local commits
* Reset branch to match remote
* Clean working directory completely

---

## Should You Use `git reset` on Pushed Commits?

Generally **no**.

If commits are already pushed:

* Reset rewrites history.
* Requires force push (`git push --force`).
* Breaks collaborators’ history.

Only safe if:

* You are working alone on the branch.
* Team explicitly agrees to history rewrite.

---

# Task 2: Git Revert — Hands-On Notes

Assume commits:

```
X → Y → Z (HEAD)
```

## Revert Commit Y

Command:

```
git revert <hash-of-Y>
```

**What happens:**

* Git creates a new commit (call it R).
* R reverses the changes introduced by Y.
* History becomes:

```
X → Y → Z → R
```

---

## Is Commit Y Still in History?

Yes.

`git log` still shows Y.
Revert does not remove history — it adds a new commit that negates changes.

---

## How Is `git revert` Different from `git reset`?

| git reset            | git revert              |
| -------------------- | ----------------------- |
| Moves branch pointer | Creates new commit      |
| Rewrites history     | Preserves history       |
| Can remove commits   | Does not remove commits |

---

## Why Is Revert Safer for Shared Branches?

* Does not rewrite history.
* No force push required.
* Does not break other developers’ clones.

---

## When to Use Revert vs Reset?

**Use revert when:**

* Commit already pushed
* On shared branches
* Need safe undo

**Use reset when:**

* Local cleanup
* Fixing unpushed commits
* Rewriting local history

---

# Task 3: Reset vs Revert — Summary Table

|                              | git reset                         | git revert                             |
| ---------------------------- | --------------------------------- | -------------------------------------- |
| What it does                 | Moves branch pointer backward     | Creates new commit that undoes changes |
| Removes commit from history? | Yes                               | No                                     |
| Safe for shared branches?    | No (unless force push acceptable) | Yes                                    |
| When to use                  | Local history rewrite             | Undoing pushed commits                 |

---

# Task 4: Branching Strategies

---

## 1️ GitFlow

### How It Works

Multiple long-lived branches:

* `main` (production)
* `develop` (integration)
* `feature/*`
* `release/*`
* `hotfix/*`

### Flow Diagram

```
main
  ↑     ↘ hotfix
develop → feature
   ↘ release → main
```

### Used For

* Large teams
* Enterprise software
* Scheduled releases

### Pros

* Structured
* Clear release process
* Isolates production code

### Cons

* Complex
* Heavy overhead
* Slow for rapid iteration

---

## 2️ GitHub Flow

### How It Works

* Single `main`
* Short-lived feature branches
* PR → review → merge → deploy

### Diagram

```
main → feature → PR → main
```

### Used For

* SaaS
* Continuous deployment
* Web applications

### Pros

* Simple
* Fast iteration
* Easy to understand

### Cons

* Less structured for versioned releases
* Requires strong CI/CD

---

## 3️ Trunk-Based Development

### How It Works

* Everyone commits to `main` (trunk)
* Very short-lived branches (or none)
* Heavy CI usage
* Feature flags for incomplete work

### Diagram

```
main ← small frequent commits
```

### Used For

* High-performing DevOps teams
* Companies practicing continuous delivery (Google, Facebook)

### Pros

* Minimal merge conflicts
* Fast integration
* Encourages small commits

### Cons

* Requires strong discipline
* Demands mature CI/testing

---

## Which Strategy Would You Use?

**Startup shipping fast:**
→ GitHub Flow or Trunk-Based Development
Reason: speed, simplicity, continuous deployment.

**Large team with scheduled releases:**
→ GitFlow
Reason: structured release cycles, hotfix control.

**Open-source example:**

* React uses a trunk-based style with release branches.
* Kubernetes uses a variation of GitHub Flow with release branches.
* Linux kernel uses a maintainer-based branching model (similar to distributed trunk model).

---

# Task 5: Git Commands Reference (Days 22–25)
 [Done]


# Takeaway

* **Reset = rewrite history**
* **Revert = undo safely**
* **Hard reset = destructive**
* **Reflog = safety net**
* **GitFlow = structure**
* **GitHub Flow = simplicity**
* **Trunk-Based = speed + CI discipline**

----------