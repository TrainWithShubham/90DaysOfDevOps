### Day 25 – Git Reset vs Revert & Branching Strategies
----

#### Task 1: Git Reset 
>- **Make 3 commits in your practice repo (commit A, B, C)**



<img src="assets/1.png" width="900">




>- **Use git reset --soft to go back one commit — what happens to the changes?**
<img src="assets/1-2.png" width="900">


>- **Re-commit, then use git reset --mixed to go bak one commit — what happens now?**

<img src="assets/1-3.png" width="900">


>- **Re-commit, then use git reset --hard to go back one commit — what happens this time?**

<img src="assets/1-4.png" width="900">

#### Notes:

>- **what is the difference between --soft, --mixed, and --hard?**

**reset --soft:** Commits removed from history, changes stay staged.
**reset --mixed:** Commits removed, changes unstaged (in working directory).

**reset --hard:** Commits removed, staging cleared, working directory overwritten — changes lost permanently




>- **Which one is destructive and why?**

**Answer:**
git reset --hard is considered destructive because it resets the commit history, the staging area, and the working directory. Any changes that were not committed are permanently lost, making it difficult or impossible to recover them.


>- **When would you use each one?**

**reset --soft:** To undo a commit but keep the changes staged for quick recommit or editing the commit message. Example: fixing the last commit before pushing.


**reset --hard:** To completely discard commits and changes in the working directory. Example: resetting a branch to match remote or cleaning up experimental changes you don’t need.

**reset --mixed:** To undo a commit and unstage the changes, so you can selectively stage them again. Example: splitting a commit into smaller pieces.



>- **Should you ever use git reset on commits that are already pushed?**
----

#### Task 2: Git Revert — Hands-On
>- **Make 3 commits (commit X, Y, Z)**

>- **Revert commit Y (the middle one) — what happens?**

>- **Check git log — is commit Y still in the history?**






<img src="assets/2-3.png" width="900">

<img src="assets/2-2.png" width="900">

**Explanition:** If **revert** operation is done on single file,it will give conflicts otherwise on separate files, revert works perfectly.

Also after performing **revert** , the orignal commit remains in the commit history and a new **Revert Commit** is created.

#### Notes:

>- **How is git revert different from git reset?**

The following usecases can help in defining the differences:

**git revert** is used to undo a commit without losing history, especially on pushed/shared branches. 

**git reset** is used to undo commits locally or clean up history, or remove staged/working changes





>- **Why is revert considered safer than reset for shared branches?**

**Answer:**
git revert is safer on shared branches because it undoes changes by creating a new commit instead of rewriting history like git reset does.

git reset affects the history that can't be undone.


>- **When would you use revert vs reset?**

**git revert** is generally required for shared/public branches when you want to undo a commit without rewriting history,when a bad commit is pushed to main and need to undo it safely

**git reset** is for local/private branches when you want to move HEAD, remove commits, or clean changes, in case of bad commits,for mistakenly done commits locally and want to redo commits before pushing

------

#### Task 3: Reset vs Revert — Summary

| | `git reset` | `git revert` |
|---|---|---|
| What it does | rewrites the history | Creates a new revert commit and the previous commit becomes unaffective. |
| Removes commit from history? | yes| no |
| Safe for shared/pushed branches? | no | yes |
| When to use | ? | ? |



-----

### Task 4: Branching Strategies


>- **How it works** 
>- **A simple diagram or flow** 




>- **When/where it's used**


>- **Pros and cons**

>- **GitFlow — develop, feature, release, hotfix branches**


>- **GitHub Flow — simple, single main branch + feature branches**


>- **Trunk-Based Development — everyone commits to main, short-lived branches**


>- #### Notes:

>_ **Which strategy would you use for a startup shipping fast?**


>- **Which strategy would you use for a large team with scheduled releases?**

>- **Which one does your favorite open-source project use? (reference to a repo on GihHub)**





------

#### Task 5: Git Commands Reference Update

>- **An insight to commonly used Git Commands**

>- **Setup & Config**

- git config --global user.name "Your Name"
- git config --global user.email "your@email.com"


>- **Basic Workflow (add, commit, status, log, diff)**
- git status → check repo state

- git add filename / git add . → stage changes

- git commit -m "message" → save staged changes

- git log / git log --oneline → view commit history

- git diff → unstaged changes

- git diff --staged → staged changes

- git diff commit1 commit2 → compare commits



>- **Branching (branch, checkout, switch)**

- git branch → list branches

- git branch branch-name → create branch

- git branch -d branch-name → delete branch

- git checkout branch-name → switch branch (old)

- git checkout -b branch-name → create + switch (old)

- git switch branch-name → switch branch (modern)

- git switch -c branch-nam

>- **Remote (push, pull, fetch, clone, fork)**

- git clone <repo-url> → copy repo locally

- git push origin branch-name → upload commits

- git pull origin branch-name → fetch + merge remote

- git fetch origin → fetch only, review before merge

- Fork → copy repo on GitHub (platform action)




>- **Merging & Rebasing**
- git merge feature → combine changes, may create merge commit

- git rebase main → replay commits on another branch, keeps history linear
>- **Stash & Cherry Pick**

- git stash → temporarily save uncommitted changes

- git stash list → list stashes

- git stash apply → reapply changes

- git cherry-pick <commit-hash>

>- **Reset & Revert**


- git reset [--soft|--mixed|--hard] <commit> → move branch pointer:

- --soft → keep staged + working

- --mixed → keep working, unstage

- --hard → discard staged + working



- git revert <commit> → create new commit that undoes previous commit
