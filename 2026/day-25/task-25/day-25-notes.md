## Day 25 – Git Reset vs Revert & Branching Strategies
## Task
You'll learn how to undo mistakes safely — one of the most important skills in Git. You'll also explore branching strategies used by real engineering teams to manage code at scale.
# Task 1: Git Reset — Hands-On
- Difference between --soft, --mixed, and --hard
```
| Reset Type          | Commit History | Staging Area         | Working Directory |
| ------------------- | -------------- | -------------------- | ----------------- |
| `--soft`            | Moves HEAD     | Keeps staged changes | No change         |
| `--mixed` (default) | Moves HEAD     | Unstages changes     | Keeps changes     |
| `--hard`            | Moves HEAD     | Clears staging       | Deletes changes   |
```
## Which one is destructive?
- git reset --hard , Because it Deletes commits & Removes file changes from the working directory. If not backed up, the changes are lost permanently.
## When would you use each one?
- Soft Reset: Fix commit messages, Combine commits, Re-commit quickly
- Mixed Reset: Undo commit but keep code changes, Modify files before committing again
- Hard Reset: Completely discard changes, Reset repository to a previous state
## Should you use reset on pushed commits?
- ❌ Generally no, Because Reset rewrites history, Other developers may already have those commits & It causes conflicts when pulling or pushing. Use git revert instead for shared repositories.

- SHORT ANSWER: ```Git reset moves the HEAD pointer to a previous commit and optionally modifies the staging area and working directory depending on the reset mode.```

## Task 2: Git Revert — Hands-On
- How is git revert different from git reset?
```
| Git Reset                    | Git Revert           |
| ---------------------------- | -------------------- |
| Moves the branch pointer     | Creates a new commit |
| Deletes commits from history | Keeps commit history |
| Rewrites history             | Preserves history    |
```
Eg: Reset
```
X --- Y --- Z
        ↑
    reset here
```
Result: X
Eg: Revert
```
X --- Y --- Z --- Y'
```
Y remains, but its changes are undone & creates a new commit Y'
## Why is revert safer for shared branches?
- Because it does not rewrite history. In team environments: Other developers may already have pulled the commits, Reset would change commit history and cause conflicts. Revert simply adds another commit, so history remains consistent.

## When would you use revert vs reset?
- Use git revert : On shared branches (main, master, production), When a bad commit has already been pushed & When working in a team
- Use git reset : On local branches, When commits have not been pushed yet & When cleaning up commit history

- Short Interview Definition: Git revert creates a new commit that undoes changes from a previous commit while keeping the original commit in history.
## Task 3: Git Reset vs Git Revert - Summary

| Feature | `git reset` | `git revert` |
|--------|-------------|-------------|
| **What it does** | Moves the branch pointer (HEAD) to a previous commit and optionally changes the staging area and working directory | Creates a new commit that **undoes the changes** made by a previous commit |
| **Removes commit from history?** | Yes, it can remove commits from history | No, the original commit remains in history |
| **Safe for shared/pushed branches?** | ❌ No, because it rewrites history | ✅ Yes, because it preserves history |
| **When to use** | When working locally and you want to undo or modify recent commits | When a bad commit has already been pushed and you need to undo it safely |

## Task 4: Branching Strategies
- A branching strategy is a set of rules that defines how and when developers create, use, and merge branches in Git. It keeps teamwork organized and prevents code conflicts.


### 1) GitFlow

**How it works (short):**  
A structured model with two long-lived branches: `main` (production) and `develop` (integration). Work happens in short-lived `feature/*` branches from `develop`. Releases are stabilized in `release/*`, and urgent fixes go to `hotfix/*` from `main`.

**Simple Flow (text diagram):**
```
main ────────────────────────────────●────────────── 
                                    ↑
hotfix ──────────────────●──────────┤
                         ↓          │
develop ──────●──────────●──────────●──────
              ↑          ↑
feature/A ────●          │
                         │
feature/B ───────────────●
```
### How it works
GitFlow uses multiple long-lived branches, each with a specific role:
 
| Branch | Purpose |
|--------|---------|
| `main` | Only production-ready, released code |
| `develop` | Ongoing development work lives here |
| `feature/*` | One branch per new feature, branched off `develop` |
| `release/*` | Final testing/stabilization before going live |
| `hotfix/*` | Emergency fixes applied directly to `main` |

### Pros and Cons
| Pros | Cons |
|------|------|
| Very structured and organized | Many branches to manage |
| Clear release process | Slow — not ideal for daily shipping |
| Supports parallel development | Merge conflicts are common |
| Multiple versions can be maintained | Overkill for small teams |

## 2. GitHub Flow
 
### How it works
Super simple — only two things exist: `main` and a short-lived feature branch.
 
1. Create a branch from `main`
2. Make your changes and commit
3. Open a Pull Request (PR)
4. Get it reviewed
5. Merge into `main`
6. Deploy immediately

### Flow diagram
```
main ──●──────────────────●──────────────────●──
       └── feature/login ─┘                  └── feature/dashboard ──┘
               (PR + review + merge)                  (PR + review + merge)
```
### When / where it's used
- Startups shipping fast
- SaaS products with continuous delivery
- Open source projects (e.g. React, Vue)
- Small to medium teams

### Pros and Cons
| Pros | Cons |
|------|------|
| Simple and easy to learn | No staging / release buffer |
| Fast — ship every day | Risky without strong automated tests |
| Perfect for CI/CD pipelines | Not great for managing multiple versions |

## 3. Trunk-Based Development
 
### How it works
Everyone commits directly to `main` (the "trunk") — or merges tiny short-lived branches within hours (not days). Incomplete features are hidden using **feature flags** so the app stays working at all times.

- No long-lived branches
- CI (Continuous Integration) runs on every commit
- `main` is always in a deployable state

### Flow diagram
```
main ──●──●──●──────────●──●──●──────────────────►
          ↑             ↑
     short branch   short branch
     (merged same day)
     
    [feature flag hides unfinished work]
```

### When / where it's used
- High-performance engineering teams (Google, Meta, Netflix)
- Teams with mature CI/CD and strong test coverage
- When you want zero merge conflicts

### Pros and Cons
| Pros | Cons |
|------|------|
| Fewest merge conflicts | Requires discipline and feature flags |
| Forces frequent integration | Needs solid automated test coverage |
| Codebase always up to date | Hard for junior teams to adopt |
| Scales well for large teams | Mistakes can affect everyone immediately |
 
---

## Quick Comparison
 
| | GitFlow | GitHub Flow | Trunk-Based |
|---|---------|-------------|-------------|
| Complexity | High | Low | Medium |
| Speed to ship | Slow | Fast | Fastest |
| Best team size | Large | Small–Medium | Any (with discipline) |
| Release style | Scheduled | Continuous | Continuous |
| Merge conflicts | Common | Rare | Rarest |

## Answers
 
### Which strategy for a startup shipping fast?
**GitHub Flow.** It's simple, fast, and has almost no overhead. Create a branch, make changes, open a PR, merge, ship. A startup doesn't need the complexity of GitFlow.
 
### Which strategy for a large team with scheduled releases?
**GitFlow.** When you have many developers, a QA phase, and a release calendar, GitFlow's structure pays off. The release branch gives a buffer to stabilize before going live, and hotfixes are clean and traceable.
 
### Which does a popular open-source project use?
**React (facebook/react)** uses a **GitHub Flow** style — feature branches with PRs merged into `main`. You can verify at [github.com/facebook/react](https://github.com/facebook/react) by checking the branches and pull requests tabs.