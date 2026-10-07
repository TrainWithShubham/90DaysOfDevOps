# Day 24 - Advanced Git: Merge, Rebase, Stash & Cherry-Pick

## 1. Merge vs. Rebase
* **Fast-Forward Merge:** Happens when the target branch (e.g., `main`) hasn't had any new commits since you created your feature branch. Git simply moves the pointer forward in a straight line.
* **Merge Commit:** Happens when timelines diverge (both branches have new commits). Git physically ties the branches together, creating a new, special commit to join the histories.
* **Rebase:** Instead of joining two divergent branches with a merge commit, rebase rewrites the history of your feature branch, pretending you started your work from the absolute latest version of `main`. It creates a clean, straight timeline.
* **The Golden Rule:** Never rebase a branch that has already been pushed to a remote repository and shared with others, as it rewrites the commit IDs and destroys the timeline for your team.

## 2. Squash Merging
* **What it does:** Condenses multiple small commits from a feature branch into a single, comprehensive commit before applying it to the main branch.
* **Trade-off:** You get a beautifully clean and readable `main` history, but you permanently lose the granular, step-by-step history of how the feature was built.

## 3. Git Stash
* **Use Case:** When you are halfway through coding a feature but are forced to immediately switch branches to fix a critical bug. Stash acts as a temporary clipboard for uncommitted changes so you don't have to commit half-written code.
* **Pop vs Apply:** `git stash pop` applies the saved work and deletes it from the stash memory. `git stash apply` applies the work but keeps the backup in the stash memory.

## 4. Cherry-Picking
* **What it does:** Allows you to target a single, specific commit ID from anywhere in the repository and apply it to your current branch without bringing over the rest of the branch's history.
* **Use Case:** A developer creates a branch with 5 commits. Commits 1-4 are broken, but Commit 5 contains a critical security patch. You can cherry-pick just Commit 5 directly into `main`.
* **Risks:** If the cherry-picked commit depends on code created in previous, un-picked commits, Git will trigger a severe merge conflict.