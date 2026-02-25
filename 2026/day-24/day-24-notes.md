# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick
---

# Task 1: Git Merge

### What is a fast-forward merge?

A fast-forward merge happens when:

* The main branch has **no new commits**
* Git just moves the pointer forward

There is **no extra merge commit** created.

It looks like a straight line in history.

---

### When does Git create a merge commit?

Git creates a merge commit when:

* Both branches have new commits
* Their histories have split

Git combines them and creates a **new merge commit**.

History shows a branch joining back.

---

### What is a merge conflict?

A merge conflict happens when:

* The **same line of the same file**
* Was changed in both branches

Git cannot decide which change to keep.
You must manually fix it.

---

# Task 2: Git Rebase

### What does rebase do?

Rebase:

* Takes your branch commits
* Moves them on top of the latest main
* Rewrites commit history

It makes it look like you started from the newest version.

---

### How is rebase history different from merge?

Merge:

* Keeps branch structure
* Shows merge commits

Rebase:

* Makes history look clean
* Looks like one straight line
* No merge commit

---

### Why never rebase shared commits?

Because:

* Rebase changes commit history
* Other people may already have the old history
* It can break their work

Only rebase local (not shared) branches.

---

### When to use rebase vs merge?

Use **rebase**:

* To keep history clean
* Before merging your feature branch

Use **merge**:

* For shared branches
* When you want to preserve full history

---

# Task 3: Squash Commit vs Merge Commit

### What does squash merge do?

Squash:

* It Combines all commits into **one single commit**
* It Adds only 1 commit to main

---

### Regular merge

* It Keeps all commits
* It Adds a merge commit
* Full history is preserved

---

### When to use squash?

Use squash when:

* You made many small messy commits
* You want a clean history

---

### Trade-off of squash

You lose:

* Detailed commit history
* Step-by-step development info

---

# Task 4: Git Stash

### What happens if you try switching branches with changes?

Git may:

* Stop you
* It Say changes would be overwritten

---

### What is git stash?

Stash:

* It Saves unfinished work temporarily
* It Cleans your working directory

---

### Difference between `stash pop` and `stash apply`

`git stash pop`

* It Applies changes
* It Removes stash from list

`git stash apply`

* It Applies changes
* It Keeps stash in list

---

### When to use stash?

Use stash when:

* You need to quickly switch branches
* Your work is not ready to commit

---

# Task 5: Cherry Picking

### What does cherry-pick do?

Cherry-pick:

* It Takes **one specific commit**
* Applies it to another branch

Only that commit is copied.

---

### When to use cherry-pick?

Use when:

* You need one fix from another branch
* Example: hotfix for production

---

### What can go wrong?

* Merge conflicts
* Duplicate commits
* Messy history if overused

---

# Summary
| Feature          | What It Is                                | How It Works                                                      | Why We Use It                                         |
| ---------------- | ----------------------------------------- | ----------------------------------------------------------------- | ----------------------------------------------------- |
| **Fast-forward** | A simple type of merge                    | Git just moves the branch pointer forward (no new commit created) | Keeps history clean when no new commits exist on main |
| **Merge commit** | A special commit that joins two branches  | Git creates a new commit that connects both histories             | Used when both branches have new commits              |
| **Rebase**       | A way to move commits to a new base       | Takes your commits and replays them on top of latest main         | Creates clean, straight history                       |
| **Squash**       | A merge option that combines commits      | All branch commits become one single commit                       | Keeps main branch history simple and clean            |
| **Stash**        | Temporary storage for uncommitted changes | Saves your changes outside the branch                             | Useful when you need to switch branches quickly       |
| **Cherry-pick**  | A way to copy one specific commit         | Applies one selected commit to another branch                     | Useful for hotfixes or moving specific changes        |


---
