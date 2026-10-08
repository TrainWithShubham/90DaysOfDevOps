# Day 25 – Git Reset vs Revert & Branching Strategies

Today I learned how to safely undo mistakes in Git using reset, revert, and reflog. I also learned different branching strategies used by software teams.

## Task 1 – Git Reset

First, I created 3 commits:

- Commit A
- Commit B
- Commit C

I checked commit history using:

```bash id="1lqv7y"
git log --oneline
```

---

## git reset --soft

Command used:

```bash id="lcgg1m"
git reset --soft HEAD~1
```

### What happened

- Last commit was removed from history
- Changes were still available
- Files stayed staged

### Understanding

Soft reset only moves HEAD backward.
It keeps all changes ready for recommit.

---

## git reset --mixed

Command used:

```bash id="8lyy2m"
git reset --mixed HEAD~1
```

### What happened

- Commit was removed
- Changes stayed in files
- Files became unstaged

### Understanding

Mixed reset removes commit and unstages changes, but does not delete them.

---

## git reset --hard

Command used:

```bash id="mk2kq8"
git reset --hard HEAD~1
```

### What happened

- Commit was deleted
- File changes were deleted
- Working directory became clean

### Understanding

Hard reset is dangerous because it permanently removes changes.

---

## Difference Between Soft, Mixed and Hard

| Type  | Commit Removed | Changes Kept | Staged |
| ----- | -------------- | ------------ | ------ |
| Soft  | Yes            | Yes          | Yes    |
| Mixed | Yes            | Yes          | No     |
| Hard  | Yes            | No           | No     |

---

## Which Reset is Destructive?

`git reset --hard`

Reason:
It deletes commits and file changes permanently.

---

## When to Use Each Reset

### Soft Reset

Used when:

- I want to recommit changes quickly
- I only want to change commit message or combine commits

### Mixed Reset

Used when:

- I want to unstage files
- I want to reorganize commits

### Hard Reset

Used when:

- I want to completely discard changes
- I need a clean repository state

---

## Should Reset Be Used on Pushed Commits?

No.

Reason:
It rewrites Git history and can create problems for team members working on shared branches.

---

# Task 2 – Git Revert

I created:

- Commit X
- Commit Y
- Commit Z

Then I reverted commit Y using:

```bash id="rw2kvf"
git revert <commit-id>
```

---

## What Happened

- Git created a new revert commit
- Original commit Y stayed in history
- Changes from Y were safely undone

I verified history using:

```bash id="9kjf8f"
git log --oneline
```

---

# Difference Between Reset and Revert

## git reset

- Removes commits from history
- Rewrites history
- Mostly used locally

## git revert

- Creates a new commit to undo changes
- Keeps history safe
- Good for shared branches

---

# Why Revert is Safer

Revert does not rewrite Git history.

Other developers can continue working without conflicts.

---

# When to Use Reset vs Revert

### Use Reset

- Local changes
- Before pushing
- Cleanup work

### Use Revert

- Shared repositories
- Pushed commits
- Team collaboration

---

# Reset vs Revert Summary

|                          | git reset           | git revert          |
| ------------------------ | ------------------- | ------------------- |
| What it does             | Moves HEAD backward | Creates undo commit |
| Removes history          | Yes                 | No                  |
| Safe for pushed branches | No                  | Yes                 |
| Main use                 | Local cleanup       | Safe undo           |

---

# Task 3 – git reflog

Command used:

```bash id="t1vgxe"
git reflog
```

## Understanding

`git reflog` is Git’s safety net.

It helps recover:

- deleted commits
- hard reset mistakes
- lost changes

Recovery example:

```bash id="j9p2h7"
git reset --hard <commit-id>
```

---

# Task 4 – Branching Strategies

## 1. GitFlow

### Structure

```text id="xg2q5n"
main
develop
feature/*
release/*
hotfix/*
```

### Used In

- Large companies
- Enterprise applications
- Scheduled release systems

### Pros

- Organized workflow
- Stable releases

### Cons

- Complex for small teams
- More branch management

---

## 2. GitHub Flow

### Structure

```text id="0z7m7s"
main -> feature branch -> pull request -> merge
```

### Used In

- Startups
- Fast deployment teams
- CI/CD workflows

### Pros

- Simple
- Fast development

### Cons

- Less control for large releases

---

## 3. Trunk-Based Development

### Structure

```text id="q1prq9"
small branches -> main
```

### Used In

- Modern DevOps teams
- Continuous deployment

### Pros

- Fast integration
- Smaller merge conflicts

### Cons

- Requires strong testing

---

# Answers

## Best Strategy for Startup

GitHub Flow

Reason:
It is simple and helps teams ship quickly.

---

## Best Strategy for Large Team

GitFlow

Reason:
It supports scheduled releases and organized workflows.

---

## Open Source Projects

Many modern open-source projects use GitHub Flow or Trunk-Based Development because they support fast collaboration and CI/CD practices.

---

# Commands Learned Today

```bash id="d2t3s6"
git reset --soft HEAD~1
git reset --mixed HEAD~1
git reset --hard HEAD~1
git revert <commit-id>
git reflog
```

---

# Final Learning

Today I learned:

- how to undo mistakes safely in Git
- difference between reset and revert
- why reflog is important
- which reset type is dangerous
- how branching strategies work in real engineering teams
