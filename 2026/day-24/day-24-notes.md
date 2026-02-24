# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick

##  Merge Concepts

### 1 What is a Fast-Forward Merge?

A fast-forward merge happens when the main branch has not changed.

If only the feature branch has new commits, Git just moves the main branch forward.

No new commit is created.

Simple meaning:
Main branch simply shifts to the latest commit.

---

### 2 When Does Git Create a Merge Commit?

Git creates a merge commit when both branches have new commits.

This means:
- You made changes in the feature branch
- You also made changes in the main branch

Now Git cannot just move the branch forward.

So Git creates a new commit to combine both branches.

This creates a Y-shaped structure in the history.

---

### 3 What is a Merge Conflict?

A merge conflict happens when:

- The same file
- And the same line
- Is changed in both branches

Git gets confused and does not know which change to keep.

It stops the merge and asks you to fix it manually.

After fixing the file, you run:

git add .
git commit

Then the merge completes.

---

## Git Rebase – Beginner Explanation

### 1 What does rebase actually do to your commits?

Rebase takes your feature branch commits  
and moves them on top of the latest commit of another branch (usually main).

It rewrites the commit history.

Simple meaning:
Rebase removes your commits temporarily and re-adds them after the latest main commit.

Because of this, commit IDs change.

---

### 2 How is the history different from a merge?

Merge:
- Keeps original history.
- Creates a merge commit.
- History looks like a Y-shape.

Rebase:
- Rewrites history.
- Does NOT create a merge commit.
- History looks like a straight line.

Simple difference:
Merge keeps branch structure.
Rebase makes history clean and linear.

---

### 3 Why should you never rebase commits that have been pushed and shared?

Rebase changes commit IDs.

If you already pushed commits and other people are using them,
rebasing will change history and create confusion.

Other developers may get errors or duplicate commits.

Simple rule:
Never rebase shared or public commits.

Rebase only your local commits.

---

### 4 When would you use rebase vs merge?

Use Rebase:
- When working alone.
- When you want clean history.
- Before pushing your feature branch.

Use Merge:
- When working in a team.
- When commits are already shared.
- When you want to preserve full history.

Simple idea:
Rebase = clean history.
Merge = safe history.

---

## Squash Merge – Beginner Explanation

### 1 What does squash merging do?

Squash merging combines all commits from a feature branch into one single commit.

If a branch has 4–5 small commits, squash merge turns them into one commit before adding to the main branch.

Simple meaning:
Many commits → One clean commit.

---

### 2 When would you use squash merge vs regular merge?

Use Squash Merge:
- When there are many small commits (typo fixes, formatting, small changes).
- When you want clean and simple history.
- When working on small features.

Use Regular Merge:
- When you want to keep full commit history.
- When working in a team.
- When each commit is important.

Simple idea:
Squash = clean history.
Regular merge = detailed history.

---

### 3 What is the trade-off of squashing?

The trade-off is that you lose detailed commit history.

After squash:
- You cannot see the small individual commits in main.
- Only one combined commit is visible.

So you get cleaner history, but less detailed history.

Simple meaning:
Clean history but less information.

---

## Git Stash – Beginner Explanation

### 1 What is the difference between `git stash pop` and `git stash apply`?

Both commands bring back your stashed changes.

But there is one important difference:

- `git stash pop` → Applies the stash and removes it from the stash list.
- `git stash apply` → Applies the stash but keeps it saved in the stash list.

Simple meaning:

pop = use it and remove it  
apply = use it but keep it

---

### 2 When would you use stash in a real-world workflow?

You use stash when you are working on something but need to switch tasks urgently.

For example:
- You are writing new code.
- Suddenly, you need to fix a bug in another branch.
- Your work is not ready to commit.

Instead of committing unfinished work, you use:

git stash

This saves your temporary work safely.
Then you switch branch, fix the issue, and later come back and use:

git stash pop

Simple meaning:
Stash is used to temporarily save unfinished work without committing it.


# Git Cherry-Pick – Beginner Notes

## 1. What does cherry-pick do?

Cherry-pick is a Git command used to apply a specific commit 
from one branch to another branch.

In simple words:
If a branch has many commits but we need only one specific commit,
we use cherry-pick.

### Example Command:

git cherry-pick <commit-id>


---

## 2. When would you use cherry-pick in a real project?

Cherry-pick is used in real projects in the following situations:

### 1. Bug Fix for Production
If a feature branch has multiple commits but only one bug fix 
needs to go to the main (production) branch, 
we use cherry-pick to move only that commit.

### 2. Wrong Branch Commit
If a commit was made in the wrong branch by mistake,
we can cherry-pick it into the correct branch.

### 3. Hotfix
If an urgent fix is needed in production,
we cherry-pick the specific fix instead of merging the entire branch.

---

## 3. What can go wrong with cherry-picking?

### 1. Merge Conflicts
If the same file was changed in both branches,
Git may show conflicts.

### 2. Duplicate Commits
If the original branch is later merged,
the same changes may appear twice in history.

### 3. Confusing History
Too much cherry-picking can make the project history messy and hard to understand.

---

## Summary

- Cherry-pick copies a specific commit from one branch to another.
- It is useful for bug fixes, hotfixes, and moving commits to the correct branch.
- It can cause conflicts, duplicate commits, and messy history if not used carefully.