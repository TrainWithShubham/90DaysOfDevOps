### Day 23 – Git Branching & Working with GitHub
----

### Task 1: Understanding Branches

- [x] What is a branch in Git?
**Answer:** A branch in Git is a separate line of development in a repository. It allows you to work on new features, bug fixes, or experiments without affecting the main codebase.

- [x] Why do we use branches instead of committing everything to main?
**Answer:** Branches help teams develop features safely, collaborate efficiently, and keep the main codebase stable.


- [x] What is HEAD in Git?
**Answer:** 
- HEAD in Git is a pointer that indicates the current commit or branch you are working on.

- HEAD = the reference to the latest commit in the current branch.
-  When you make a new commit, HEAD moves forward
    to that new commit.

- [x] What happens to your files when you switch branches?
**Answer:**

- When switching branches, Git:

- Updates files to match the selected branch

- Keeps committed work safe

- May block switching if uncommitted changes conflict

- Adds or removes files based on the branch state
------


#### Task 2: Branching Commands — Hands-On


- [x]  List all branches in  repo


- [x] Create a new branch called feature-1 


- [x] Switch to feature-1
- [x] Create a new branch and switch to it in a single command — call it feature-2
- [x] Try using git switch to move between branches — how is it different from git checkout?


**git switch:** git switch is a newer command introduced in Git 2.23 specifically for switching branches.
  
**git checkout:** git checkout is an older command with multiple purposes. It can:

- Switch branches

- Restore files

- Move to a specific commit (detached HEAD)

- [x] Make a commit on feature-1 that does not exist on main
- [x] Switch back to main — verify that the commit from feature-1 is not there
- [x] Delete a branch you no longer need


<img src="images/2-1-new.png" width="700">

<img src="images/2-2.png" width="700">

<img src="images/2-3.png" width="700">


<img src="images/2-4.png" width="700">






----
#### Task 3: Push to GitHub


- [x] Create a new repository on GitHub (shoould NOT be  initialized with README)
- [x] Connecting local devops-git-practice repo to the GitHub remote
- [x] Push local main branch to GitHub
-[x] Push feature-1 branch to GitHub
-[x] Verify both branches are visible on GitHub

  <img src="images/3-1.png" width="700">


 - [x] What is the difference between origin and upstream?
 
 
 **Answer:**
 **origin:** origin is the default name for the remote repository you cloned from.

**upstream:** upstream usually refers to the original repository that your fork came from.

 ------


### Task 4: Pull from GitHub
- [x] Make a change to a file directly on GitHub (use the GitHub editor)
- [x]  Pull that change to your local repo


  <img src="images/4-1-1(new).png" width="700">

    <img src="images/4-1(new).png" width="700">


  <img src="images/4-1.png" width="700">

  <img src="images/4-2.png" width="700">

- [x] What is the difference between git fetch and git pull?

**Answer:**

**git fetch:** git fetch downloads changes from the remote repository but does NOT merge them into your current branch.

It only updates your remote-tracking branches.

**git pull:** git pull downloads changes AND immediately merges them into your current branch.

Its actually  **git fetch + git merge**



------
#### Task 5: Clone vs Fork


- [x] Clone any public repository from GitHub to your local machine
- [x] Fork the same repository on GitHub, then clone your fork

 
  <img src="images/Task5-1.png" width="700">

  <img src="images/5-2.png" width="700">


- [x] What is the difference between clone and fork?

**Answer:**

| Feature               | Clone             | Fork                                   |
| --------------------- | ----------------- | -------------------------------------- |
| Where copy is created | Your computer     | Your GitHub account                    |
| Used for              | Local development | Contributing to someone else's project |
| Requires GitHub UI    |  No              | Yes                                  |
| Pull request workflow | Not required    | Usually used                         |



- [x] When would you clone vs fork?


**Answer:**
- Use clone when you want a local copy of a repository you already have permission to work on.

- Use fork when you want to contribute to someone else's repository but don't have write access.

This is common in open-source projects.
- [x] After forking, how do you keep your fork in sync with the original repo?

**Answer:**

After forking a repository, your fork does not automatically get updates from the original repo. To keep it in sync,  the upstream remote is used with the following commands.

- git fetch upstream
- git switch main
- git rebase upstream/main
- git push origin main


-----
