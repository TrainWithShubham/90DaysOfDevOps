# Day 23 – Git Branching & Working with GitHub

## Task 1: Understanding Branches
### 1 What is a branch in Git?
A branch in Git is like a separate copy of your project where you can work safely.

Think of it like this:

If your project is a road, then a branch is another lane where you can drive without disturbing the main traffic.

By default, Git creates a branch called `main`.  
You can create new branches to work on new features or fixes.

---

### 2 Why do we use branches instead of committing everything to `main`?

We use branches to keep our main project safe.

If we do all work directly in `main`:
- We might break the project
- Bugs can affect everyone
- It becomes hard to manage changes

Branches help us:
- Work on new features safely
- Fix bugs without breaking the main code
- Allow multiple people to work at the same time
- Test changes before adding them to `main`

After testing, we merge the branch into `main`.

---

### 3 What is `HEAD` in Git?

`HEAD` is like a pointer that tells Git:

"Where am I right now?"

It points to:
- The current branch you are working on
- The latest commit in that branch

If you switch branches, `HEAD` moves to that branch.

You can check your current branch using:

git branch

The branch with `*` is where `HEAD` is pointing.

---

### 4 What happens to your files when you switch branches?

When you switch branches:

- Git changes your project files to match that branch.
- Some files may appear.
- Some files may disappear.
- Some files may look different.

This happens because each branch can have different changes.

Important:
If you have uncommitted changes, Git may not allow you to switch branches.  
You must commit or stash your changes first.

---

## Difference Between origin and upstream

### 🔹 origin

- `origin` is your own GitHub repository.
- When you connect your local project to GitHub, Git automatically names it `origin`.
- You usually push your code to `origin`.

Example:

git push origin main

Here, `origin` means my GitHub repository.

---

### 🔹 upstream

- `upstream` is the original repository.
- It is mostly used when you fork someone else's project.
- You use `upstream` to get updates from the original project.

Example:

git fetch upstream

---

### Simple Meaning

- origin = My repository  
- upstream = Original repository

---

## Difference Between git fetch and git pull

### git fetch

- Downloads new changes from GitHub.
- Does NOT automatically merge them.
- Safe command.
- Lets you review changes first.

Example:
git fetch origin

---

### git pull

- Downloads changes from GitHub.
- Automatically merges them into your current branch.
- It is a combination of:
  git fetch + git merge

Example:
git pull

---

### Simple Difference

git fetch = Get changes only  
git pull = Get changes + merge automatically

---

## Difference Between Clone and Fork

### Clone

- Makes a local copy of a repository.
- Does NOT create a copy on your GitHub account.
- Used when you just want to download and work locally.

Example:
git clone repo-url

---

### Fork

- Creates a copy of someone else's repository on your GitHub account.
- Used when you want to contribute to a project.
- You get full control of your fork.

Fork happens on GitHub website, not in terminal.

---

## When to Use Clone vs Fork?

Clone:
- When working on your own repo
- When you only need local copy

Fork:
- When contributing to open-source
- When you do not have write access to original repo

---

## After Forking — Keep Fork in Sync

Step 1: Add original repo as upstream

git remote add upstream original-repo-url

Step 2: Fetch updates

git fetch upstream

Step 3: Merge updates

git merge upstream/main

Now your fork is updated.