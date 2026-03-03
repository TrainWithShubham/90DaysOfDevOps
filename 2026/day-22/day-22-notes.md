### Task 1: Install and Configure Git

ubuntu@ip-172-31-27-220:~$ git --version
git version 2.43.0
mkdir ubuntu@ip-172-31-27-220:~$ git config --global user.name "akash"
ubuntu@ip-172-31-27-220:~$ git config --global user.email "akashjaura@gmail.com"
ubuntu@ip-172-31-27-220:~$ git config --global --list
user.name=akash
user.email=akashjaura@gmail.com
ubuntu@ip-172-31-27-220:~$ git config --list
user.name=akash
user.email=akashjaura@gmail.com
ubuntu@ip-172-31-27-220:~$

### Task 2: Create Your Git Project
1. Create a new folder called `devops-git-practice`
ubuntu@ip-172-31-27-220:~$ cd devops-git-practice/

2. Initialize it as a Git repository
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git init
hint: Using 'master' as the name for the initial branch. This default branch name
hint: is subject to change. To configure the initial branch name to use in all
hint: of your new repositories, which will suppress this warning, call:
hint:
hint:   git config --global init.defaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command:
hint:
hint:   git branch -m <name>
Initialized empty Git repository in /home/ubuntu/devops-git-practice/.git/

3. Explore the hidden `.git/` directory — look at what's inside
ubuntu@ip-172-31-27-220:~/devops-git-practice$ ls  .git
HEAD  branches  config  description  hooks  info  objects  refs
ubuntu@ip-172-31-27-220:~/devops-git-practice$ cd .git
ubuntu@ip-172-31-27-220:~/devops-git-practice/.git$ ls -l
total 32
-rw-rw-r-- 1 ubuntu ubuntu   23 Mar  3 11:09 HEAD
drwxrwxr-x 2 ubuntu ubuntu 4096 Mar  3 11:09 branches
-rw-rw-r-- 1 ubuntu ubuntu   92 Mar  3 11:09 config
-rw-rw-r-- 1 ubuntu ubuntu   73 Mar  3 11:09 description
drwxrwxr-x 2 ubuntu ubuntu 4096 Mar  3 11:09 hooks
drwxrwxr-x 2 ubuntu ubuntu 4096 Mar  3 11:09 info
drwxrwxr-x 4 ubuntu ubuntu 4096 Mar  3 11:09 objects
drwxrwxr-x 4 ubuntu ubuntu 4096 Mar  3 11:09 refs
ubuntu@ip-172-31-27-220:~/devops-git-practice/.git$

### Task 4: Stage and Commit
ubuntu@ip-172-31-27-220:~/devops-git-practice$ vim git-commands.md
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        git-commands.md

nothing added to commit but untracked files present (use "git add" to track)
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git add git-commands.md
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   git-commands.md

ubuntu@ip-172-31-27-220:~/devops-git-practice$ git commit -m "git commands cheatsheet added"
[master ac91840] git commands cheatsheet added
 1 file changed, 51 insertions(+)
 create mode 100644 git-commands.md

 ### Task 5: Make More Changes and Build History
ubuntu@ip-172-31-27-220:~/devops-git-practice$ vim git-commands.md
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   git-commands.md

no changes added to commit (use "git add" and/or "git commit -a")
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git commit -m "git commands log added"
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   git-commands.md

no changes added to commit (use "git add" and/or "git commit -a")
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git add git-commands.md
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git commit -m "git commands log added"
[master 5a79e22] git commands log added
 1 file changed, 1 insertion(+)
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git status
On branch master
nothing to commit, working tree clean
ubuntu@ip-172-31-27-220:~/devops-git-practice$ vim git-commands.md
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   git-commands.md

no changes added to commit (use "git add" and/or "git commit -a")
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git add git-commands.md
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   git-commands.md

ubuntu@ip-172-31-27-220:~/devops-git-practice$ git commit -m "git commands log description added"
[master 8151662] git commands log description added
 1 file changed, 2 insertions(+)

`full history in a compact format`
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git log
commit 81516623a0d1019de1074454c349b7475de09eed (HEAD -> master)
Author: akash <akashjaura@gmail.com>
Date:   Tue Mar 3 11:22:05 2026 +0000

    git commands log description added

commit 5a79e227f5b01b7d37927dbdf904c0c4292ff221
Author: akash <akashjaura@gmail.com>
Date:   Tue Mar 3 11:21:04 2026 +0000

    git commands log added

commit ac918408da268fb0988128bde7e7c093274da0ac
Author: akash <akashjaura@gmail.com>
Date:   Tue Mar 3 11:19:40 2026 +0000

    git commands cheatsheet added

commit b43f1b62d1ac85199fd9b77006e9255fbc6f4873
Author: akash <akashjaura@gmail.com>
Date:   Tue Mar 3 11:11:43 2026 +0000

    file added
ubuntu@ip-172-31-27-220:~/devops-git-practice$


### Task 6: Understand the Git Workflow
Answer these questions in your own words (add them to a `day-22-notes.md` file):
1. What is the difference between `git add` and `git commit`?
git add: Used when a new file is created or updated to tell Git to track those changes.

git commit: Used to save the staged changes permanently. Once committed, the file's current state is saved in history and cannot be lost.

2. What does the **staging area** do? Why doesn't Git just commit directly?
The staging area lets us use git status to see exactly which files are modified before saving them. Git doesn't commit directly because we might have unwanted files that shouldn't be included. Staging ensures only the correct changes impact the system.

3. What information does `git log` show you?
git log shows the previous history of all commits. It includes the unique commit ID, the author's name, the email of who committed it, and the date/message.

4. What is the `.git/` folder and what happens if you delete it?
The .git/ folder is created when you initialize a project. It contains all the "brain" info like HEAD and branches. If you delete this folder, all version history is removed, and the folder becomes a normal directory again.

5. What is the difference between a **working directory**, **staging area**, and **repository**?
Working Directory: The actual folder where you are currently making changes to files.

Staging Area: The middle zone where you prepare and check your changes using git add.

Repository: The final storage (the .git folder) where all your confirmed history and commits live.