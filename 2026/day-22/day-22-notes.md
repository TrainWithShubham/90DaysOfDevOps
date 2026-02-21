# Day 22 – Introduction to Git: Your First Repository

## Task 1: Install and Configure Git
- Verify Git is installed on your machine
- Set up your Git identity — name and email
- Verify your configuration

<img width="632" height="208" alt="image" src="https://github.com/user-attachments/assets/eb498e14-7410-4fb3-b460-33a0e47fb945" />
<img width="678" height="293" alt="image" src="https://github.com/user-attachments/assets/d2d2a957-7d25-4964-9248-7916e4c91e2d" />
<img width="760" height="476" alt="image" src="https://github.com/user-attachments/assets/e4bce497-4d9e-49b6-9e80-86cfa45e5626" />

## Task 2:  Create Your Git Project
- Create a new folder called devops-git-practice
- Initialize it as a Git repository
- Check the status — read and understand what Git is telling you
- Explore the hidden .git/ directory — look at what's inside
  
<img width="1076" height="703" alt="image" src="https://github.com/user-attachments/assets/389a723b-b593-4962-84a3-27afd2335eae" />

## Task 3: Create Your Git Commands Reference
- Create a file called git-commands.md inside the repo
- Add the Git commands you've used so far, organized by category:
- Setup & Config
- Basic Workflow
- Viewing Changes
- For each command, write:
- What it does (1 line)
- An example of how to use it

Ans: Written in another .md file

## Task 4: Stage and Commit
- Stage your file
- Check what's staged
- Commit with a meaningful message
- View your commit history

<img width="976" height="976" alt="image" src="https://github.com/user-attachments/assets/2196c9c9-a1b5-4066-8252-c3569f17c56a" />

## Task 5: Make More Changes and Build History
- Edit git-commands.md — add more commands as you discover them
- Check what changed since your last commit
- Stage and commit again with a different, descriptive message
- Repeat this process at least 3 times so you have multiple commits in your history
- View the full history in a compact format

git-commit.md is ongoing process.

<img width="726" height="427" alt="image" src="https://github.com/user-attachments/assets/33871acc-e6ae-41e1-8578-4ec60951b3cb" />

## Task 6: Understand the Git Workflow

### 1. What is the difference between `git add` and `git commit`?

**Answer:**

- `git add` stages changes for the next commit.
- `git commit` saves those staged changes permanently to the repository history.

---

### 2. What does the staging area do? Why doesn't Git just commit directly?

**Answer:**

The staging area (also called the **index**) is an intermediate space where you select and prepare specific changes before committing them.

Git doesn’t commit directly because it allows you to:
- Selectively stage changes.
- Organize related changes into clean, meaningful commits.
- Avoid committing everything at once.

---

### 3. What information does `git log` show?

**Answer:**

`git log` shows:

- Commit ID (SHA hash)
- Author name
- Date of commit
- Commit message

---

### 4. What is the `.git/` folder and what happens if you delete it?

**Answer:**

The `.git/` folder contains all the repository data, including:

- Commit history
- Branch information
- Configuration
- Object database

If you delete the `.git/` folder:

- All commit history will be permanently lost.
- The project will no longer be a Git repository.
- It becomes a normal folder with no version tracking.

---

### 5. What is the difference between Working Directory, Staging Area, and Repository?

**Answer:**

- **Working Directory** – Your project files where you make changes.
- **Staging Area (Index)** – Temporary area where you select changes before committing.
- **Repository (`.git/`)** – Stores all committed versions and project history permanently.




