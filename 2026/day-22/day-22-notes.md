# Day 22 - Git Workflow Notes

**1. What is the difference between git add and git commit?**
`git add` prepares files by placing them in a temporary staging area. `git commit` takes a permanent snapshot of whatever is currently in that staging area and saves it to the repository's history.

**2. What does the staging area do? Why doesn't Git just commit directly?**
The staging area acts as a buffer. It allows you to group related changes together. If you edit 10 files but only 3 are related to a specific bug fix, you can `git add` those 3 and commit them with a precise message, leaving the other 7 out of the snapshot. 

**3. What information does git log show you?**
It shows the timeline of commits, including the unique commit hash, the author's name and email, the date/timestamp, and the commit message.

**4. What is the .git/ folder and what happens if you delete it?**
The `.git/` folder is the actual repository. It houses the entire history, configuration, and tracking data. If you delete it, your working files remain on your disk, but all Git history is instantly destroyed and the folder becomes a normal directory again.

**5. What is the difference between a working directory, staging area, and repository?**
* **Working Directory:** The physical files you currently see and edit on your hard drive.
* **Staging Area (Index):** The waiting room where files are marked to go into the next commit.
* **Repository:** The hidden `.git` database where all permanent snapshots and history are stored.