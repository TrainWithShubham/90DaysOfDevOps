# 📚 Git Commands Reference

A quick reference guide for Git commands learned during Days 22–25 of the #90DaysOfDevOps journey.

---

# ⚙️ Setup & Configuration

| Command | Description |
|----------|-------------|
| `git config --global user.name "Your Name"` | Set Git username |
| `git config --global user.email "your@email.com"` | Set Git email |
| `git config --list` | View Git configuration |

---

# 📂 Basic Workflow

| Command | Description |
|----------|-------------|
| `git status` | Check repository status |
| `git add .` | Stage all changes |
| `git add <file>` | Stage a specific file |
| `git commit -m "message"` | Create a commit |
| `git log` | View detailed commit history |
| `git log --oneline` | View compact commit history |
| `git diff` | View unstaged changes |

---

# 🌿 Branching

| Command | Description |
|----------|-------------|
| `git branch` | List all branches |
| `git branch <branch-name>` | Create a branch |
| `git checkout <branch-name>` | Switch branch |
| `git checkout -b <branch-name>` | Create and switch branch |
| `git switch <branch-name>` | Switch branch using modern Git |
| `git branch -d <branch-name>` | Delete merged branch |
| `git branch -D <branch-name>` | Force delete branch |

---

# 🌐 Remote Repository

| Command | Description |
|----------|-------------|
| `git remote -v` | View remote repositories |
| `git remote add origin <repo-url>` | Add remote repository |
| `git clone <repo-url>` | Clone repository |
| `git push origin main` | Push changes |
| `git pull origin main` | Pull latest changes |
| `git fetch origin` | Download changes without merging |

---

# 🔀 Merge

| Command | Description |
|----------|-------------|
| `git merge <branch-name>` | Merge branch into current branch |
| `git merge --squash <branch-name>` | Squash multiple commits into one |

## Fast-Forward Merge

A fast-forward merge happens when the target branch has no new commits and Git simply moves the branch pointer forward.

```bash
git merge feature-login
```

## Merge Commit

A merge commit is created when both branches contain different commits.

```bash
git merge feature-signup
```

---

# 🔄 Rebase

| Command | Description |
|----------|-------------|
| `git rebase main` | Reapply commits on top of main |
| `git rebase --continue` | Continue after conflict resolution |
| `git rebase --abort` | Cancel rebase |

## Why Use Rebase?

- Creates a cleaner commit history
- Avoids unnecessary merge commits
- Makes the timeline linear and easy to understand

---

# 📦 Stash

| Command | Description |
|----------|-------------|
| `git stash` | Save uncommitted changes |
| `git stash push -m "message"` | Save stash with a custom message |
| `git stash list` | View all stashes |
| `git stash apply` | Apply stash without removing it |
| `git stash pop` | Apply stash and remove it |
| `git stash apply stash@{0}` | Apply a specific stash |

---

# 🍒 Cherry-Pick

| Command | Description |
|----------|-------------|
| `git cherry-pick <commit-id>` | Apply a specific commit |
| `git cherry-pick --continue` | Continue after resolving conflicts |
| `git cherry-pick --abort` | Cancel cherry-pick |

## Why Use Cherry-Pick?

Cherry-pick allows you to copy a specific commit from one branch to another without merging the entire branch.

Example:

```bash
git cherry-pick 7282ff3
```

---

# ⏪ Reset

| Command | Description |
|----------|-------------|
| `git reset --soft HEAD~1` | Remove commit, keep staged changes |
| `git reset --mixed HEAD~1` | Remove commit, keep unstaged changes |
| `git reset --hard HEAD~1` | Remove commit and delete changes |

## Reset Comparison

| Type | Commit Removed | Staged Changes | Working Directory |
|--------|---------------|---------------|------------------|
| Soft | ✅ | ✅ | ✅ |
| Mixed | ✅ | ❌ | ✅ |
| Hard | ✅ | ❌ | ❌ |

---

# ↩️ Revert

| Command | Description |
|----------|-------------|
| `git revert <commit-id>` | Safely undo a commit |
| `git revert --continue` | Continue after conflict resolution |
| `git revert --abort` | Cancel revert |

## Why Use Revert?

- Safe for shared repositories
- Preserves commit history
- Creates a new commit that reverses previous changes

Example:

```bash
git revert 1448a92
```

---

# 📊 Useful Log Commands

| Command | Description |
|----------|-------------|
| `git log --oneline` | Compact commit history |
| `git log --oneline -5` | Last 5 commits |
| `git log --oneline --graph --all` | Visualize branch history |

Example:

```bash
git log --oneline --graph --all
```

---

# ⚡ Git Workflow Summary

```text
Working Directory
        │
        ▼
   git add
        │
        ▼
   Staging Area
        │
        ▼
   git commit
        │
        ▼
   Local Repository
        │
        ▼
    git push
        │
        ▼
 Remote Repository (GitHub)
```

---

# 📝 Reset vs Revert

| Feature | Git Reset | Git Revert |
|----------|-----------|------------|
| Removes Commit History | ✅ | ❌ |
| Creates New Commit | ❌ | ✅ |
| Safe For Shared Branches | ❌ | ✅ |
| Best Use Case | Local commits | Shared repositories |

---

# 🎯 Key Takeaways

- Use **Branches** to isolate work.
- Use **Merge** to combine work.
- Use **Rebase** for a cleaner history.
- Use **Stash** to temporarily save work.
- Use **Cherry-Pick** to copy a specific commit.
- Use **Reset** to rewrite local history.
- Use **Revert** to safely undo changes in shared repositories.
- Use **Git Log Graph** to visualize branch history.

---
🚀 Built while learning Git through the #90DaysOfDevOps challenge.