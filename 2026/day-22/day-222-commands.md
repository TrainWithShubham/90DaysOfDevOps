# Git Commands Reference

> A living document of Git commands — updated daily as I learn more.
> Started: Day 22 | Last Updated: Day 22

---

## Setup & Config

| Command | What It Does | Example |
|--------|--------------|---------|
| `git --version` | Checks the installed Git version | `git --version` → `git version 2.43.0` |
| `git config --global user.name` | Sets your global Git username | `git config --global user.name "Jane Dev"` |
| `git config --global user.email` | Sets your global Git email | `git config --global user.email "jane@example.com"` |
| `git config --list` | Lists all Git configuration settings | `git config --list` |
| `git config --global core.editor` | Sets the default editor for commit messages | `git config --global core.editor "vim"` |

---

## Repository Setup

| Command | What It Does | Example |
|--------|--------------|---------|
| `git init` | Initializes a new Git repository in the current folder | `git init` |
| `git clone` | Copies a remote repository to your local machine | `git clone https://github.com/user/repo.git` |

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
| `git log --oneline --graph` | Shows history as an ASCII branch graph | `git log --oneline --graph` |
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

## Exploring the Repository

| Command | What It Does | Example |
|--------|--------------|---------|
| `ls -la .git/` | Lists the contents of the hidden .git directory | `ls -la .git/` |
| `cat .git/HEAD` | Shows which branch you're currently on | `cat .git/HEAD` |
| `cat .git/config` | Shows repository-level Git config | `cat .git/config` |

---

*More commands will be added in upcoming days as new topics are covered.*