### Task 1: Git Merge — Hands-On
1. Create a new branch `feature-login` from `main`, add a couple of commits to it
```bash
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout -b feature-login
Switched to a new branch 'feature-login'
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git add hello.sh
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git log --oneline
12fed7f (HEAD -> feature-login, origin/main, feature-1) Update hello.sh
8151662 (origin/feature-1, master, main, feature-2) git commands log description added
```


2. Switch back to `main` and merge `feature-login` into `main`
```bash
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout main
Switched to branch 'main'
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git branch
  feature-1
  feature-2
  feature-login
* main
  master
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git merge feature-login
Updating 8151662..e3d5b07
Fast-forward
 hello.sh  | 2 ++
 hello.txt | 1 +
 2 files changed, 3 insertions(+)
 create mode 100644 hello.sh
```

3. Observe the merge — did Git do a **fast-forward** merge or a **merge commit**?
```Ans : It is a fast-forward merge because no commits were made on the main branch after creating the feature-login branch.```

4. Now create another branch `feature-signup`, add commits to it — but also add a commit to `main` before merging
```bash
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout -b feature-signup
Switched to a new branch 'feature-signup'
ubuntu@ip-172-31-27-220:~/devops-git-practice$ ls
git-commands.md  hello.sh  hello.txt
ubuntu@ip-172-31-27-220:~/devops-git-practice$ vim hello.sh
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git status
On branch feature-signup
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   hello.sh

no changes added to commit (use "git add" and/or "git commit -a")
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git commit -m "feat:signup added"
On branch feature-signup
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   hello.sh

no changes added to commit (use "git add" and/or "git commit -a")
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git add hello.sh
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git commit -m "feat:signup added"
[feature-signup 9f0e614] feat:signup added
 1 file changed, 1 insertion(+), 1 deletion(-)
```


**commiting to main before merging**
```bash
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout main
Switched to branch 'main'
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git status
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
ubuntu@ip-172-31-27-220:~/devops-git-practice$ vim hello.sh
 3L, 49B written
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git add hello.sh
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git commit -m "chore:new line added"
[main ad1b452] chore:new line added
 1 file changed, 1 insertion(+)
```

5. Merge `feature-signup` into `main` — what happens this time?
when i try to merge i got conflicts ,firstly it tries to auto merge
```bash
merge: feature-signuo - not something we can merge
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git merge feature-signup
Auto-merging hello.sh
CONFLICT (content): Merge conflict in hello.sh
Automatic merge failed; fix conflicts and then commit the result.
ubuntu@ip-172-31-27-220:~/devops-git-practice$ vim hello.sh
 7L, 96B written
<<<<<<< HEAD
this is main branch

=======
now am in_feature-signup
>>>>>>> feature-signup
~
```
then i manually edit these
```bash
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git status
On branch main
Your branch is ahead of 'origin/main' by 2 commits.
  (use "git push" to publish your local commits)

You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Unmerged paths:
  (use "git add <file>..." to mark resolution)
        both modified:   hello.sh

no changes added to commit (use "git add" and/or "git commit -a")
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git add hello.sh
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git commit -m "chore:conflict resolved"
[main b07b83e] chore:conflict resolved
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git merge feature-signup
Already up to date.
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git log --oneline
b07b83e (HEAD -> main) chore:conflict resolved
ad1b452 chore:new line added
9f0e614 (feature-signup) feat:signup added
e3d5b07 (feature-login) feat:login feature added
12fed7f (origin/main, feature-1) Update hello.txt
8151662 (origin/feature-1, master, feature-2) git commands log description added
5a79e22 git commands log added
ac91840 git commands cheatsheet added
b43f1b6 file added
```
6.
   - What is a fast-forward merge?

        Ans -  In a fast-forward merge, no commits are made on the main branch after creating another branch.

   - When does Git create a merge commit instead?

        Ans: A merge commit is created when:
        both branches have new commits, so Git cannot fast-forward.
        commit b07b83e11c4d9651331005a69e4824ced1b5b090 (HEAD -> main)

        Merge: ad1b452 9f0e614

        Author: akash <akashjaura@gmail.com>
Date:   Sun Mar 8 08:26:56 2026 +0000
    chore: conflict resolved

   - What is a merge conflict? (try creating one intentionally by editing the same line in both branches)

    Ans - when we changes the same line in two different branches then the          conflict occur like i have done this earlier
    and i got this 
which i manually resolve
<<<<<<< HEAD
this is main branch

=======
now am in_feature-signup
>>>>>>> feature-signup


### Task 2: Git Rebase — Hands-On
1. Create a branch `feature-dashboard` from `main`, add 2-3 commits
```bash
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout feature-dashboard
Switched to branch 'feature-dashboard'
ubuntu@ip-172-31-27-220:~/devops-git-practice$ ls
git-commands.md  hello.  hello.sh  hello.txt
ubuntu@ip-172-31-27-220:~/devops-git-practice$ vim hello.sh
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git add hello.sh
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git commit -m "chore :task2 added"
[feature-dashboard b8be93c] chore :task2 added
 1 file changed, 5 insertions(+)
ubuntu@ip-172-31-27-220:~/devops-git-practice$ vim hello.sh
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git add hello.sh
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git commit -m "chore :task2 2nd commit added"
[feature-dashboard bd26c35] chore :task2 2nd commit added
 1 file changed, 1 insertion(+)
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git log --oneline
bd26c35 (HEAD -> feature-dashboard) chore :task2 2nd commit added
b8be93c chore :task2 added
```


2. While on `main`, add a new commit (so `main` moves ahead)
```bash
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout main
Switched to branch 'main'
Your branch is ahead of 'origin/main' by 5 commits.
  (use "git push" to publish your local commits)
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git log --oneline
8a7f84f (HEAD -> main) chore:linefor feature-dashborad addded
b07b83e chore:conflict resolved
ad1b452 chore:new line added
9f0e614 (feature-signup) feat:signup added
e3d5b07 (feature-login) feat:login feature added
12fed7f (origin/main, feature-1) Update hello.txt
8151662 (origin/feature-1, master, feature-2) git commands log description added
5a79e22 git commands log added
ac91840 git commands cheatsheet added
b43f1b6 file added
```

3. Switch to `feature-dashboard` and rebase it onto `main`
```bash
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout feature-dashboard
Switched to branch 'feature-dashboard'
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git rebase
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git log --oneline

b50d73c (HEAD) chore :conflict resolve
8a7f84f (main) chore:linefor feature-dashborad addded
b07b83e chore:conflict resolved
ad1b452 chore:new line added
9f0e614 (feature-signup) feat:signup added
e3d5b07 (feature-login) feat:login feature added
12fed7f (origin/main, feature-1) Update hello.txt
8151662 (origin/feature-1, master, feature-2) git commands log description added
5a79e22 git commands log added
ac91840 git commands cheatsheet added
b43f1b6 file added
```

4. Observe your `git log --oneline --graph --all` — how does the history look compared to a merge?
```bash
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git log --oneline --graph --all HEAD~4
* 7dc59fa (HEAD) chore :conflict resolve
* b50d73c chore :conflict resolve
* 8a7f84f (main) chore:linefor feature-dashborad addded
| * bd26c35 (feature-dashboard) chore :task2 2nd commit added
| * b8be93c chore :task2 added
|/
*   b07b83e chore:conflict resolved
|\
| * 9f0e614 (feature-signup) feat:signup added
* | ad1b452 chore:new line added
|/
* e3d5b07 (feature-login) feat:login feature added
* 12fed7f (origin/main, feature-1) Update hello.txt
* 8151662 (origin/feature-1, master, feature-2) git commands log description added
* 5a79e22 git commands log added
* ac91840 git commands cheatsheet added
* b43f1b6 file added
```

5. Answer in your notes:
   - What does rebase actually do to your commits?
   
        It generally linears  the commit history 
   - How is the history different from a merge?
  
     In merge two base branches changes are merged to into main but in rebase       the commit history of branches and after they become linear
   - Why should you **never rebase commits that have been pushed and shared** with others?

        Rebasing rewrites commit history (creates new commit hashes).
        If others have based work on the old commits, it breaks their history and    causes conflicts.
    Safe to rebase only local commits that haven’t been pushed/shared.
   - When would you use rebase vs merge?
  
         Use rebase when:
        You want a clean, linear commit history.
        Updating a feature branch with the latest main branch changes.
        Preparing commits before opening a pull request.

         Use merge when:
        You want to preserve the exact branch history.
        Combining long-lived branches with multiple developers.
        Avoid rewriting history that is already shared.

### Task 3: Squash Commit vs Merge Commit
1. Create a branch `feature-profile`, add 4-5 small commits (t
ypo fix, formatting, etc.)
```BASH
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout -b feature-profile
Switched to a new branch 'feature-profile'

ubuntu@ip-172-31-27-220:~/devops-git-practice$ git log --oneline
04881a4 (HEAD -> feature-profile) chore:important ones
622b514 chore:line added
5442e49 chore: profile section specs
c36519e feat : profile featire added
7dc59fa chore :conflict resolve
b50d73c chore :conflict resolve
```
2. Merge it into `main` using `--squash` — what happens?
```
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git merge feature-profile --squash
Updating 8a7f84f..04881a4
Fast-forward
Squash commit -- not updating HEAD
 hello.sh   | 9 +++++++++
 profile.sh | 7 +++++++
 2 files changed, 16 insertions(+)
 create mode 100644 profile.sh
 ```
3. Check `git log` — how many commits were added to `main`?
```
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git merge feature-profile --squash
Updating 8a7f84f..04881a4
Fast-forward
Squash commit -- not updating HEAD
 hello.sh   | 9 +++++++++
 profile.sh | 7 +++++++
 2 files changed, 16 insertions(+)
 create mode 100644 profile.sh
 ```
4. Now create another branch `feature-settings`, add a few commits
```
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git log --oneline
9c28839 (HEAD -> feature-settings) feat: 2nd feature added
0240b67 feat:new feature added
```
5. Merge it into `main` **without** `--squash` (regular merge) — compare the history
```
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git merge feature-settings
Updating d7451e4..9c28839
Fast-forward
 feature-set.sh | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 feature-set.sh
 ```
6. Answer in your notes:
   - What does squash merging do?

     Squash merge takes all commits from a feature branch and combines them into a single commit on the target branch.

        Git applies the changes but does not create individual commits or a merge commit (unless you commit manually after the squash).

   - When would you use squash merge vs regular merge?
    
            squash merge:

        - Use when you want to clean up commit history.
        
        - Ideal for small feature branches where individual commits are not important.
        
        - Example: minor fixes, typo corrections, or experimental work on a branch.

                Regular merge:
        - Use when you want to preserve complete history.
        
        - Good for long-lived or shared branches where individual commits matter.
        -Example: team features, releases, or branches with multiple developers.
   - What is the trade-off of squashing?
        
            Pros:

        - Keeps the main branch history clean and linear.

        - Avoids clutter from small, trivial commits.

                Cons:

        - You lose individual commit details from the feature branch.

        -  Makes it harder to see the step-by-step development history.

        - revert individual commits from the feature branch — only the single squashed commit.


### Task 4: Git Stash — Hands-On
**Before Stash**
```
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git status
On branch main
Your branch is ahead of 'origin/main' by 8 commits.
  (use "git push" to publish your local commits)

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   hello.sh
 ```
**After performing stash**
```
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git stash
Saved working directory and index state WIP on main: 9c28839 feat: 2nd feature added
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git status
On branch main
Your branch is ahead of 'origin/main' by 8 commits.
  (use "git push" to publish your local commits)

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        hello.
```
***stash pop**
```
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git stash pop
On branch main
Your branch is ahead of 'origin/main' by 8 commits.
  (use "git push" to publish your local commits)

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   mu.sh

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   hello.sh

Dropped refs/stash@{0} (0fc545a2cb64ea9ca77ef66c061c0f64c13f0b26)
```
 - What is the difference between `git stash pop` and `git stash apply`?
        
        - git stash apply
            Stash remains in the stash list, so we can reapply it later.
        git stash pop
            Stash is removed from the stash list — it’s gone after pop.
   - When would you use stash in a real-world workflow?

        - Git stash is used to temporarily save uncommitted changes so you can switch branches or pull/merge without losing work.

### Task 5: Cherry Picking
```
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git checkout -b feature-hotfix
Switched to a new branch 'feature-hotfix'

ubuntu@ip-172-31-27-220:~/devops-git-practice$ git log --oneline
da4ed67 (HEAD -> feature-hotfix) chore:feature3 added
6be6ed1 chore:feature2 added
677937f chore:feature added
```
**Applied cheery pick**
```
ubuntu@ip-172-31-27-220:~/devops-git-practice$ git cherry-pick 6be6ed1
[main 7ae7c7a] chore:feature2 added
 Date: Sun Mar 8 09:55:55 2026 +0000
 1 file changed, 5 insertions(+)
 create mode 100644 feat_fix.sh
 ubuntu@ip-172-31-27-220:~/devops-git-practice$ git log --oneline
7ae7c7a (HEAD -> main) chore:feature2 added
ae91769 initial commit
9c28839 (feature-settings) feat: 2nd feature added
0240b67 feat:new feature added
d7451e4 chore :task2 2nd commit added
```
   - What does cherry-pick do?

        It genrally used for merging the specific commit on the main branch from different branch 
   - When would you use cherry-pick in a real project?

     Like i am working on the two features sigin and signup and i have done signin feature funcitonality but someone form company said we need to merge this if i used merge then whole code is pushed but if i used cherry pick only specif is merged
   - What can go wrong with cherry-picking?

     Cherry-picking creates a new commit with a different hash, so it may confuse the history if used too much.
   If the commit you cherry-pick changes the same files as the target branch, Git may stop with a conflict.