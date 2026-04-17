# Git Commands Reference

> A living document of Git commands — updated daily as I learn more.
> Started: Day 22 | Last Updated: Day 23

---

## Setup & Config

| Command | What It Does | Example |
|--------|--------------|---------|
| `git --version` | Checks the installed Git version | `git --version` |
| `git config --global user.name` | Sets your global Git username | `git config --global user.name "Jane Dev"` |
| `git config --global user.email` | Sets your global Git email | `git config --global user.email "jane@example.com"` |
| `git config --list` | Lists all Git configuration settings | `git config --list` |
| `git config --global core.editor` | Sets the default editor for commit messages | `git config --global core.editor "vim"` |

---

## Repository Setup

| Command | What It Does | Example |
|--------|--------------|---------|
| `git init` | Initializes a new Git repository in the current folder | `git init` |
| `git clone <url>` | Copies a remote repository to your local machine | `git clone https://github.com/user/repo.git` |

---

## Basic Workflow

| Command | What It Does | Example |
|--------|--------------|---------|
| `git status` | Shows the state of working directory and staging area | `git status` |
| `git add <file>` | Stages a specific file for the next commit | `git add git-commands.md` |
| `git add .` | Stages all changed files in the current directory | `git add .` |
| `git commit -m` | Records staged changes with a message | `git commit -m "Add git commands reference"` |
| `git commit --amend` | Modifies the most recent commit | `git commit --amend -m "Better message"` |

---

## Viewing Changes

| Command | What It Does | Example |
|--------|--------------|---------|
| `git log` | Shows the full commit history with details | `git log` |
| `git log --oneline` | Shows compact one-line commit history | `git log --oneline` |
| `git log --oneline --graph` | Shows history as an ASCII branch graph | `git log --oneline --graph --all` |
| `git diff` | Shows unstaged changes since the last commit | `git diff` |
| `git diff --staged` | Shows changes that are staged for commit | `git diff --staged` |
| `git show <commit>` | Shows details and changes of a specific commit | `git show a1b2c3d` |

---

## Undoing Changes

| Command | What It Does | Example |
|--------|--------------|---------|
| `git restore <file>` | Discards unstaged changes in a file | `git restore notes.md` |
| `git restore --staged <file>` | Unstages a file (keeps changes in working dir) | `git restore --staged notes.md` |
| `git revert <commit>` | Creates a new commit that undoes a previous commit | `git revert a1b2c3d` |

---

## Branching

| Command | What It Does | Example |
|--------|--------------|---------|
| `git branch` | Lists all local branches; asterisk marks current | `git branch` |
| `git branch -a` | Lists local and remote-tracking branches | `git branch -a` |
| `git branch <name>` | Creates a new branch (stays on current branch) | `git branch feature-1` |
| `git switch <name>` | Switches to an existing branch | `git switch feature-1` |
| `git switch -c <name>` | Creates a new branch and switches to it in one step | `git switch -c feature-2` |
| `git checkout -b <name>` | Older equivalent of `git switch -c` | `git checkout -b feature-2` |
| `git branch -d <name>` | Safely deletes a branch (refuses if unmerged) | `git branch -d feature-2` |
| `git branch -D <name>` | Force-deletes a branch regardless of merge status | `git branch -D feature-2` |
| `git merge <branch>` | Merges the named branch into the current branch | `git merge feature-1` |

---

## Remote & GitHub

| Command | What It Does | Example |
|--------|--------------|---------|
| `git remote add <name> <url>` | Connects your local repo to a remote | `git remote add origin https://github.com/user/repo.git` |
| `git remote -v` | Lists all configured remotes and their URLs | `git remote -v` |
| `git remote remove <name>` | Removes a remote connection | `git remote remove upstream` |
| `git push -u origin <branch>` | Pushes a branch to remote and sets upstream tracking | `git push -u origin main` |
| `git push` | Pushes current branch to its tracked remote branch | `git push` |
| `git fetch` | Downloads changes from remote without merging | `git fetch origin` |
| `git pull` | Fetches and merges remote changes into current branch | `git pull origin main` |

---

## Exploring the Repository

| Command | What It Does | Example |
|--------|--------------|---------|
| `ls -la .git/` | Lists the contents of the hidden .git directory | `ls -la .git/` |
| `cat .git/HEAD` | Shows which branch/commit HEAD currently points to | `cat .git/HEAD` |
| `cat .git/config` | Shows repository-level Git config | `cat .git/config` |

---

*More commands will be added in upcoming days as new topics are covered.*