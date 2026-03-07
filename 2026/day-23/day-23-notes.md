1. What is a branch in Git?
A branch is movable pointer as its a feature use to write files without affecting main
2. Why do we use branches instead of committing everything to `main`?
if we drectly commit to main then some issues can occur like when we create branch and before mereging we once chek the fuctnitonality fo feaitre the heslps to not break the code

3. What is `HEAD` in Git?
Head point to current branch or standing directory

4. What happens to your files when you switch branches?
files are commited on branhes like i have commit the file on branch1 but when i switched  to branch 2 i cannot see any file as they are comited to the branch 1

### Task 2: Branching Commands
1. Listed all branches 
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git branch
* master
2. Created a new branch called `feature-1`
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout -b feature-1

Switched to a new branch 'feature-1'
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git branch
* feature-1
  master
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git switch feature-1
Already on 'feature-1'

4. Created a new branch and switch to it in a single command — call it `feature-2`
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout -b feature-2
Switched to a new branch 'feature-2'

5. `git switch` to move between branches — how is it different from `git checkout`?
in an older version git checkout works on
Switching branches.
Creating new branches.
Restoring files.
in a newer version
git switch for switching and creating branches.
git restore for restoring files or working tree states.

ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git branch
  feature-1
* feature-2
  master
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git branch
  feature-1
* feature-2
  master
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout feature-
error: pathspec 'feature-' did not match any file(s) known to git
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout feature-1
Switched to branch 'feature-1'
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git branch
* feature-1
  feature-2
  master
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout feature-1
Already on 'feature-1'

6. Make a commit on `feature-1` that does **not** exist on `main`
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git commit -m "hello this is featurre-1"
On branch feature-1
nothing to commit, working tree clean

7. Switch back to `main` — verify that the commit from `feature-1` is not there
Switched to branch 'master'
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git log
commit 81516623a0d1019de1074454c349b7475de09eed (HEAD -> master, feature-2, feature-1)
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
3@DiKAHvCnhKY6j

### Task 3: Push to GitHub
1. Created a repository practice
2. Connect your local `devops-git-practice` repo to the GitHub remote
✓ Authentication complete.
- gh config set -h github.com git_protocol https
✓ Configured git protocol
! Authentication credentials saved in plain text
✓ Logged in as akashjaura2002
3. Push your `main` branch to GitHub
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout main
git push -u origin main
Already on 'main'
Enumerating objects: 12, done.
Counting objects: 100% (12/12), done.
Delta compression using up to 2 threads
Compressing objects: 100% (10/10), done.
Writing objects: 100% (12/12), 1.41 KiB | 1.41 MiB/s, done.
Total 12 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), done.
To https://github.com/akashjaura2002/practice.git
 * [new branch]      main -> main
4. Push `feature-1` branch to GitHub
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout feature-1
git push -u origin feature-1
Switched to branch 'feature-1'
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
remote:
remote: Create a pull request for 'feature-1' on GitHub by visiting:
remote:      https://github.com/akashjaura2002/practice/pull/new/feature-1
remote:
To https://github.com/akashjaura2002/practice.git
 * [new branch]      feature-1 -> feature-1

What is the difference between `origin` and `upstream`? 

origin: This is my copy on GitHub. I have full control here. I can  use it to "store" my daily progress.

upstream: This is the ORIGINAL creator's repository (e.g., TrainWithShubham). I can only use it to "catch up" and get the latest daily tasks.

### Task 4: Pull from GitHub
1. Make a change to a file **directly on GitHub** (use the GitHub editor)
I have made changes to hello.txt as you can see before pull hello.txt is empty
ubuntu@ip-172-31-27-220:~/devops-git-practice$ cat hello.txt
2. Pull that change to your local repo
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git pull origin main
From https://github.com/akashjaura2002/practice
 * branch            main       -> FETCH_HEAD
Updating 8151662..12fed7f
Fast-forward
 hello.txt | 1 +
 1 file changed, 1 insertion(+)
ubuntu@ip-172-31-27-220:~/devops-git-practice$ cat hello.txt
hi this is me akash
3. What is the difference between `git fetch` and `git pull`?
git fetch: This is like downloading a preview. It gets all the new commits, branches, and tags from the remote repository (GitHub) and stores them in local database, but it does not change code.files stay exactly as they were.
git pull: This is a two-in-one command. It runs git fetch first to get the data, and then immediately runs git merge to combine that data into your actual files.

### Task 5: Clone vs Fork
1. **Clone** any public repository from GitHub to your local machine
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git clone https://github.com/akashjaura16/bashforautomation
Cloning into 'bashforautomation'...
remote: Enumerating objects: 6, done.
remote: Counting objects: 100% (6/6), done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 6 (delta 1), reused 3 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (6/6), done.
Resolving deltas: 100% (1/1), done.

1. What is the difference between Clone and Fork?
Fork: This is a GitHub-side action. It creates a complete copy of someone else's repository under your own GitHub account. It exists on the cloud (GitHub servers).

Clone: This is a Git action that downloads a repository from a remote server (like GitHub) onto local machine (like your AWS Ubuntu instance).

2. When would you Clone vs Fork?
Fork: Use this when you want to contribute to an Open Source project or a repository you don't have "write" permissions for. It allows you to make changes in your own "sandbox" without affecting the original project.

Clone: Use this when you are ready to start coding. You clone your own repositories (or your forks) to your computer so you can edit files, create branches, and make commits.

3. How do you keep your Fork in sync?
git remote add upstream https://github.com/ORIGINAL_OWNER/REPO_NAME.git
Fetch the Changes:
Download the new data from the original repo without changing your files yet:

git fetch upstream
Merge into your Local Branch:
Combine the new "upstream" changes into your current local branch:

git merge upstream/main
Push to your Fork:
Finally, update your own GitHub repository (origin) so it matches your local machine:

git push origin main