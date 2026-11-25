# Master Git Commands Cheat Sheet (Days 22-25)

## 1. Setup & Configuration
* `git config --global user.name "Your Name"`: Set username.
* `git config --global user.email "email@domain.com"`: Set email.

## 2. Basic Workflow
* `git status`: Check the state of the working directory.
* `git add <file>` / `git add .`: Stage changes.
* `git commit -m "message"`: Commit staged changes.
* `git log --oneline --graph --all`: View visual commit history.

## 3. Branching & Remote
* `git branch <name>`: Create a new branch.
* `git switch <name>` or `git checkout <name>`: Switch to a branch.
* `git switch -c <name>`: Create and switch instantly.
* `git clone <url>`: Download a remote repo.
* `git fetch`: Download remote changes without merging.
* `git pull origin main`: Fetch and merge changes.
* `git push origin <branch>`: Upload local commits to remote.

## 4. Advanced Git (Merge, Rebase, Squash)
* `git merge <branch>`: Combines histories (creates a diamond loop).
* `git merge --squash <branch>`: Condenses multiple commits into one before merging.
* `git rebase <branch>`: Moves feature commits to the tip of the base branch (creates a clean linear line).

## 5. Lifesavers (Stash & Cherry-Pick)
* `git stash`: Temporarily locks away uncommitted changes.
* `git stash pop`: Brings back the stashed changes.
* `git cherry-pick <commit-hash>`: Surgically extracts a specific commit and applies it to the current branch.

## 6. Damage Control (Reset, Revert, Reflog)
* `git reset --soft HEAD~1`: Undoes commit, keeps files staged.
* `git reset --mixed HEAD~1`: Undoes commit, unstages files (Default).
* `git reset --hard HEAD~1`: NUKES commit and deletes local changes.
* `git revert <commit-hash>`: Safely undoes a commit by creating a new inverse commit.
* `git reflog`: The ultimate safety net. Shows every action taken in Git, allowing you to recover even from a hard reset.
