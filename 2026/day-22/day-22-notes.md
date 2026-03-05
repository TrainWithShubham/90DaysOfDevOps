# Day 22 – Git Fundamentals Notes

## 1. Difference between `git add` and `git commit`

| Command | Explanation | Example |
|-------|-------------|---------|
| `git add` | Moves file changes from the working directory to the staging area. It prepares files to be included in the next commit. | `git add file.txt` |
| `git commit` | Saves the staged changes permanently in the repository with a message describing the changes. | `git commit -m "Added new feature"` |

---

## 2. What does the Staging Area do?

The **staging area** is an intermediate step between the working directory and the repository.

Purpose of staging area:
- Lets developers review changes before committing
- Helps organize commits logically
- Allows committing only selected files instead of everything

Without a staging area, Git would commit every change directly, which would make commit history messy.

---

## 3. What information does `git log` show?

`git log` displays the history of commits in a repository.

It shows:
- Commit ID (unique hash)
- Author name
- Date and time of the commit
- Commit message

What is the .git/ folder and what happens if you delete it?

The .git/ folder is the hidden directory where Git stores all repository data.

It contains:

Commit history

Branch information

Configuration settings

Object database

If the .git/ folder is deleted, the directory will no longer be a Git repository, and all version history will be lost.


Example:
```bash
git log  What is the difference between a working directory, staging area, and repository?

Working Directory
This is where you edit and modify your project files.

Staging Area
This is a temporary place where changes are prepared before committing.

Repository
This is the database where Git permanently stores all commits and project history.
