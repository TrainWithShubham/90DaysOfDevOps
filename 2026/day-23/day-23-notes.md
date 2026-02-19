1. What is a branch in git?

A. Branch is where you can work on your changes in a file in isolation

2. Why do we use branches instead of committing everything to main?

- We can work in isolation if we use branches
- Best code stays in main branch hence we cannot push unfinalized changes
- It helps to maintain clean history
- Allows code reviews before we push it to main branch

3. What is HEAD in git?

A. It points to current position of branch which points to a commit

4. What happens to your file when you switch branches?

A. If the file is in working directory, it carries along and goes to the other branch. If the changes are commited then it won't take the changes to other branch, it will be clean.

5. What is the difference between origin and upstream ?

A. origin is used to add a reference name when you make a connection to remote repository whereas upstream is the remote repository where you want to finally see your changes.

6. What is the difference between git fetch and git pull?

A. When you do a git fetch we can see if there any changes done in the remote repo which are not present locally while git pull brings those changes to local repo.

7. What is the difference between clone and fork?

A. Clone is creating a local copy of a remote repo. Fork is a github utility where we can create a exact copy of someone else's repo in our github account.

8. When would you clone vs fork?

A. I would clone a repo when there is a need to push my changes to a remote repository while fork is something to create a personal copy of a repo and maintain it yourself.

9. After forking, how do you keep your fork in sync with the original repo?

A. We can use sync fork option in github to sync with original repo