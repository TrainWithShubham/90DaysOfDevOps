# Day 23 – Git Branching & Working with GitHub

---

## Task 1: Understanding Branches

### 1. What is a branch in Git?

A branch is a lightweight, movable pointer to a specific commit in your repository's history. Under the hood it's just a 41-byte file in `.git/refs/heads/` that stores a commit hash. When you make a new commit on a branch, that pointer automatically advances to the new commit.

The default branch is usually called `main` (or historically `master`). Every other branch you create diverges from some point in that history and evolves independently.

```
main:      A → B → C
                     \
feature-1:            D → E
```

Branches `main` and `feature-1` share commits A, B, C, but only `feature-1` has D and E.

---

### 2. Why do we use branches instead of committing everything to `main`?

Committing everything directly to `main` means:
- Incomplete or broken code is immediately part of the "official" history
- Multiple people working simultaneously will constantly conflict with each other
- There's no way to experiment without risking the stable codebase
- Code review becomes impossible — there's nothing to review against

Branches solve all of this. Each feature, bug fix, or experiment lives in its own isolated timeline. `main` only ever receives code that has been finished, tested, and reviewed. This is the foundation of every professional Git workflow (GitHub Flow, Gitflow, trunk-based development, etc.).

---

### 3. What is `HEAD` in Git?

`HEAD` is a special pointer that always tells Git *"where you are right now."* It normally points to the current branch, which in turn points to the latest commit on that branch.

```
HEAD → main → commit C
```

When you switch branches, `HEAD` moves to point at the new branch:

```
git switch feature-1
HEAD → feature-1 → commit E
```

**Detached HEAD** is a special state where `HEAD` points directly to a commit hash instead of a branch name. This happens when you `git checkout <commit-hash>`. Any commits you make in this state are not attached to a branch and will be garbage-collected by Git unless you create a branch from them.

You can always check where HEAD is pointing:
```bash
cat .git/HEAD
# → ref: refs/heads/main
```

---

### 4. What happens to your files when you switch branches?

Git replaces the contents of your working directory to match the snapshot recorded in the tip commit of the branch you're switching to. Files that exist on the new branch but not the old one appear; files that exist on the old branch but not the new one disappear; files that differ between branches are updated in place.

Git will **refuse** to switch branches if you have uncommitted changes that would be overwritten by the switch. Your options are to:
- `git stash` — temporarily shelve your changes
- `git commit` — commit them first
- `git restore .` — discard them (destructive)

---

## Task 2: Branching Commands — Hands-On

### List all branches
```bash
git branch
# Output:
# * main        ← the asterisk shows your current branch
```

```bash
git branch -a   # Also shows remote-tracking branches
# * main
#   remotes/origin/main
```

---

### Create `feature-1` and switch to it (two steps)
```bash
git branch feature-1        # Create the branch
git switch feature-1        # Switch to it
# Switched to branch 'feature-1'
```

---

### Create `feature-2` and switch in one command
```bash
git switch -c feature-2
# Switched to a new branch 'feature-2'
```

> The classic equivalent is `git checkout -b feature-2`. Both do the same thing.

---

### `git switch` vs `git checkout` — what's the difference?

`git checkout` is a Swiss Army knife command introduced early in Git's history — it does too many things:
- Switch branches: `git checkout feature-1`
- Restore files: `git checkout -- file.txt`
- Detach HEAD to a commit: `git checkout a1b2c3`

This overloading made it confusing, especially for beginners (`checkout` a file and `checkout` a branch look identical but have very different effects).

Git 2.23 (2019) introduced two focused replacements:
- **`git switch`** — only for switching and creating branches
- **`git restore`** — only for discarding file changes

`git switch` will refuse operations that `git checkout` would silently do in confusing ways. For day-to-day branch work, always prefer `git switch`.

---

### Make a commit on `feature-1` that doesn't exist on `main`
```bash
git switch feature-1

# Edit a file — e.g., add a note to the bottom of git-commands.md
echo "\n## Branching (added on feature-1)" >> git-commands.md

git add git-commands.md
git commit -m "feat: add branching section stub on feature-1"
```

---

### Switch back to `main` and verify the commit is not there
```bash
git switch main
git log --oneline

# Output (feature-1's commit is NOT here):
# f3a91bc Add undoing changes section to git-commands
# 7d2e04a Add viewing changes and log commands
# a1c88f0 Add basic workflow commands
# 3b6d711 Initial commit: add git-commands reference
```

Opening `git-commands.md` in your editor confirms the branching section added on `feature-1` is absent — the file is exactly as it was on `main`.

---

### Delete a branch
```bash
# Safe delete — Git refuses if the branch has unmerged commits
git branch -d feature-2

# Force delete — use when you intentionally want to discard unmerged work
git branch -D feature-2
```

---

## Task 3: Push to GitHub

### Connect local repo to GitHub remote
```bash
# After creating a new EMPTY repo on GitHub (no README, no .gitignore):
git remote add origin https://github.com/<your-username>/devops-git-practice.git

# Verify the remote was added
git remote -v
# origin  https://github.com/<your-username>/devops-git-practice.git (fetch)
# origin  https://github.com/<your-username>/devops-git-practice.git (push)
```

### Push `main` to GitHub
```bash
git push -u origin main
# -u sets the upstream tracking reference so future `git push` needs no arguments
```

### Push `feature-1` to GitHub
```bash
git switch feature-1
git push -u origin feature-1
```

Both branches are now visible in the GitHub UI under the branch dropdown.

---

### `origin` vs `upstream` — what's the difference?

These are just **remote nicknames** (aliases for URLs). Git doesn't enforce their meaning, but the community follows a strong convention:

| Name | Points To | When It's Used |
|------|-----------|----------------|
| `origin` | **Your own remote copy** of the repo (your GitHub repo) | Always — set automatically by `git clone` |
| `upstream` | **The original source repo** you forked from | Open-source contribution workflows |

**Example scenario:** You fork `torvalds/linux` on GitHub. Your fork is `yourname/linux`.

```bash
git clone https://github.com/yourname/linux.git
# origin → https://github.com/yourname/linux.git  (set automatically)

git remote add upstream https://github.com/torvalds/linux.git
# upstream → https://github.com/torvalds/linux.git  (set manually)
```

You push your feature branches to `origin` (your fork) and open pull requests from there. You pull new updates from `upstream` (the real repo) to keep your fork current.

---

## Task 4: Pull from GitHub

### Make a change on GitHub and pull it locally
```bash
# After editing a file directly in the GitHub web editor and committing it there:

git pull origin main
# or simply, if upstream is set:
git pull
```

---

### `git fetch` vs `git pull` — what's the difference?

Both communicate with the remote, but they do different amounts of work:

**`git fetch`** downloads new commits and updates remote-tracking refs (like `origin/main`) but **does not touch your working directory or current branch**. Your local `main` is unchanged.

```bash
git fetch origin
# Updates origin/main pointer — your local main is untouched

git log origin/main --oneline   # Inspect what came down
git diff main origin/main       # See what's different
git merge origin/main           # Merge manually when ready
```

**`git pull`** is `git fetch` + `git merge` in one command. It downloads the changes and immediately merges them into your current branch.

```bash
git pull origin main
# Equivalent to: git fetch origin && git merge origin/main
```

**When to use which:**

| Scenario | Use |
|----------|-----|
| You want to see what changed before integrating | `git fetch` |
| You're on a personal branch and just want the latest | `git pull` |
| You're working in a team and want to review before merging | `git fetch` |
| Quick sync on a clean branch | `git pull` |

The rule of thumb: `fetch` is safer and more deliberate; `pull` is faster and more convenient.

---

## Task 5: Clone vs Fork

### Clone a public repo
```bash
git clone https://github.com/github/gitignore.git
cd gitignore
git log --oneline -5
```

### Fork then clone your fork
1. Go to `https://github.com/github/gitignore` in the browser
2. Click **Fork** → it creates `yourname/gitignore` on GitHub
3. Clone your fork:
```bash
git clone https://github.com/yourname/gitignore.git
cd gitignore
git remote add upstream https://github.com/github/gitignore.git
```

---

### Clone vs Fork — what's the difference?

**Clone** is a **Git operation** — it creates a local copy of any repository on your machine. You can clone any repo you have access to. Cloning doesn't create anything on GitHub; it's purely local. You can push back only if you have write access.

**Fork** is a **GitHub concept** (not a Git command) — it creates your own personal copy of someone else's repository *on GitHub, under your account*. You have full write access to your fork, but not to the original. Forks are how the open-source contribution model works.

| | Clone | Fork |
|---|-------|------|
| Where it happens | Local machine | GitHub (server-side) |
| Git command? | Yes — `git clone` | No — GitHub UI or API |
| Creates GitHub repo? | No | Yes (under your account) |
| Need write access to original? | For pushing, yes | No |
| Primary use case | Working on repos you own or have access to | Contributing to someone else's project |

---

### When to clone vs fork?

**Clone** when:
- It's your own repo or your team's repo
- You have write access and will push directly

**Fork** when:
- You want to contribute to an open-source project you don't own
- You want your own sandbox copy of a project on GitHub
- You'll submit a Pull Request back to the original

---

### Keeping your fork in sync with the original

The original repo keeps moving — new commits get added after you fork. To stay current:

```bash
# 1. Add the original as 'upstream' (one-time setup)
git remote add upstream https://github.com/original-owner/repo.git

# 2. Fetch new commits from upstream (doesn't touch your files)
git fetch upstream

# 3. Merge upstream's main into your local main
git switch main
git merge upstream/main

# 4. Push the updated main to your GitHub fork
git push origin main
```

This keeps your fork's `main` identical to the original. Your feature branches are unaffected until you choose to rebase or merge them.

---

## Updated `git-commands.md` sections added today

See `git-commands.md` for the new **Branching** and **Remote & GitHub** sections.

---

*Day 23 complete — branches, remotes, fork vs clone, fetch vs pull all locked in.*