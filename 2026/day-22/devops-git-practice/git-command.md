# Git Local SetUp

- Check git version

`git -v`

- If git is not installed

`sudo apt update`

`sudo apt install git`

- Setup git configuration

`git config --global user.name "chaitanya kolse"`

`git config --global user.email "chaitayakolse738@gmail.com"`

# Git Commands

| Command | Usage | Example |
|----------|----------|----------|
| `git init` | initialize a repo inside directory | `git init` |
| `git clone <url>` | clone an existing repo | `git clone https://github.com/chaitanya738-art/90DaysOfDevOps.git` |
| `git add file` | add untracked files | `git add demo.txt` |
| `git commit` | make a commit | `git commit -m "added demo.txt"` |
| `git reset file` | unstage a file | `git reset demo.txt` |
| `git status` | check if anything to commit/add | `git status` |
| `git log` | check commit history | `git log` |
| `git diff` | show unstaged changes | `git diff` |
| `git restore file` | discard local changes | `git restore demo.txt` |
| `git branch` | list all branches | `git branch` |
| `git branch feature` | create a new branch | `git branch feature` |
| `git checkout feature` | switch branch | `git checkout feature` |
| `git checkout -b feature` | create and switch branch | `git checkout -b feature` |
| `git merge feature` | merge branch into current branch | `git merge feature` |
| `git remote -v` | view remote repositories | `git remote -v` |
| `git push origin master` | push changes to GitHub | `git push origin master` |
| `git pull origin master` | pull latest changes | `git pull origin master` |
| `git fetch` | download remote changes | `git fetch` |
| `git stash` | temporarily save changes | `git stash` |
| `git stash pop` | restore stashed changes | `git stash pop` |
| `git revert <commit-id>` | creates new commit that undoes changes made by given commit | `git revert abc123` |
| `git tag` | list tags | `git tag` |
