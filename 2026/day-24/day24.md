### Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick
----

#### Task 1: Git Merge — Hands-On
- [x] Create a new branch feature-login from main, add a couple of commits to it.
- [x] Switch back to main and merge feature-login into main
- [x] Observe the merge — did Git do a fast-forward merge or a merge commit?
- [x] Now create another branch feature-signup, add commits to it — but also add a commit to main before merging
- [x] Merge feature-signup into main — what happens this time?

<img src="images/1-1.png" width="700">
<img src="images/1-2.png" width="700">

<img src="images/1-3(merge).png" width="700">

<img src="images/1-4(signup).png" width="700">

<img src="images/1-5.png" width="700">


<img src="images/1-6.png" width="700">

- [x] What is a fast-forward merge?
 **Answer:**
A Git merge that moves the branch pointer forward without creating a new commit, used when the target branch has no new commits since the feature branch was created, resulting in a linear history.

- [x] When does Git create a merge commit instead?
 **Answer:**


Git creates a merge commit when the branches have diverged, meaning both the source and target branches have new commits that the other doesn’t have

- [x] What is a merge conflict? (try creating one intentionally by editing the same line in both branches)

 **Answer:**

 A situation in Git where changes in two branches overlap, and Git cannot automatically merge them, requiring manual resolution.



 -----


### Task 2: Git Rebase — Hands-On
- [x] Create a branch feature-dashboard from main, add 2-3 commits
- [x] While on main, add a new commit (so main moves ahead)
- [x] Switch to feature-dashboard and rebase it onto main
- [x] Observe your git log --oneline --graph --all — how does the history look compared to a merge?

<img src="images/2-1.png" width="700">



<img src="images/2-2.png" width="700">


<img src="images/2-3.png" width="700">


<img src="images/2-4.png" width="700">


- [x] What does rebase actually do to your commits?
**Answer:**



- [x] How is the history different from a merge?
**Answer:**
- [x] Why should you never rebase commits that have been pushed and shared with others?
**Answer:**
- [x] When would you use rebase vs merge?

**Answer:**


------

### Task 3: Squash Commit vs Merge Commit
- [x] Create a branch feature-profile, add 4-5 small commits (typo fix, formatting, etc.)
- [x] Merge it into main using --squash — what happens?
- [x] Check git log — how many commits were added to main?
- [x] Now create another branch feature-settings, add a few commits
- [x] Merge it into main without --squash (regular merge) — compare the history

<img src="images/3-1.png" width="700">

<img src="images/3-2(main).png" width="700">

<img src="images/3-3(squash).png" width="700">


<img src="images/3-4(settings).png" width="700">


<img src="images/3-5.png" width="700">




- [x] What does squash merging do?


- [x] When would you use squash merge vs regular merge?

- [x] What is the trade-off of squashing?


----

#### Task 4: Git Stash — Hands-On

- [x] Start making changes to a file but do not commit
- [x] Now imagine you need to urgently switch to another branch — try switching. What happens?
- [x] Use git stash to save your work-in-progress
- [x] Switch to another branch, do some work, switch back
- [x] Apply your stashed changes using git stash pop
- [x]Try stashing multiple times and list all stashes
- [x] Try applying a specific stash from the list




<img src="images/fo-1.png" width="700">


<img src="images/fo-2.png" width="700">


<img src="images/fo-2-1.png" width="700">


<img src="images/fo-3.png" width="700">




- [x] What is the difference between git stash pop and git stash apply?


- [x] When would you use stash in a real-world workflow?



----
#### Task 5: Cherry Picking
- [x] Create a branch feature-hotfix, make 3 commits with different changes
- [x] Switch to main
- [x] Cherry-pick only the second commit from feature-hotfix onto main
- [x] Verify with git log that only that one commit was applied


<img src="images/5.png" width="700">


<img src="images/5-1.png" width="700">




<img src="images/5-2.png" width="700">

- [x] What does cherry-pick do?
- [x] When would you use cherry-pick in a real project?
- [x] What can go wrong with cherry-picking?




---