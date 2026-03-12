## Day 22 – Introduction to Git: My First Repository
# Task 1: Install and Configure Git
<img width="583" height="376" alt="git1" src="https://github.com/user-attachments/assets/41913ef5-9d8b-4f55-acf1-472072ecb2a6" />

# Task 2: Create Your Git Project
<img width="832" height="265" alt="Screenshot 2026-03-11 052925" src="https://github.com/user-attachments/assets/e4bf8ed8-38e2-4e76-85bd-0246226224ce" />

<img width="706" height="58" alt="Screenshot 2026-03-11 061430" src="https://github.com/user-attachments/assets/90d0e1a5-c2bf-4842-8df7-0197ad208009" />

# Task 3: Create Your Git Commands Reference
## Git Commands Reference
# Setup & Config

- git --version , Shows the installed Git version.
```
git --version
```
- Sets your global Git username , git config --global user.name
```
git config --global user.name "Rahul Sharma"
```
- git config --global user.email
- Sets your global Git email address.
```
git config --global user.email "rahul@gmail.com"
```
- git config --list
- Displays all Git configuration settings.
```
git config --list
```
# Basic Workflow
- git init , Initializes a new Git repository.
```
git init
```
# mkdir , Creates a new directory.
```
mkdir devops-git-practice
```
# cd , Changes the current directory.
```
cd devops-git-practice
```
# touch , Creates a new file.
```
touch git-commands.md
```
# Viewing Changes - git status
- Shows the current status of the repository including tracked and untracked files.
```
git status
```
# Task 4: Stage and Commit- Staging & Committing

# git add - Adds files to the staging area.
```
git add git-commands.md
```
# git commit -m , Saves staged changes with a message.
```
git commit -m "Add git commands reference documentation"
```
![commit](image.png)
# git log - Displays commit history.
```
git log
```
# git log --oneline - Shows a compact version of commit history.
```
git log --oneline
```
![git oneline](image-1.png)

# Visual Git Workflow (Very Important)
```
Working Directory
        │
        │ git add
        ▼
Staging Area
        │
        │ git commit
        ▼
Git Repository (History)
```
## Task 5- Make More Changes and Build History
## Branching
# git branch - Shows all branches in the repository.
```
git branch
```
# git checkout - Switches to another branch.
```
git checkout main
```
# Task 6: Understand the Git Workflow
- Step 1: Create the Notes File
```
touch day-22-notes.md
```
- What is the difference between git add and git commit?
- Ans: git add moves changes from the working directory to the staging area. It prepares the files that will be included in the next commit. Git commit saves the staged changes into the Git repository as a permanent snapshot with a message explaining what changed.
- Example workflow:
```
git add file.txt
git commit -m "Added new feature"
```
- What does the staging area do? Why doesn't Git just commit directly?
- Ans: The staging area is a place where you prepare changes before committing them. It allows you to select exactly which changes should go into the next commit. Git uses a staging area so developers can group related changes together instead of committing everything at once.

- What information does git log show you?
- Ans: git log shows the commit history of the repository.
It includes:
- Commit ID (unique hash)
- Author name and email
- Date of the commit
- Commit message

- What is the .git/ folder and what happens if you delete it?
- Ans: The .git folder is the hidden directory that stores all Git data for the repository. It contains commits, branches, configuration, and history. If the .git folder is deleted, the project is no longer a Git repository and all version history is lost.

- What is the difference between a working directory, staging area, and repository?
- Working Directory  
This is the folder where you edit and create files on your computer.

Staging Area  
This is where files are prepared before committing. Files are added here using git add.

Repository  
This is where Git permanently stores committed versions of files along with the project history.
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
![git switch](image-3.png)
![git main](image.png)

- Delete a Branch You No Longer Need
```
git branch -D feature-2
```
