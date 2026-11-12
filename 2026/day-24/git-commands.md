# Git Commands Reference

## Setup & Config
* `git config --global user.name "rashid-khan681"` - Sets author name.
* `git config --global user.email "rk8539100@gmail.com"` - Sets author email.
* `git init` - Initializes a new Git repository.

## Basic Workflow
* `git status` - Shows the state of the working directory.
* `git add git-commands.md` - Stages a specific file.
* `git commit -m "docs: added setup and basic workflow commands"` - Commits changes.
* `git log --oneline` - Shows commit history.
* Note: This line was added directly from the GitHub UI.

## Advanced Operations (Day 24)
* `git merge <branch>` - Merges the specified branch into the current branch.
* `git merge --squash <branch>` - Combines all commits from the source branch into a single staged change.
* `git rebase <branch>` - Rewrites history by moving the base of your current branch to the tip of the specified branch.
* `git stash` or `git stash push -m "msg"` - Temporarily saves uncommitted work.
* `git stash list` - Lists all stashed changes.
* `git stash pop` - Applies the most recent stash and removes it from the list.
* `git stash apply stash@{n}` - Applies a specific stash but keeps it in the list.
* `git cherry-pick <commit-hash>` - Applies a specific commit from another branch to the current branch.
