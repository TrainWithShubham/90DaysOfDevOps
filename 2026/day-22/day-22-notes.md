Answer these questions in your own words (add them to a `day-22-notes.md` file):

1. What is the difference between `git add` and `git commit`?

   git add - it add the file from untracked to staged state
   git commit - it now move the file state from staged to tracked(committed)

3. What does the **staging area** do? Why doesn't Git just commit directly?

   it doesn't commit directly coz it allows you to control which file to commit and have a control flow.

5. What information does `git log` show you?

  git log shows the commit ID , name and email along witht date and time of the commit.

6. What is the `.git/` folder and what happens if you delete it?

 ./git folder is the brain of the git, it hold all the main file like config,index,object etc. If we delete ./git the folder will become a normal folder and all history will be gone

7. What is the difference between a **working directory**, **staging area**, and **repository**?

working directory - here you can create a file , edit a file, remove a file
staging area - area where you are planning to commit the file, you can edit the file again or push it to commit.
Reposotiry - here you can save the file to the git repo.


