# Git Commands Reference

---

## Setup & Config

### git --version
What it does: Displays the installed Git version.  
Example:
```bash
git --version
```

### git config --global user.name
What it does: Sets your global Git username.  
Example:
```bash
git config --global user.name "Shiv0311"
```

### git config --global user.email
What it does: Sets your global Git email address.  
Example:
```bash
git config --global user.email "shivkumarkonnuri@gmail.com"
```

---

## Basic Workflow

### git init
What it does: Initializes a new Git repository in the current directory.  
Example:
```bash
git init
```

### git status
What it does: Shows the current state of the working directory and staging area.  
Example:
```bash
git status
```

---

## Viewing Changes

### git log
What it does: Displays commit history.  
Example:
```bash
git log
```

### git log --oneline
What it does: Shows commit history in compact format.  
Example:
```bash
git log --oneline
```

### git add
What it does: It moves the changes from working directory to staging. 
Example: 
```bash
git add filename
```

### git commit
What it does: It moves the changes from staging to repository(history).
Example:
```bash
git commit -m "Message"
```

### git diff
What it does: It finds out what changes are made to the file.
Example:
```bash
git diff
```

### git show
What it does: It shows the last commit details along with the changes related to that commit
Example:
```bash
git show
```

### git branch
What it does: It lists the branches
Example:
```bash
git branch
```

### git switch
What it does: It switches the branch
Example:
```bash
git switch <branch-name>
```

### git pull
What it does: It pulls the contents of the branch from the remote repository
Example:
```bash
git pull origin feature-1
```

