# Git Commands Reference (Days 22–25)

---

# 1. Setup & Config

## Check Git Version
git --version

## Configure Username
git config --global user.name "Your Name"

## Configure Email
git config --global user.email "your@email.com"

## Check Configuration
git config --list

## Initialize Repository
git init

---

# 2. Basic Workflow

## Check Status
git status

## Add File
git add filename

## Add All Files
git add .

## Commit Changes
git commit -m "Commit message"

## View Commit History
git log
git log --oneline

## See Changes (Not Staged)
git diff

## See Staged Changes
git diff --staged

---

# 3. Branching

## List Branches
git branch

## Create New Branch
git branch branch-name

## Switch Branch (Old Way)
git checkout branch-name

## Switch Branch (Recommended)
git switch branch-name

## Create and Switch
git switch -c branch-name

## Delete Branch
git branch -d branch-name

---

# 4. Remote Repository

## Clone Repository
git clone repository-url

## Check Remotes
git remote -v

## Add Remote
git remote add origin repository-url

## Push to Remote
git push origin main

## Pull Changes
git pull origin main

## Fetch Changes
git fetch origin

## Fork
Fork is done from GitHub UI (not a Git command)

---

# 5. Merging & Rebasing

## Merge Branch
git merge branch-name

## Rebase Branch
git rebase branch-name

## Abort Rebase
git rebase --abort

## Resolve Merge Conflict
- Edit conflicting file
- git add file
- git commit

---

# 6. Stash & Cherry Pick

## Save Work in Progress
git stash

## List Stashes
git stash list

## Apply Stash
git stash apply

## Apply and Remove Stash
git stash pop

## Cherry Pick Commit
git cherry-pick commit-hash

---

# 7. Reset & Revert

## Soft Reset
git reset --soft HEAD~1
- Removes commit
- Keeps changes staged

## Mixed Reset (Default)
git reset --mixed HEAD~1
- Removes commit
- Keeps changes unstaged

## Hard Reset
git reset --hard HEAD~1
- Removes commit
- Deletes changes

## Revert Commit
git revert commit-hash
- Creates new commit
- Safe for pushed branches

---

# Quick Rules

Local mistake (not pushed) → git reset  
Pushed commit mistake → git revert  
Team project → Avoid reset on shared branches  
Need temporary save → git stash  
Need one specific commit → git cherry-pick