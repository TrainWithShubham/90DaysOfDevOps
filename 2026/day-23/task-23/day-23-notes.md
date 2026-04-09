# Day 23 – Git Branching & Working with GitHub
## Task 1: Understanding Branches
## 1. What is a branch in Git?

A branch in Git is a separate line of development that allows developers to work on new features, fixes, or experiments without affecting the main project. Each branch has its own commits and history until it is merged back.

---

## 2. Why do we use branches instead of committing everything to main?

Branches help keep the main branch stable and production-ready. Developers can work on new features or bug fixes in separate branches without breaking the main codebase. Once the changes are tested and ready, they can be merged into the main branch.

---
## 3. What is HEAD in Git?

HEAD is a pointer that tells Git which branch or commit you are currently working on. Most of the time, HEAD points to the latest commit on the current branch.

Example:
If you are on the main branch, HEAD points to the latest commit on main.    

## 4. What happens to your files when you switch branches?

When you switch branches, Git updates the files in your working directory to match the version stored in that branch. Files may change, appear, or disappear depending on what exists in that branch.

## Task 2: Branching Commands — Hands-On
- List all branches in your repo
```
git branch
```
- Create a New Branch Called feature-1
```
git branch feature-1
```
- Switch to feature-1
```
git checkout feature-1
```
## Create a new branch and switch to it in a single command — call it feature-2
```
- git checkout -b feature-2
```
## Try using git switch to move between branches — how is it different from git checkout?
```
git switch feature -1
```
## Difference Between checkout and switch
- git checkout - Older command used for switching branches AND restoring files
- git switch - Newer command used only for switching branches, simpler and safer

## Make a Commit on feature-1 (Not on Main)
- git switch feature-1
- ### git branch
Lists all branches in the repository.
Example:
git branch

- git add git-commands.md
- git commit -m "Add branching commands documentation"
- Switch Back to main and Verify - The commit from feature-1 is NOT in main.

- Delete a Branch You No Longer Need
```
git branch -D feature-2
```
## Task 3: Push to GitHub
- What is origin? - origin is the default name for the main remote repository that your local repo is connected to. When you clone a repository, Git automatically creates origin.
-Example:
```
git clone https://github.com/user/project.git
git remote -v
you will see:
origin  https://github.com/user/project.git (fetch)
origin  https://github.com/user/project.git (push)
```
- So origin usually means:Your GitHub repository where you push your code, eg: git push origin main

- What is upstream? - upstream is usually used when you fork someone else's repository.
In this case:

origin → your forked repository
upstream → the original repository you forked from
```
- Example structure:
Original repo (someone else's project)
        ↑
     upstream
        ↑
Your fork on GitHub
        ↑
      origin
        ↑
   Your local machine
   ```
   ## Task 4: Pull from GitHub
  - What is the difference between git fetch and git pull?
  - git fetch downloads the latest changes from the remote repository but does NOT modify your local working files. It only updates the remote tracking branches. Fetch means download updates only.
  - git pull downloads changes AND immediately merges them into your current branch.

## Task 5: Clone vs Fork
- What is the difference between clone and fork?
Clone creates a copy of a repository from GitHub (or another remote) to your local machine.
You use it when you want to download a repository and start working on it locally.
```
GitHub Repository
        │
        │ git clone
        ▼
Your Local Machine
```
Clone = copy repo from remote → local machine

- A fork creates a copy of someone else's repository in your own GitHub account.
You usually fork a project when you do not have write access to the original repository but want to contribute.
Forking is done on GitHub's website, not through a Git command.

- When would you clone vs fork?
Use clone when you want to work directly on a repository you have access to.
- This is common in:
Your own repositories
Team/company projects
Internal projects where you already have write permission
```
GitHub Repo
      │
      │ git clone
      ▼
Local Machine
      │
      │ commit + push
      ▼
Same Repository
```
- Use fork when you want to contribute to a repository but you do NOT have write access.

This is common in:
Open-source projects
External repositories
Projects owned by other organizations
-You cannot push directly.
So you:
1️⃣ Fork the repository
2️⃣ Clone your fork
3️⃣ Push changes to your fork
4️⃣ Create a Pull Request
```
Original Repo
      │
      │ fork
      ▼
Your GitHub Repo
      │
      │ clone
      ▼
Local Machine
      │
      │ push
      ▼
Your Fork
      │
      │ Pull Request
      ▼
Original Repo
```
- After forking, how do you keep your fork in sync with the original repo?
To keep your fork updated with the original repository, you need to connect the original repo as upstream and pull changes from it. 
## Step 1: Clone Your Fork
- First, clone your fork from GitHub:
``` git clone https://github.com/YOUR-USERNAME/repository-name.git ```
- Step 2: Add the Original Repository as upstream
``` git remote add upstream https://github.com/ORIGINAL-OWNER/repository-name.git ```
-check remotes:
``` git remote -v ```
Example o/p- 
``` 
origin   https://github.com/YOUR-USERNAME/repository-name.git
upstream https://github.com/ORIGINAL-OWNER/repository-name.git
```
- Step 3: Fetch Changes from the Original Repo - Download updates from the original repo:
```git fetch upstream``` This downloads changes but does not merge them yet.
-Step 4: Update Your Local Branch - Switch to the main branch:
``` git switch main ``
Merge updates from upstream:
``` git merge upstream/main ``` Now your local repo has the latest changes.
- Step 5: Push Updates to Your Fork - Update your fork on GitHub:
``` git push origin main```
- Full Sync Workflow
```
git fetch upstream
git switch main
git merge upstream/main
git push origin main
```
```
Original Repo (upstream)
        │
        │ fetch
        ▼
Local Repository
        │
        │ push
        ▼
Your Fork (origin)
