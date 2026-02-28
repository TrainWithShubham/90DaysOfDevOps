# Day 25 – Git Reset vs Revert & Branching Strategies

---

# Part 1 – Git Reset

## Git Internals – 3 Areas

Git manages three main areas:

1. Working Directory – Actual files in the project
2. Staging Area (Index) – Changes prepared for next commit
3. Repository (HEAD / Commit History) – Saved commits

---

## git reset --soft

- Moves HEAD to previous commit
- Keeps changes in staging area
- Does NOT delete file changes

Use Case:
- When you want to modify last commit message
- When you want to combine commits

Effect:

| Area | Result |
|------|--------|
| Repository | HEAD moves back |
| Staging | Changes remain staged |
| Working Directory | No change |

---

## git reset --mixed (default)

- Moves HEAD back
- Unstages changes
- Keeps changes in working directory

Use Case:
- When you want to edit files before recommitting

Effect:

| Area | Result |
|------|--------|
| Repository | HEAD moves back |
| Staging | Cleared |
| Working Directory | Changes remain |

---

## git reset --hard

- Moves HEAD back
- Clears staging area
- Resets working directory
- Deletes uncommitted changes

Use Case:
- Discard local work completely

Effect:

| Area | Result |
|------|--------|
| Repository | HEAD moves back |
| Staging | Cleared |
| Working Directory | Reset to previous commit |

⚠ Dangerous:
- Rewrites history
- Deletes changes
- Unsafe on pushed commits

---

## Recovering from Hard Reset

Use:

git reflog

Then:

git reset --hard <commit-id>

Reflog acts as Git’s safety net.

---

# Part 2 – Git Revert

## What is git revert?

- Creates a new commit
- Reverses changes of specified commit
- Does NOT delete history

---

## Why revert is safer?

- Does not rewrite history
- Safe for shared branches
- Maintains audit trail
- Explicitly documents reversal

History example:

Commit A
Commit B
Commit C
Revert "Commit B"

Commit B still exists.

---

## Why revert can cause conflicts?

Because:
- Later commits may modify same context
- Revert uses merge logic
- Git may need manual resolution

Conflict resolution is required only when Git is unsure.

---

# Reset vs Revert Comparison

| | git reset | git revert |
|---|---|---|
| What it does | Moves HEAD backward | Creates new commit reversing changes |
| Removes commit from history? | Yes | No |
| Rewrites history? | Yes | No |
| Safe for shared branches? | No | Yes |
| Affects working directory? | Only --hard | No |
| Best used for | Local undo | Shared branch undo |

---

# Part 3 – Branching Strategies

## 1. GitHub Flow

Structure:

main  
 └ feature branches → PR → merge → deploy  

Best For:
- Startups
- Small teams
- Continuous deployment
- Fast shipping

Pros:
- Simple
- Fast
- Minimal overhead

Cons:
- Not ideal for long release cycles

---

## 2. GitFlow

Structure:

main (production)
develop (integration)

feature/*
release/*
hotfix/*

Best For:
- Enterprise teams
- Scheduled releases
- Dedicated QA cycles

Pros:
- Clear release management
- Parallel development + stabilization
- Strong structure

Cons:
- Complex
- Slower integration

---

## 3. Trunk-Based Development

Structure:

main (trunk)
Short-lived branches (< 1–2 days)

Best For:
- Big tech companies
- Strong CI/CD
- Heavy automation
- Feature flags used

Pros:
- Fast integration
- Minimal merge conflicts
- Continuous delivery

Cons:
- Requires discipline
- Risky without strong testing

---

# Strategy Selection Summary

| Strategy | Best For |
|-----------|------------|
| GitHub Flow | Startups / small teams |
| GitFlow | Enterprise / scheduled releases |
| Trunk-Based | Large tech with strong CI & feature flags |

---

# Key Learnings

- git reset rewrites history
- git revert preserves history
- Never use hard reset on pushed commits
- reflog can recover lost commits
- Branching strategy depends on team size, release cycle, and CI maturity
