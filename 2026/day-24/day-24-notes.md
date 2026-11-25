# Day 24: Advanced Git - Merge, Rebase, Stash & Cherry Pick

## Task 1: Git Merge

**1. What is a fast-forward merge?**
A fast-forward merge happens when the target branch (e.g., `main`) has no new commits since the feature branch was created. Git simply moves the `main` pointer forward to the latest commit of the feature branch without creating a new merge commit.

**2. When does Git create a merge commit instead?**
Git creates a merge commit (3-way merge) when both the target branch (`main`) and the feature branch have diverged (i.e., both have independent commits). It combines the histories and creates a new unified "merge commit".

**3. What is a merge conflict?**
A merge conflict occurs when Git cannot automatically resolve differences between two branches—typically because the exact same line in the same file was modified differently in both branches. The developer must manually edit the file to choose the correct code, stage, and commit the resolution.

## Task 2: Git Rebase

**1. What does rebase actually do to your commits?**
Rebase temporarily saves the commits of your feature branch, moves the base of your feature branch to the very tip of the target branch (like `main`), and then re-applies your saved commits one by one on top. It literally rewrites commit history by creating brand new commit hashes.

**2. How is the history different from a merge?**
A merge preserves the exact chronological history and shows diverging paths coming together via a "merge commit". A rebase rewrites history to create a perfectly straight, linear line, making the project look like everything was developed sequentially.

**3. Why should you never rebase commits that have been pushed and shared with others?**
Because rebase creates completely new commit hashes. If you rebase a branch that your teammates are already working on and push it, Git will see diverging histories. Your teammates will face chaotic merge conflicts, duplicate commits, and a broken local environment. Only rebase local, un-pushed branches!

**4. When would you use rebase vs merge?**
- **Rebase:** Use it to clean up a local, private feature branch before raising a Pull Request, so the main project history stays clean and linear.
- **Merge:** Use it when combining completed feature branches into `main` or when collaborating on shared branches where preserving the exact chronological truth is necessary.

## Task 3: Squash Commit vs Merge Commit

**1. What does squash merging do?**
Squash merging takes all the individual commits from a feature branch, combines them into one single, comprehensive set of changes, and places them into the target branch as a single new commit. 

**2. When would you use squash merge vs regular merge?**
- **Squash Merge:** Use it when a feature branch has many messy, insignificant, or "work-in-progress" commits (like "fixing typo", "testing again"). It keeps the `main` branch history perfectly clean and readable.
- **Regular Merge:** Use it when every individual commit in the feature branch has significant historical value and you want to preserve the exact step-by-step development process.

**3. What is the trade-off of squashing?**
The main trade-off is the loss of granular history. If you squash 20 commits into 1, you lose the detailed step-by-step log of how that feature was built, making it harder to revert a specific micro-change later.

## Task 4: Git Stash

**1. What is the difference between `git stash pop` and `git stash apply`?**
- **`git stash pop`**: Retrieves the most recently stashed changes, applies them to your working directory, and **deletes** that stash from the stash list.
- **`git stash apply`**: Retrieves and applies the stashed changes to your working directory but **keeps** the stash in the stash list for future use (great for applying the same stash to multiple branches).

**2. When would you use stash in a real-world workflow?**
You use stash when you are in the middle of working on a feature, but suddenly you need to switch branches to fix a critical production bug. You don't want to make a half-baked commit, so you stash your current changes, fix the bug on the other branch, come back, and apply your stash to resume where you left off.

## Task 5: Cherry Picking

**1. What does cherry-pick do?**
Cherry-picking allows you to take a specific, individual commit from one branch and apply it to another branch, without merging the entire history of the source branch. 

**2. When would you use cherry-pick in a real project?**
If a developer accidentally commits a critical hotfix to a feature branch (which isn't ready to be merged yet), you can use `cherry-pick` to pull just that specific hotfix commit directly into the `main` or `production` branch to resolve the live issue immediately.

**3. What can go wrong with cherry-picking?**
Cherry-picking creates a brand-new commit hash for the applied change. If you cherry-pick a commit and later try to merge the original branch that contained the same commit, Git might get confused, leading to nasty merge conflicts or duplicate commits in the history.
