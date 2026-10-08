# Day 24 Notes – Advanced Git

---

# Git Merge

## What I Did

I created a branch called `feature-login` and added commits to it.

Then I merged it into `DevOps-practice`.

Git performed a fast-forward merge because the main branch did not have any new commits.

Later, I created another branch called `feature-signup`.

This time, I also added a commit on `DevOps-practice` before merging.

When I merged `feature-signup`, Git created a merge commit.

---

## What is a Fast-Forward Merge?

A fast-forward merge happens when the main branch has no new commits after creating the feature branch.

Git simply moves the branch pointer forward.

No extra merge commit is created.

---

## What is a Merge Commit?

A merge commit happens when both branches have different commits.

Git creates a special commit to combine both histories together.

I observed this using:

```bash
git log --oneline --graph --all
```

---

## What is a Merge Conflict?

A merge conflict happens when the same line of the same file is modified differently in two branches.

Git becomes confused and asks the developer to manually choose the correct changes.

---

# Git Rebase

## What I Did

I created a branch called `feature-dashboard` and added multiple commits.

Then I added another commit on `DevOps-practice`.

After that, I rebased `feature-dashboard` on top of `DevOps-practice`.

---

## What Does Rebase Do?

Rebase moves feature branch commits on top of the latest main branch commits.

It rewrites commit history to create a cleaner and more linear history.

---

## Difference Between Merge and Rebase

### Merge

- keeps branch history
- creates merge commits
- history can look more complex

### Rebase

- rewrites commit history
- creates cleaner history
- avoids unnecessary merge commits

---

## Why Should We Avoid Rebasing Shared Commits?

Rebasing changes commit history.

If commits are already pushed and shared with teammates, rebasing can create confusion and conflicts for others.

---

## When Would I Use Rebase vs Merge?

I would use:

- rebase for cleaning my own local branch history
- merge for shared team branches

---

# Squash Merge

## What I Did

I created a branch called `feature-profile` and added multiple small commits like:

- typo fixes
- formatting changes
- profile updates

Then I used:

```bash
git merge --squash feature-profile
```

---

## What Does Squash Merge Do?

Squash merge combines multiple commits into one single clean commit.

Instead of adding many small commits to the main branch, Git creates only one commit.

---

## When Would I Use Squash Merge?

I would use squash merge when:

- feature branch contains many tiny commits
- I want cleaner commit history
- typo and formatting commits are not important individually

---

## Trade-Off of Squash Merge

The detailed commit history from the feature branch is lost in the main branch.

Only one combined commit appears.

---

# Git Stash

## What I Did

I modified `git-commands.md` without committing changes.

Then I used stash to temporarily save my unfinished work.

After switching branches, I restored my changes using `git stash pop`.

---

## What is Git Stash?

Git stash temporarily saves unfinished changes without creating a commit.

It helps when I need to quickly switch branches for another task.

---

## Difference Between git stash pop and git stash apply

### git stash pop

- restores stash
- removes stash from stash list

### git stash apply

- restores stash
- keeps stash in stash list

---

## When Would I Use Stash?

I would use stash when:

- my work is incomplete
- I need to urgently switch branches
- I do not want to create unnecessary commits

---

# Git Cherry-Pick

## What I Did

I created a branch called `feature-hotfix` and added three commits.

Then I used cherry-pick to copy only the second commit into `DevOps-practice`.

Only that selected commit was applied.

---

## What Does Cherry-Pick Do?

Cherry-pick copies one specific commit from another branch.

It does not merge the entire branch.

---

## When Would I Use Cherry-Pick?

I would use cherry-pick when:

- I only need one specific bug fix
- I do not want all branch changes
- I need to quickly apply one important commit

---

## What Can Go Wrong with Cherry-Pick?

Cherry-picking can create conflicts if the selected commit depends on other commits that were not copied.

---

# Commands Practiced Today

```bash
git merge
git merge --squash
git rebase
git stash
git stash list
git stash pop
git stash apply
git cherry-pick
git log --oneline --graph --all
```

---

# What I Learned Today

- Fast-forward merge and merge commit are different
- Rebase creates cleaner history
- Squash merge combines many commits into one
- Stash temporarily saves unfinished work
- Cherry-pick copies only one specific commit
- Git history visualization is very helpful using graph logs
- Advanced Git workflows are very important in DevOps and team collaboration
