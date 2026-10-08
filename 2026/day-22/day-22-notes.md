# Day 22 Notes – Introduction to Git

---

## 1. What is the difference between `git add` and `git commit`?

`git add` moves changes to the staging area.

`git commit` saves those staged changes permanently into Git history.

Example:

* `git add` = preparing files
* `git commit` = saving snapshot

---

## 2. What does the staging area do? Why doesn't Git commit directly?

The staging area is a temporary place where we choose which changes should be included in the next commit.

Git does not commit directly because developers may want to organize changes into separate commits instead of saving everything together.

It helps keep commit history clean and meaningful.

---

## 3. What information does `git log` show?

`git log` shows:

* commit ID
* author name
* date and time
* commit message

It helps track project history and changes.

---

## 4. What is the `.git/` folder and what happens if you delete it?

The `.git/` folder stores:

* commits
* branches
* configuration
* repository history

It is the heart of the Git repository.

If we delete the `.git/` folder, the project will no longer be a Git repository and all Git history will be lost.

---

## 5. What is the difference between working directory, staging area, and repository?

### Working Directory

The place where we create and edit files normally.

---

### Staging Area

A temporary area where selected changes are prepared before committing.

---

### Repository

The place where committed project history is stored permanently by Git.

---

# Commands Practiced Today

```bash id="q3x10s"
git init
git status
git add .
git commit -m "message"
git log
git log --oneline
git diff
git config --list
```

---

# What I Learned Today

* Git is a version control system
* Git tracks file changes over time
* Commits create project history
* `git status` helps understand repository state
* The staging area prepares files before commit
* Git history helps developers collaborate safely

