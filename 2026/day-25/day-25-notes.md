# Day 25 – Git Reset vs Revert & Branching Strategies

## Task 1: Git Reset — Hands-On

### Simulated Commit History
```
git init practice-repo && cd practice-repo

# Commit A
echo "feature A" > file.txt && git add . && git commit -m "Commit A"

# Commit B
echo "feature B" >> file.txt && git add . && git commit -m "Commit B"

# Commit C
echo "feature C" >> file.txt && git add . && git commit -m "Commit C"
```

Log before reset:
```
* c3f1a2b (HEAD -> main) Commit C
* b2e0f1a Commit B
* a1d9e0c Commit A
```

---

### `git reset --soft HEAD~1`
```bash
git reset --soft HEAD~1
```
**What happens:**
- HEAD moves back to Commit B
- Changes from Commit C remain **staged** (in the index)
- Working directory is **unchanged**
- `git status` shows: "Changes to be committed"

**Observation:** It's like un-committing but keeping everything staged — ready to re-commit immediately.

---

### `git reset --mixed HEAD~1` (default)
```bash
git add . && git commit -m "Commit C (re-done)"
git reset --mixed HEAD~1   # or just: git reset HEAD~1
```
**What happens:**
- HEAD moves back one commit
- Changes are **unstaged** (removed from index)
- Working directory is **unchanged**
- `git status` shows: "Changes not staged for commit"

**Observation:** Changes are back in the working directory but need `git add` before recommitting.

---

### `git reset --hard HEAD~1`
```bash
git add . && git commit -m "Commit C (re-done again)"
git reset --hard HEAD~1
```
**What happens:**
- HEAD moves back one commit
- Staged changes are **wiped**
- Working directory changes are **wiped**
- `git status` shows: "nothing to commit, working tree clean"

**Observation:** Commit C's changes are completely gone from both staging and working directory.

---

### Answers

**Difference between `--soft`, `--mixed`, and `--hard`:**

| Flag | HEAD | Index (Staged) | Working Directory |
|------|------|----------------|-------------------|
| `--soft` | Moves back | Unchanged (staged) | Unchanged |
| `--mixed` | Moves back | Cleared | Unchanged |
| `--hard` | Moves back | Cleared | **Cleared** |

**Which one is destructive and why?**
`--hard` is destructive because it permanently erases changes from both the staging area and the working directory. There is no undo unless you use `git reflog` to find the lost commit hash within the reflog's expiry window (~90 days).

**When would you use each one?**
- `--soft` — When you want to undo a commit but keep everything staged (e.g., to squash commits or fix a commit message with more control than `git commit --amend`)
- `--mixed` — When you want to undo a commit and unstage changes so you can selectively re-stage them (default behaviour, most common)
- `--hard` — When you want to completely discard recent commits and all their changes (e.g., throw away a bad experiment)

**Should you ever use `git reset` on commits that are already pushed?**
**No — avoid it on shared/public branches.** When you reset and force-push (`git push --force`), you rewrite history that others have already pulled. This causes diverged histories and forces teammates to reconcile their local branches manually. It can lead to lost work and confusion. Use `git revert` instead for pushed commits.

> **Safety net:** `git reflog` records every HEAD movement. Even after a `--hard` reset, you can recover lost commits with:
> ```bash
> git reflog
> git checkout -b recovery-branch <lost-commit-hash>
> ```

---

## Task 2: Git Revert — Hands-On

### Simulated Commits
```bash
echo "X" > file.txt && git add . && git commit -m "Commit X"
echo "Y" >> file.txt && git add . && git commit -m "Commit Y"
echo "Z" >> file.txt && git add . && git commit -m "Commit Z"
```

Log:
```
* 9z8y7x6 (HEAD -> main) Commit Z
* 5y4x3w2 Commit Y
* 1a2b3c4 Commit X
```

### Reverting the Middle Commit (Y)
```bash
git revert 5y4x3w2
```
Git opens an editor with a default message: `Revert "Commit Y"`. After saving:

**What happens:**
- A **new commit** is created that undoes the changes introduced by Commit Y
- Commit Y is **still in the history**
- The file no longer contains line "Y", but history is intact

### `git log` after revert:
```
* d1e2f3a (HEAD -> main) Revert "Commit Y"
* 9z8y7x6 Commit Z
* 5y4x3w2 Commit Y   ← still here!
* 1a2b3c4 Commit X
```

**Is Commit Y still in history?** ✅ Yes. Revert does not remove commits; it adds a new one.

---

### Answers

**How is `git revert` different from `git reset`?**
- `git reset` moves the HEAD pointer backward, effectively removing commits from history (rewrites history)
- `git revert` adds a new commit that applies the inverse of a previous commit — history is preserved, and the undo is itself recorded as a commit

**Why is revert considered safer than reset for shared branches?**
Because it **doesn't rewrite history**. Everyone who has pulled the branch still has a valid, linear history. The revert commit simply adds a new change on top — no force push required, no diverged histories, no risk of overwriting teammates' work.

**When would you use revert vs reset?**

| Situation | Use |
|-----------|-----|
| Undo a pushed commit on a shared branch | `git revert` |
| Undo a local-only commit before pushing | `git reset` |
| Quickly discard experimental local work | `git reset --hard` |
| Undo a specific old commit in the middle of history | `git revert <hash>` |
| Squash/clean up local commits before PR | `git reset --soft` |

---

## Task 3: Reset vs Revert — Summary

| | `git reset` | `git revert` |
|---|---|---|
| **What it does** | Moves HEAD backward, optionally discarding staged/working changes | Creates a new commit that undoes the changes of a specified commit |
| **Removes commit from history?** | ✅ Yes (rewrites history) | ❌ No (preserves history, adds new commit) |
| **Safe for shared/pushed branches?** | ❌ No — requires force push, causes diverged history for others | ✅ Yes — non-destructive, safe to push normally |
| **When to use** | Local cleanup before pushing; discarding experimental work | Undoing pushed commits; undoing specific historical changes on shared branches |

---

## Task 4: Branching Strategies

---

### 1. GitFlow

**How it works:**
GitFlow defines a strict branching model with multiple long-lived branches and dedicated roles for each.

- `main` — production-ready code only
- `develop` — integration branch; all features merge here
- `feature/*` — one branch per feature, branched from `develop`
- `release/*` — branched from `develop` when ready to prep a release; only bugfixes allowed
- `hotfix/*` — branched from `main` to quickly patch production; merged back to both `main` and `develop`

**Text Diagram:**
```
main      ────●────────────────────────●──────────●────
               \                      /↑hotfix   /
develop   ──────●──────────●──────────●──────────●────
                \          /↑feature  \          /↑release
feature         ────────────            ──────────
```

**When/where it's used:**
- Software with versioned releases (e.g., mobile apps, desktop software, libraries)
- Teams with formal QA and staging environments
- Projects shipping discrete v1.0, v2.0 releases

**Pros:**
- Very structured and predictable
- Clear separation between production, staging, and active dev
- Good for parallel release management

**Cons:**
- Complex — many branches to manage
- Slow; merges can be frequent and messy
- Overkill for small teams or continuous deployment

---

### 2. GitHub Flow

**How it works:**
Simple, lightweight. Only one long-lived branch (`main`) plus short-lived feature branches. Deploy directly from `main`.

1. Branch off `main` with a descriptive name
2. Commit changes to the branch
3. Open a Pull Request
4. Review and discuss
5. Merge to `main` → deploy immediately

**Text Diagram:**
```
main    ──────●────────────────────●───────────────●────
               \                  /↑PR merge       /↑PR merge
feature-auth   ──●──●──●──────────                /
fix-login                         ──●──●──────────
```

**When/where it's used:**
- Web apps and SaaS products with CI/CD pipelines
- Startups and small-to-medium teams
- Projects that deploy continuously (multiple times a day)
- GitHub itself uses this model

**Pros:**
- Simple and easy to understand
- Fast — shorter feedback cycles
- Encourages small, frequent PRs
- Works great with CI/CD automation

**Cons:**
- No built-in release management
- Requires solid CI/CD and automated testing to stay stable
- Less structured for managing multiple simultaneous versions

---

### 3. Trunk-Based Development (TBD)

**How it works:**
All developers commit directly to `main` (the "trunk") or use very short-lived feature branches (lifespan < 1–2 days). Feature flags are used to hide incomplete features in production.

1. Pull latest `main`
2. Make a small, complete change
3. Push directly to `main` (or open a short-lived PR)
4. CI runs; if green, changes are live
5. Larger incomplete features are hidden behind feature flags

**Text Diagram:**
```
main    ──●──●──●──●──●──●──●──●──●──●──●──
          ↑  ↑  ↑  ↑  ↑  ↑  ↑
         Dev A  B  A  C  B  A  (all committing to trunk)
```

**When/where it's used:**
- Elite engineering teams (Google, Facebook, Netflix)
- Projects with mature CI/CD pipelines and high test coverage
- Teams practising continuous delivery / continuous deployment
- Google has used TBD across its monorepo for years

**Pros:**
- Eliminates merge hell — no long-lived branches diverging
- Forces small, incremental commits (better code quality)
- Fastest possible deployment cycle
- Naturally encourages feature flags and incremental delivery

**Cons:**
- Requires high discipline and test coverage
- Feature flags add complexity
- Hard to adopt on teams without CI/CD maturity
- Mistakes can reach production quickly if pipelines aren't solid

---

### Strategy Recommendations

**Which strategy for a startup shipping fast?**
**GitHub Flow.** It's simple, encourages continuous deployment, and doesn't impose overhead. Startups need to move fast and iterate — GitHub Flow lets teams ship multiple times a day with minimal ceremony. Add a CI/CD pipeline and it works beautifully.

**Which strategy for a large team with scheduled releases?**
**GitFlow.** Large teams often have formal QA cycles, staged rollouts, and the need to maintain multiple active versions simultaneously. GitFlow's structured branches (develop, release, hotfix) map well to this kind of workflow.

**Which one does a popular open-source project use?**
Checking the **React** repository on GitHub (github.com/facebook/react):
React uses a **GitHub Flow-inspired** model. They have a `main` branch, feature branches, and PRs. Release branches exist (e.g., `0.14-stable`) for maintaining older versions, which adds a slight GitFlow flavour for long-term support — but day-to-day development follows GitHub Flow's simple branch → PR → merge pattern.

The **Kubernetes** project uses a more sophisticated variant closer to **GitFlow**, with `main`, `release-x.y` branches, and a formal release cycle managed by release teams.

---

## Summary & Key Takeaways

1. **`git reset`** rewrites history and should only be used on local, unpushed commits. It's powerful but dangerous on shared branches.

2. **`git revert`** is always safe for shared branches because it adds a new commit rather than removing history.

3. **`git reflog`** is your safety net — it tracks every movement of HEAD, letting you recover from even a `--hard` reset.

4. **Branching strategy depends on team size and deployment model:**
   - Startup / fast CI-CD → **GitHub Flow**
   - Large team / scheduled releases → **GitFlow**
   - Elite team / maximum velocity → **Trunk-Based Development**


   # Git Commands Reference — Days 22–25
> A comprehensive reference covering setup, daily workflow, branching, remotes, merging, stashing, and undoing changes.

---

## 1. Setup & Config

```bash
# Set your identity
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# Set default editor
git config --global core.editor "code --wait"   # VS Code
git config --global core.editor "vim"            # Vim

# Set default branch name
git config --global init.defaultBranch main

# View all config
git config --list

# View a specific setting
git config user.email

# Store credentials (avoid re-typing password)
git config --global credential.helper store

# Initialize a new repo
git init

# Clone an existing repo
git clone <url>
git clone <url> <directory>        # Clone into a specific folder
git clone --depth 1 <url>          # Shallow clone (latest snapshot only)
```

---

## 2. Basic Workflow

### Staging & Committing

```bash
# Check status of working tree
git status
git status -s                        # Short/compact format

# Stage files
git add <file>                       # Stage a specific file
git add .                            # Stage everything in current directory
git add -p                           # Interactively stage hunks (partial staging)

# Unstage a file (keeps changes in working dir)
git restore --staged <file>

# Commit
git commit -m "Your message"
git commit -am "Message"             # Stage tracked files + commit in one step
git commit --amend                   # Edit the last commit (message or content)
git commit --amend --no-edit         # Amend last commit without changing message

# Discard changes in working directory (destructive!)
git restore <file>
git checkout -- <file>               # Older syntax, same effect
```

### Viewing History & Diffs

```bash
# Log
git log
git log --oneline                    # Compact one-line format
git log --oneline --graph --all      # Visual branch graph
git log -n 5                         # Last 5 commits
git log --author="Name"
git log --since="2 weeks ago"
git log --follow <file>              # Track renames

# Diff
git diff                             # Unstaged changes vs last commit
git diff --staged                    # Staged changes vs last commit
git diff <branch1> <branch2>         # Diff between branches
git diff <commit1> <commit2>         # Diff between two commits

# Show a specific commit
git show <commit-hash>
git show HEAD                        # Show latest commit
```

---

## 3. Branching

```bash
# List branches
git branch                           # Local branches
git branch -a                        # All branches (local + remote)
git branch -v                        # With last commit info

# Create a branch
git branch <name>
git checkout -b <name>               # Create + switch (classic)
git switch -c <name>                 # Create + switch (modern)

# Switch branches
git checkout <name>
git switch <name>                    # Modern syntax

# Rename a branch
git branch -m <old> <new>
git branch -m <new>                  # Rename current branch

# Delete a branch
git branch -d <name>                 # Safe delete (merged only)
git branch -D <name>                 # Force delete (unmerged)

# Delete a remote-tracking branch
git branch -dr origin/<name>
```

---

## 4. Remote

```bash
# View remotes
git remote -v

# Add a remote
git remote add origin <url>
git remote add upstream <url>        # For forks: add original repo

# Rename / remove a remote
git remote rename origin newname
git remote remove <name>

# Fetch (download without merging)
git fetch origin
git fetch --all                      # Fetch all remotes

# Pull (fetch + merge)
git pull
git pull origin main
git pull --rebase origin main        # Pull with rebase instead of merge

# Push
git push origin <branch>
git push -u origin <branch>          # Set upstream tracking
git push --force-with-lease          # Safer force push (checks remote state)
git push --force                     # Dangerous: overwrites remote history

# Push tags
git push origin --tags

# Forking workflow
# 1. Fork on GitHub
# 2. Clone your fork: git clone <fork-url>
# 3. Add upstream: git remote add upstream <original-url>
# 4. Keep in sync:
git fetch upstream
git merge upstream/main
```

---

## 5. Merging & Rebasing

### Merging

```bash
# Fast-forward merge (linear history)
git merge <branch>

# No fast-forward (always creates a merge commit)
git merge --no-ff <branch>

# Abort an in-progress merge
git merge --abort

# After resolving conflicts manually:
git add <resolved-file>
git merge --continue

# Squash all commits from branch into one staged change
git merge --squash <branch>
```

### Rebasing

```bash
# Rebase current branch onto main
git rebase main

# Interactive rebase (last N commits)
git rebase -i HEAD~3                  # Opens editor to squash/reorder/edit

# Interactive rebase options:
# pick   = keep commit as-is
# reword = keep commit, edit message
# squash = combine with previous commit
# fixup  = combine, discard this message
# drop   = remove commit entirely

# Abort a rebase
git rebase --abort

# Continue after resolving conflicts
git rebase --continue
```

**Merge vs Rebase:**
| | Merge | Rebase |
|---|---|---|
| History | Preserves branch topology | Creates linear history |
| Shared branches | ✅ Safe | ❌ Don't rebase public branches |
| PR cleanup | `--squash` | `--interactive` |

---

## 6. Stash & Cherry-Pick

### Stash

```bash
# Save current changes to stash
git stash
git stash push -m "WIP: my feature"  # With a label

# List stashes
git stash list

# Apply most recent stash (keeps stash)
git stash apply

# Apply and remove stash
git stash pop

# Apply a specific stash
git stash apply stash@{2}

# Drop a specific stash
git stash drop stash@{1}

# Clear all stashes
git stash clear

# Stash including untracked files
git stash -u
```

### Cherry-Pick

```bash
# Apply a specific commit to current branch
git cherry-pick <commit-hash>

# Cherry-pick a range of commits
git cherry-pick <hash1>^..<hash2>    # Inclusive range

# Cherry-pick without auto-committing
git cherry-pick -n <commit-hash>

# Abort cherry-pick
git cherry-pick --abort

# Continue after resolving conflicts
git cherry-pick --continue
```

---

## 7. Reset & Revert

### Understanding the Three Trees
Git manages three areas:
- **HEAD** — the last commit snapshot
- **Index (Staging Area)** — what will go into the next commit
- **Working Directory** — actual files on disk

### Git Reset

```bash
# Soft reset — moves HEAD, keeps index staged
git reset --soft HEAD~1
git reset --soft <commit-hash>

# Mixed reset (default) — moves HEAD, clears index, keeps working dir
git reset HEAD~1
git reset --mixed HEAD~1
git reset --mixed <commit-hash>

# Hard reset — moves HEAD, clears index AND working directory ⚠️ DESTRUCTIVE
git reset --hard HEAD~1
git reset --hard <commit-hash>

# Unstage a file (non-destructive)
git reset HEAD <file>
git restore --staged <file>          # Modern syntax
```

**Reset Behaviour Summary:**

| Flag | HEAD | Index | Working Dir | Destructive? |
|------|------|-------|-------------|--------------|
| `--soft` | ✅ Moves | Unchanged | Unchanged | No |
| `--mixed` | ✅ Moves | ✅ Cleared | Unchanged | No |
| `--hard` | ✅ Moves | ✅ Cleared | ✅ Cleared | **Yes** |

> ⚠️ **Never reset commits that have been pushed to a shared branch.** Use `git revert` instead.

### Git Revert

```bash
# Revert a specific commit (creates a new "undo" commit)
git revert <commit-hash>

# Revert without opening editor
git revert <commit-hash> --no-edit

# Revert a range of commits
git revert <oldest-hash>..<newest-hash>

# Stage the revert without committing (then commit manually)
git revert -n <commit-hash>

# Abort an in-progress revert
git revert --abort
```

### Reset vs Revert Comparison

| | `git reset` | `git revert` |
|---|---|---|
| What it does | Moves HEAD backward, optionally discards changes | Creates a new commit undoing specified changes |
| Rewrites history? | ✅ Yes | ❌ No |
| Safe for pushed branches? | ❌ No | ✅ Yes |
| Use case | Local cleanup, discarding unpushed work | Undoing changes on shared/remote branches |

### Reflog — Your Safety Net

```bash
# View full history of HEAD movements (including resets!)
git reflog

# Recover a lost commit after hard reset
git reflog                           # Find the hash
git checkout -b recovery <hash>      # Recover to a new branch
git reset --hard <hash>              # Or reset current branch back

# Reflog entries expire after ~90 days by default
```

---

## 8. Tags

```bash
# Lightweight tag
git tag v1.0

# Annotated tag (recommended for releases)
git tag -a v1.0 -m "Version 1.0 release"

# Tag a past commit
git tag -a v0.9 <commit-hash>

# List tags
git tag
git tag -l "v1.*"                    # Filter by pattern

# Push a tag
git push origin v1.0
git push origin --tags               # Push all tags

# Delete a tag
git tag -d v1.0                      # Local
git push origin --delete v1.0        # Remote
```

---

## 9. Useful Utilities

```bash
# Find which commit introduced a bug (binary search)
git bisect start
git bisect bad                       # Current commit is bad
git bisect good <known-good-hash>    # Last known good commit
# Git checks out midpoint; test and mark:
git bisect good / git bisect bad
git bisect reset                     # When done

# See who last modified each line of a file
git blame <file>
git blame -L 10,20 <file>            # Specific line range

# Search commit messages
git log --grep="bug fix"

# Search code changes
git log -S "function_name"           # Pickaxe search

# Clean untracked files
git clean -n                         # Dry run (show what would be deleted)
git clean -f                         # Delete untracked files
git clean -fd                        # Delete untracked files and directories
```

---

## Branching Strategy Quick Reference

| Strategy | Best For | Key Branches | Deploy From |
|---|---|---|---|
| **GitHub Flow** | Startups, CI/CD, continuous deploy | `main` + feature branches | `main` |
| **GitFlow** | Scheduled releases, large teams | `main`, `develop`, `feature/*`, `release/*`, `hotfix/*` | `main` |
| **Trunk-Based** | Elite teams, maximum velocity | `main` (short-lived feature branches optional) | `main` |