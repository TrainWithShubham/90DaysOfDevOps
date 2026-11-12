# Git Commands Reference

## Setup & Config
* `git config --global user.name "Name"` - Sets the author name to be attached to your commits.
  * Example: `git config --global user.name "rashid-khan681"`
* `git config --global user.email "email"` - Sets the author email.
  * Example: `git config --global user.email "rk8539100@gmail.com"`
* `git init` - Initializes a new, empty Git repository in the current folder.
  * Example: `git init`

## Basic Workflow
* `git status` - Shows the state of the working directory and staging area.
  * Example: `git status`

## Viewing Changes
* `git diff` - Shows unstaged changes between your working directory and the staging area.
  * Example: `git diff`
* `git log` - Shows the commit history for the currently active branch.
  * Example: `git log --oneline`

## Undoing Changes
* `git checkout -- <file>` - Discards changes in the working directory.
  * Example: `git checkout -- file.txt`
