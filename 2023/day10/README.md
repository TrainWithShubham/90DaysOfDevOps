# Day 10 Task: Advance Git & GitHub for DevOps Engineers.

## Git Branching

Use a branch to isolate development work without affecting other branches in the repository. Each repository has one default branch, and can have multiple other branches. You can merge a branch into another branch using a pull request.

Branches allow you to develop features, fix bugs, or safely experiment with new ideas in a contained area of your repository.

## Git Revert and Reset

Two commonly used tools that git users will encounter are those of git reset and git revert . The benefit of both of these commands is that you can use them to remove or edit changes you’ve made in the code in previous commits.

## Git Rebase and Merge

### What Is Git Rebase?

Git rebase is a command that lets users integrate changes from one branch to another, and the logs are modified once the action is complete. Git rebase was developed to overcome merging’s shortcomings, specifically regarding logs.

### What Is Git Merge?

Git merge is a command that allows developers to merge Git branches while the logs of commits on branches remain intact.

The merge wording can be confusing because we have two methods of merging branches, and one of those ways is actually called “merge,” even though both procedures do essentially the same thing.

Refer to this article for a better understanding of Git Rebase and Merge [Read here](https://www.simplilearn.com/git-rebase-vs-merge-article)

## Task 1:

Add a text file called version01.txt inside the Devops/Git/ with “This is first feature of our application” written inside.
This should be in a branch coming from `master`,
[hint try `git checkout -b dev`],
swithch to `dev` branch ( Make sure your commit message will reflect as "Added new feature").
[Hint use your knowledge of creating branches and Git commit command]

- version01.txt should reflect at local repo first followed by Remote repo for review.
  [Hint use your knowledge of Git push and git pull commands here]

Add new commit in `dev` branch after adding below mentioned content in Devops/Git/version01.txt:
While writing the file make sure you write these lines

- 1st line>> This is the bug fix in development branch
- Commit this with message “ Added feature2 in development branch”

- 2nd line>> This is gadbad code
- Commit this with message “ Added feature3 in development branch

- 3rd line>> This feature will gadbad everything from now.
- Commit with message “ Added feature4 in development branch

Restore the file to a previous version where the content should be “This is the bug fix in development branch”
[Hint use git revert or reset according to your knowledge]

## Task 2:

- Demonstrate the concept of branches with 2 or more branches with screenshot.
- add some changes to `dev` branch and merge that branch in `master`
- as a practice try git rebase too, see what difference you get.

## Note:

We should learn and follow the [best practices](https://www.flagship.io/git-branching-strategies/) , industry follows for branching.

Simple Reference on branching: [video](https://youtu.be/NzjK9beT_CY)

Advance Reference on branching : [video](https://youtu.be/7xhkEQS3dXw)

You can Post on LinkedIn and let us know what you have learned from this task by #90DaysOfDevOps Challenge. Happy Learning :)

[← Previous Day](../day09/README.md) | [Next Day →](../day11/README.md)
