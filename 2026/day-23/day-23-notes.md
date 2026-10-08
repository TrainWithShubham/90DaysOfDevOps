# Day 23 Notes – Git Branching & Working with GitHub

---

# 1. What is a branch in Git?

A branch in Git is like creating a separate workspace inside the same project.

It allows us to work on new features or test changes without affecting the main code.

---

# 2. Why do we use branches instead of committing everything to main?

If everyone works directly on `main`, it can break the project easily.

Branches help developers work safely and separately. After testing, changes can be merged into `main`.

This keeps the project stable and organized.

---

# 3. What is HEAD in Git?

`HEAD` shows the current branch or current commit where we are working.

It acts like a pointer in Git.

For example:

- if I am on `main`, HEAD points to `main`
- if I switch to `feature-1`, HEAD moves there

---

# 4. What happens to your files when you switch branches?

When switching branches, Git changes the files in the working directory based on that branch.

Files created in one branch may disappear in another branch if they were never committed there.

I tested this using `feature-1` branch.

---

# 5. Difference between git switch and git checkout

`git checkout` is the older command mostly used for switching branches.

`git switch` is the newer command made specifically for branch switching.

I mostly used `git checkout` because I was already comfortable with it.

Examples:

```bash id="eqwzbi"
git checkout feature-1
git checkout main
```

Modern alternative:

```bash id="ptv99y"
git switch feature-1
git switch main
```

---

# 6. Difference between origin and upstream

## origin

`origin` is my own GitHub repository connected to my local repo.

## upstream

`upstream` is the original repository from which a fork was created.

---

# 7. Difference between git fetch and git pull

## git fetch

Downloads latest changes from GitHub but does not merge them.

## git pull

Downloads changes and merges them automatically into the current branch.

---

# 8. Difference between clone and fork

## Clone

Creates a local copy of a repository on my computer.

## Fork

Creates my personal copy of someone else’s repository on GitHub.

---

# 9. When would you use clone vs fork?

I would use:

- `clone` when working on my own repository
- `fork` when contributing to someone else’s project

---

# 10. How do you keep your fork updated?

We can connect the original repository as upstream and pull latest changes.

Example:

```bash id="9x5h8m"
git remote add upstream <repo-url>
git pull upstream main
```

---

# Commands I Practiced Today

```bash id="mo8vii"
git branch
git checkout feature-1
git checkout main
git checkout -b feature-2
git branch -d feature-2
git push -u origin main
git push -u origin feature-1
git fetch
git pull
git clone <repo-url>
```

---

# What I Learned Today

- Branches help isolate work safely
- `git checkout` and `git switch` can both move between branches
- GitHub stores remote repositories
- `git pull` updates local repository from GitHub
- Fork and clone are different concepts
- Feature branches are very important in DevOps workflows
