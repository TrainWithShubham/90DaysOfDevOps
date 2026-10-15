# Day 22: Git Workflow Notes

**1. What is the difference between git add and git commit?**
- git add: It moves changes from your working directory to the staging area. It tells Git, "I want to include these specific changes in the next save."
- git commit: It takes everything in the staging area and permanently saves it as a snapshot in the local repository history with a descriptive message.

**2. What does the staging area do? Why doesn't Git just commit directly?**
The staging area (or index) acts as a buffer or waiting room. It allows developers to logically group related changes into a single commit rather than forcing them to commit every modified file all at once. It helps maintain a clean, organized commit history.

**3. What information does git log show you?**
It displays the chronological commit history of the active branch. It shows the unique commit ID (SHA-1 hash), the author's name and email, the timestamp, and the commit message.

**4. What is the .git/ folder and what happens if you delete it?**
The .git/ folder is the brain and database of the repository. It stores all the snapshots, branches, configuration settings, and history. If you delete it, you lose the entire version control history, and the project becomes just a standard, untracked folder again.

**5. What is the difference between a working directory, staging area, and repository?**
- Working Directory: The actual files on your machine that you are currently editing.
- Staging Area: The intermediate waiting room where you place files that are ready to be committed.
- Repository: The permanent local database where Git stores all your committed snapshots and historical versions.
