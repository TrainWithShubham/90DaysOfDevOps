# Day 22 – Git Notes & Reflections

## Task 1: Install and Configure Git

```bash
# Verify Git is installed
git --version
# Output: git version 2.43.0 (or similar)

# Set up identity
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# Verify configuration
git config --list
```

---

## Task 2: Create Your Git Project

```bash
mkdir devops-git-practice
cd devops-git-practice
git init
git status
ls -la .git/
```

**What's inside `.git/`?**

```
.git/
├── HEAD          → points to the current branch (e.g., refs/heads/main)
├── config        → repository-specific settings
├── description   → used by GitWeb (not important locally)
├── hooks/        → scripts that run before/after Git events (e.g., pre-commit)
├── info/         → contains .gitignore patterns for this repo only
├── objects/      → where Git stores ALL your data (commits, trees, blobs)
└── refs/         → pointers to commit hashes (branches, tags)
```

The `.git/` folder is Git's brain — it stores the entire history and configuration of your repository.

---

## Task 4: Stage and Commit

```bash
git add git-commands.md        # Stage the file
git status                     # Verify what's staged
git commit -m "Initial commit: add git-commands reference"
git log                        # View commit history
```

---

## Task 5: Build Commit History

```bash
# After editing git-commands.md:
git diff                       # See what changed
git add git-commands.md
git commit -m "Add viewing changes section to git-commands"

# Repeat for more commits...
git log --oneline              # Compact history view
```

---

## Task 6: Conceptual Questions

### 1. What is the difference between `git add` and `git commit`?

`git add` moves changes from your **working directory** into the **staging area** — it's like placing items into a box before sealing it. `git commit` seals that box and permanently records it in the repository's history with a timestamp and message. You must `add` before you can `commit`; they are two separate, deliberate steps.

---

### 2. What does the staging area do? Why doesn't Git just commit directly?

The staging area (also called the "index") acts as a buffer between your work and your commit history. It lets you:

- **Selectively commit** — you might have changed 5 files but only want to commit 2 of them in this snapshot.
- **Review before committing** — you can inspect exactly what will go into the commit using `git diff --staged`.
- **Build meaningful commits** — group related changes together into one logical commit even if you made them at different times.

If Git committed every saved file immediately, your history would be noisy and hard to reason about. The staging area gives you intentional control.

---

### 3. What information does `git log` show you?

`git log` shows the complete commit history of the repository, displayed from newest to oldest. For each commit it shows:

- **Commit hash** — a unique 40-character SHA-1 identifier (e.g., `a3f8c2d...`)
- **Author** — the name and email of who made the commit
- **Date** — when the commit was recorded
- **Commit message** — the description written by the author

With flags like `--oneline` it compresses this to one line per commit; `--graph` adds an ASCII tree of branches.

---

### 4. What is the `.git/` folder and what happens if you delete it?

The `.git/` folder is the **entire Git repository**. It contains:
- All commit history (stored as compressed objects)
- Branch and tag references
- The staging area (index)
- Configuration and hooks

**If you delete `.git/`**, your project folder becomes a plain directory — all Git history, branches, and metadata are permanently gone. Your current files remain intact, but there is no way to recover the history without a remote backup (e.g., on GitHub). Git would treat the folder as if it had never been initialized.

---

### 5. What is the difference between a working directory, staging area, and repository?

These are the three zones Git manages:

| Zone | Also Called | What It Is |
|------|-------------|------------|
| **Working Directory** | Working Tree | Your actual project folder — files you see and edit on disk |
| **Staging Area** | Index / Cache | A "pre-commit" holding area where you place changes you want to include in the next commit |
| **Repository** | `.git/` directory | The permanent, compressed record of all committed snapshots in history |

**The typical flow:**

```
[Edit files]         →   Working Directory
[git add <file>]     →   Staging Area
[git commit -m "..."] →  Repository (permanent history)
```

Think of it like writing a letter: your draft is the working directory, your envelope (ready to seal) is the staging area, and the sent box is the repository.

---

## Sample `git log --oneline` Output

```
f3a91bc Add undoing changes section to git-commands
7d2e04a Add viewing changes and log commands
a1c88f0 Add basic workflow commands
3b6d711 Initial commit: add git-commands reference
```

---

*Day 22 complete. Git basics are in — history, staging, and commit workflow all make sense now.*