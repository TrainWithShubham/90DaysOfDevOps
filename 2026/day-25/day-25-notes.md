#  Day 25 – Git Reset Notes

## 🔹 What is the difference between `--soft`, `--mixed`, and `--hard`?

Git reset moves the HEAD to a previous commit.  
The difference is what happens to your changes.

---

###  git reset --soft

- Moves HEAD to previous commit  
- Deletes the commit  
- Keeps changes in staging area  
- Code remains safe  

 Commit is removed, but changes are ready to commit again.

---

###  git reset --mixed (Default)

- Moves HEAD to previous commit  
- Deletes the commit  
- Removes files from staging  
- Keeps changes in working directory  

 Commit is removed, changes are safe but unstaged.

---

###  git reset --hard

- Moves HEAD to previous commit  
- Deletes the commit  
- Clears staging area  
- Deletes changes from working directory  

 Commit and changes are permanently deleted.

---

##  Which one is destructive and why?

`git reset --hard` is destructive  

Because:
- It deletes commits  
- It deletes uncommitted changes  
- Data can be permanently lost  

---

##  When would you use each one?

###  --soft
- To edit the last commit  
- To change commit message  
- To combine commits  

###  --mixed
- To unstage files  
- To modify files before committing again  
- Default safe reset  

###  --hard
- To completely discard changes  
- To return to a clean state  
- When you are 100% sure you don’t need the changes  

---

##  Should you use git reset on pushed commits?

 No (not recommended)

If commits are already pushed:
- It rewrites history  
- It can break team members' work  

Instead use:
- `git revert` (safe for public branches)

---

##  Quick Summary

| Command | Commit Deleted | Changes Staged | Changes Kept | Safe? |
|----------|---------------|---------------|--------------|-------|
| --soft   | Yes           | Yes           | Yes          | 
 Safe |
| --mixed  | Yes           | No            | Yes          | 
 Safe |
| --hard   | Yes           | No            | No           | 
 Dangerous |

---


# Day 25 – Reset vs Revert Summary

## Comparison: git reset vs git revert

| | `git reset` | `git revert` |
|---|---|---|
| **What it does** | Moves HEAD to a previous commit and rewrites history | Creates a new commit that reverses changes |
| **Removes commit from history?** | Yes | No |
| **Safe for shared/pushed branches?** | No | Yes |
| **When to use** | For local commits that are not pushed | For undoing commits that are already pushed |

---

## Simple Explanation

### git reset
- Used to undo local commits
- Can remove commits from history
- Rewrites commit history
- Not safe on public branches

Best for: Cleaning up local work before pushing

---

### git revert
- Safely undoes a specific commit
- Does not remove commit from history
- Creates a new revert commit
- Safe for team projects

Best for: Undoing changes in shared repositories

---

## Golden Rule

Local branch → reset is okay  
Public/shared branch → revert is safer

---

# Day 25 – Branching Strategies

## 1. GitFlow

### How it works
GitFlow uses multiple long-running branches:
- `main` → production-ready code
- `develop` → integration branch for features
- `feature/*` → new features
- `release/*` → prepare release
- `hotfix/*` → urgent production fixes

### Simple Flow Diagram

main
  ↑        ↑
  |      hotfix/*
  |
release/*
  ↑
develop
  ↑
feature/*

### When/Where It’s Used
- Large teams
- Products with scheduled releases
- Enterprise environments

### Pros
- Clear structure
- Good for planned releases
- Supports parallel development

### Cons
- Complex
- Too many branches
- Slower for fast-moving teams


---

## 2. GitHub Flow

### How it works
- Single `main` branch
- Create feature branch from main
- Open Pull Request
- Review and merge into main
- Deploy

### Simple Flow Diagram

main
  ↑
feature-branch → Pull Request → merge → main

### When/Where It’s Used
- Continuous deployment
- Web apps
- Startups

### Pros
- Simple
- Easy to manage
- Fast delivery

### Cons
- Not ideal for versioned releases
- Less structured for large teams


---

## 3. Trunk-Based Development

### How it works
- Everyone works on `main` (trunk)
- Very short-lived branches (1–2 days)
- Frequent commits
- Heavy use of CI/CD

### Simple Flow Diagram

main (trunk)
  ↑  ↑  ↑
 small branches merged quickly

### When/Where It’s Used
- High-performance teams
- Continuous integration environments
- Companies like Google, Netflix

### Pros
- Fast integration
- Fewer merge conflicts
- Encourages small commits

### Cons
- Requires strong testing
- Discipline required
- Risky without CI


---

# Final Answers

### Which strategy for a startup shipping fast?

GitHub Flow  
Because it is simple, fast, and supports continuous deployment.

---

### Which strategy for a large team with scheduled releases?

GitFlow  
Because it supports release branches and structured development.

---

### Which one does your favorite open-source project use?

Most modern open-source projects on GitHub use GitHub Flow  
They usually have:
- `main` branch
- Feature branches
- Pull Requests
- Code review before merge

Example:
Many repositories on GitHub follow GitHub Flow style with PR-based merging.


---

