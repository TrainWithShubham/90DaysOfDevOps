# Day 12 Answers: Deep Dive in Git & GitHub for DevOps Engineers

## Find the answers by your understandings (Shouldn't be copied from the internet & use hand-made diagrams) of the questions below and write a blog on it.

1. What is Git and why is it important?
   - **Git** is a distributed version control system that allows multiple developers to work on a project simultaneously without overwriting each other's changes. It helps track changes in source code during software development, enabling collaboration, version control, and efficient management of code changes.

   **Importance of Git:**
     - **Version Control:** Keeps track of changes, allowing you to revert to previous versions if needed.
     - **Collaboration:** Multiple developers can work on the same project simultaneously.   
     - **Branching:** Allows you to work on different features or fixes in isolation.  
     - **Backup::** Acts as a backup of your codebase. 

2. What is the difference between Main Branch and Master Branch?
   - Traditionally, **master** was the default branch name in Git repositories. However, many communities have moved to using **main** as the default branch name to be more inclusive and avoid potentially offensive terminology.
   
   - Main Branch vs. Master Branch:
     -  **Main Branch:** The new default branch name used in many modern repositories.
     - **Master Branch:** The traditional default branch name used in older repositories.

     The traditional default branch name used in older repositories.


3. Can you explain the difference between Git and GitHub?
   - **Git** is a version control system, while **GitHub** is a web-based platform that uses Git for version control and adds collaboration features like pull requests, issue tracking, and project management.
      - Git:
        - Command-line tool.
        - Manages local repositories.
      - GitHub:
        - Hosting service for Git repositories.
        - Adds collaboration tools and user interfaces.

4. How do you create a new repository on GitHub?
   1. Go to GitHub.
   2. Click on the + icon in the top right corner.
   3. Select New repository.
   4. Enter a repository name (e.g., "DevOps").
   5. Click Create repository. 

5. What is the difference between a local & remote repository? How to connect local to remote?
   - Local Repository:
     - Stored on your local machine.
     - Contains your working directory and Git database. 
   - Remote Repository:
     - Hosted on a server (e.g., GitHub).
     - Allows collaboration with other developers.
   - Connecting Local to Remote:
     1. Initialize a local repository: `git init`
     2. Add a remote: `git remote add origin <URL>`

## Tasks with Answers

### Task 1:
- Set your user name and email address, which will be associated with your commits.

**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day12/image/set_user_name_and_email_address.png)

### Task 2:
- Create a repository named "DevOps" on GitHub.

**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day12/image/create_a_new_repository.png)

- Connect your local repository to the repository on GitHub.

**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day12/image/connect_your_local_repository_to_the_repository_on_github.png)

- Create a new file in Devops/Git/Day-12.txt & add some content to it.

**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day12/image/create_a_new_file.png)

- Push your local commits to the repository on GitHub.

**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day12/image/push_repository.png)

**After that if you check it on GitHub then it's output will look like this**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day12/image/gitui.png)

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day12/image/gitui1.png)

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day12/image/gitui2.png)


[LinkedIn](https://www.linkedin.com/in/bhavin-savaliya/)
