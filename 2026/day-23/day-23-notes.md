# Day 23 – Git Branching & Working with GitHub


## Task 1: Understanding Branches

1. What is a branch in Git?
Ans:
- A branch is a separate line of development in Git.
- It allows you to work on new features or fixes without affecting the main codebase.
- By default, Git has a branch called main (earlier master).
- Technically, a branch is just a pointer to a commit.

📌 Example:
- Create a new feature branch → develop → merge into main.
  
2. Why do we use branches instead of committing everything to main?
Ans: Because main is final copy and its used for production. It also called golden copy.
We use branches because:
- Avoid breaking production code
- Work on multiple features in parallel
- Safe bug fixing
- Easy code review (via pull/merge requests)
- Better team collaboration

  
3. What is HEAD in Git?
Ans: 
- HEAD is a pointer to the current commit you are working on.
- Usually, HEAD points to the latest commit of the current branch.
- When you switch branches, HEAD moves to that branch.

4. What happens to your files when you switch branches?
Ans :
- Updates your working directory.
- Replaces files with the version from that branch.
- Moves HEAD to the new branch.

## Task 2, Task3, Task 4 Task 5:
List all branches in your repo
Create a new branch called feature-1
Switch to feature-1
Create a new branch and switch to it in a single command — call it feature-2
Try using git switch to move between branches — how is it different from git checkout?
Make a commit on feature-1 that does not exist on main
Switch back to main — verify that the commit from feature-1 is not there
Delete a branch you no longer need
Add all branching commands to your git-commands.md

<img width="906" height="983" alt="image" src="https://github.com/user-attachments/assets/6189a092-4b9e-4a6e-b4c1-b1f50dd3b253" />
<img width="1265" height="972" alt="image" src="https://github.com/user-attachments/assets/16fefcc6-1516-49b8-abb0-7c592e515131" />
<img width="991" height="993" alt="image" src="https://github.com/user-attachments/assets/21fc2214-394e-44c4-8638-0936faad699d" />
<img width="869" height="999" alt="image" src="https://github.com/user-attachments/assets/bf95cde2-6330-41ae-86a6-641bcf4f5ffd" />
<img width="789" height="333" alt="image" src="https://github.com/user-attachments/assets/91816be9-93d4-4d4c-ae7b-749f8c03b5b3" />







