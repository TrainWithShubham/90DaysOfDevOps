**Task 1: Git Merge — Hands-On**

Create a new branch feature-login from main, add a couple of commits to it
Switch back to main and merge feature-login into main
Observe the merge — did Git do a fast-forward merge or a merge commit?
Now create another branch feature-signup, add commits to it — but also add a commit to main before merging
Merge feature-signup into main — what happens this time?


<img width="502" height="177" alt="Screenshot 2026-02-24 at 5 47 58 PM" src="https://github.com/user-attachments/assets/86345162-5cfb-4bc7-84d7-838b4a0b18ce" />
<img width="502" height="177" alt="Screenshot 2026-02-24 at 5 47 58 PM" src="https://github.com/user-attachments/assets/86345162-5cfb-4bc7-84d7-838b4a0b18ce" />


**What is a fast-forward merge?** - if commit in main and branches are linear it will do fast-forward merger, 
**When does Git create a merge commit instead?** -  if commits are in both main and branch before merger , it will not be a fast-fwd merge and it will be merge commit
**What is a merge conflict? (try creating one intentionally by editing the same line in both branches)** - if same line has been edited by differente branch then it will be merge confilict 
                                                                                                      and it need to resolve by one of them.
