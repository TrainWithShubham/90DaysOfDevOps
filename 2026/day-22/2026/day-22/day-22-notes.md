# Day 22 – Introduction to Git: Your First Repository

## Challenge Tasks

### Task 1: Install and Configure Git
1. Verify Git is installed on your machine
2. Set up your Git identity — name and email
3. Verify your configuration

![git](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-22/git_config.png)

### Task 2: Create Your Git Project
1. Create a new folder called `devops-git-practice`
2. Initialize it as a Git repository
3. Check the status — read and understand what Git is telling you
4. Explore the hidden `.git/` directory — look at what's inside

![git](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-22/git21.png)

---

### Task 3: Create Your Git Commands Reference
1. Create a file called `git-commands.md` inside the repo
2. Add the Git commands you've used so far, organized by category:
   - **Setup & Config**
   - **Basic Workflow**
   - **Viewing Changes**
3. For each command, write:
   - What it does (1 line)
   - An example of how to use it


## Setup & Config

  ### git init
  - Initializes a new Git repository.
  - **Example**: 
      ```bash
      git init 
      ```
  ### git config
  - Configures Git username or email.
  - **Example**:
    ```bash
        git config --global user.name "Your Name"
        git config --global user.email "Your Email"
     ```
  - View Config Values
    - **Example**:
      ```bash
        git config --global --list
      ```

## Basic Workflow

  ### git add
  - Stages files for commit.
  - **Example**:
      ```bash
      git add git-commands.md
      ```

  ### git commit
  - Save staged changes with a message explaining what you changed.
  - **Example**:
      ```bash
      git commit -m "Add git commands reference"
      ```

  ## Viewing Changes

  ### git status
  - Lists which files are modified and not yet stage
  - **Example**:
      ```bash
      git status
      ```

  ### git log
  - Shows the history of commits in your repository who changed what,when,and why.
  - Its also shows Commit hash,Author name & email,Date,Commit message
  - **Example**:
      ```bash
      git log
      ```

### Task 4: Stage and Commit
1. Stage your file
2. Check what's staged
3. Commit with a meaningful message
4. View your commit history

```bash
  git add git-command.md
  git status
  
  On branch master
  No commits yet
      Changes to be committed:
        (use "git rm --cached <file>..." to unstage)
        new file: git-command.md
        
  git commmit -m "Initial git command reference"
  
```


---

### Task 5: Make More Changes and Build History
1. Edit `git-commands.md` — add more commands as you discover them
2. Check what changed since your last commit
3. Stage and commit again with a different, descriptive message
4. Repeat this process at least **3 times** so you have multiple commits in your history
5. View the full history in a compact format

![git](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-22/git22.png)

---

### Task 6: Understand the Git Workflow
Answer these questions in your own words (add them to a `day-22-notes.md` file):
1. What is the difference between `git add` and `git commit`?
- `git add` tells Git which changes you want to include in the next commit. It moves changes to the staging area.
- `git commit` saves staged changes with a message explaining what you changed.

2. What does the **staging area** do? Why doesn't Git just commit directly?
- The staging area is like a waiting room for changes. You choose what to include in your next commit.
- Git doesn't commit directly so you can decide exactly which changes to save and organize your commits better.

3. What information does `git log` show you?
- `git log` shows a history of commits in your repository.
- It includes the commit ID, author, date, and commit message for each change.

4. What is the `.git/` folder and what happens if you delete it?
- The `.git/` folder stores all Git information for your project: commits, branches, tags, and configuration.
- If you delete it, Git will no longer track your project, and you will lose all version history

5. What is the difference between a **working directory**, **staging area**, and **repository**?
- **Working Directory:** Where you make and see changes to your files.
- **Staging Area:** Where you put changes you want to commit.
- **Repository:** Where Git stores all committed changes permanently.
