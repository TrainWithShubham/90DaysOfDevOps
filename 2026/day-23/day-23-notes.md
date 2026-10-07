# Day 23 - Git Branching & GitHub Workflow

## Task 1: Understanding Branches
1. **What is a branch in Git?**
   A branch is a lightweight, movable pointer to a specific commit. It provides an isolated workspace to develop features or fix bugs without affecting the `main` production codebase.
2. **Why do we use branches?**
   To ensure the main codebase remains stable. Multiple developers can work on different features simultaneously in their own branches and merge them only when tested and approved.
3. **What is HEAD in Git?**
   HEAD is a special pointer that indicates exactly which branch and commit your working directory is currently resting on.
4. **What happens to files when you switch branches?**
   Git physically updates the files in your working directory on your hard drive to match the exact snapshot of the branch you just switched to.

## Task 3, 4, & 5: Cloud Workflows
1. **What is the difference between `origin` and `upstream`?**
   `origin` refers to your personal remote repository on GitHub (usually a fork). `upstream` refers to the original source repository you forked from. 
2. **What is the difference between `git fetch` and `git pull`?**
   `git fetch` downloads remote changes to your local Git database but leaves your working files untouched so you can review them. `git pull` fetches the changes and instantly merges them into your current working directory.
3. **What is the difference between `clone` and `fork`?**
   A `fork` copies a repository from one GitHub account to another GitHub account. A `clone` downloads a repository from GitHub to your physical local machine.