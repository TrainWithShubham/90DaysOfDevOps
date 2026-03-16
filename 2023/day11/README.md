# Day 11 Task: Advance Git & GitHub for DevOps Engineers: Part-2

## Git Stash:

Git stash is a command that allows you to temporarily save changes you have made in your working directory, without committing them. This is useful when you need to switch to a different branch to work on something else, but you don't want to commit the changes you've made in your current branch yet.

To use Git stash, you first create a new branch and make some changes to it. Then you can use the command git stash to save those changes. This will remove the changes from your working directory and record them in a new stash. You can apply these changes later. git stash list command shows the list of stashed changes.

You can also use git stash drop to delete a stash and git stash clear to delete all the stashes.

## Cherry-pick:

Git cherry-pick is a command that allows you to select specific commits from one branch and apply them to another. This can be useful when you want to selectively apply changes that were made in one branch to another.

To use git cherry-pick, you first create two new branches and make some commits to them. Then you use git cherry-pick <commit_hash> command to select the specific commits from one branch and apply them to the other.

## Resolving Conflicts:

Conflicts can occur when you merge or rebase branches that have diverged, and you need to manually resolve the conflicts before git can proceed with the merge/rebase.
git status command shows the files that have conflicts, git diff command shows the difference between the conflicting versions and git add command is used to add the resolved files.

# Task-01

- Create a new branch and make some changes to it.
- Use git stash to save the changes without committing them.
- Switch to a different branch, make some changes and commit them.
- Use git stash pop to bring the changes back and apply them on top of the new commits.

# Task-02

- In version01.txt of development branch add below lines after “This is the bug fix in development branch” that you added in Day10 and reverted to this commit.
- Line2>> After bug fixing, this is the new feature with minor alteration”

  Commit this with message “ Added feature2.1 in development branch”

- Line3>> This is the advancement of previous feature

  Commit this with message “ Added feature2.2 in development branch”

- Line4>> Feature 2 is completed and ready for release

  Commit this with message “ Feature2 completed”

- All these commits messages should be reflected in Production branch too which will come out from Master branch (Hint: try rebase).

# Task-03

- In Production branch Cherry pick Commit “Added feature2.2 in development branch” and added below lines in it:
- Line to be added after Line3>> This is the advancement of previous feature
- Line4>>Added few more changes to make it more optimized.
- Commit: Optimized the feature

## Reference [video](https://youtu.be/apGV9Kg7ics)

You can Post on LinkedIn and let us know what you have learned from this task by #90DaysOfDevOps Challenge. Happy Learning :)

[← Previous Day](../day10/README.md) | [Next Day →](../day12/README.md)
