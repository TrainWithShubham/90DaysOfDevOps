# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick

## Task 1: Git Merge — Hands-On

- Create a new branch feature-login from main, add a couple of commits to it
- Switch back to main and merge feature-login into main
- Observe the merge — did Git do a fast-forward merge or a merge commit?
- Now create another branch feature-signup, add commits to it — but also add a commit to main before merging
- Merge feature-signup into main — what happens this time?
- Answer in your notes:
- What is a fast-forward merge?
- When does Git create a merge commit instead?
- What is a merge conflict? (try creating one intentionally by editing the same line in both branches)

<img width="973" height="954" alt="image" src="https://github.com/user-attachments/assets/38840d55-8e39-4ba3-896e-097ff4ca2529" />
<img width="864" height="953" alt="image" src="https://github.com/user-attachments/assets/e3967b66-a54d-44b3-b22c-d73140a78f8a" />
<img width="790" height="954" alt="image" src="https://github.com/user-attachments/assets/617f253e-5792-4f71-8948-678eb1853133" />
<img width="918" height="942" alt="image" src="https://github.com/user-attachments/assets/c614fbe2-48f4-43ed-8317-e6c6936d0d6d" />

<img width="492" height="591" alt="image" src="https://github.com/user-attachments/assets/829989d9-8242-426e-9e17-050355a6830e" />


## Task 2: Git Rebase — Hands-On

- Create a branch feature-dashboard from main, add 2-3 commits
- While on main, add a new commit (so main moves ahead)
- Switch to feature-dashboard and rebase it onto main
- Observe your git log --oneline --graph --all — how does the history look compared to a merge?


  <img width="945" height="745" alt="image" src="https://github.com/user-attachments/assets/48027815-9dca-4579-b819-de6529aab10e" />
  <img width="870" height="971" alt="image" src="https://github.com/user-attachments/assets/2796bfae-f478-46f4-80fd-f3aab131863f" />
  <img width="1045" height="741" alt="image" src="https://github.com/user-attachments/assets/46c697d2-7f99-4e25-9ffe-00a4088eab4b" />
  <img width="1045" height="669" alt="image" src="https://github.com/user-attachments/assets/d302afdb-6250-49e4-bc6f-d6dab935a690" />
  <img width="811" height="829" alt="image" src="https://github.com/user-attachments/assets/09243ae1-c9ff-4c90-aa14-08f55e9355be" />
  <img width="816" height="228" alt="image" src="https://github.com/user-attachments/assets/9ed3216a-c5bf-4216-baae-7693f10a2e07" />
<img width="1021" height="729" alt="image" src="https://github.com/user-attachments/assets/33996fb8-4c63-411c-abde-e25501a66026" />
<img width="1047" height="830" alt="image" src="https://github.com/user-attachments/assets/b580317d-a57f-4f06-883d-b17af7de36e8" />


- Answer in your notes:
     - What does rebase actually do to your commits?
    Ans:git rebase moves your branch’s commits on top of another branch. It does takes your branch’s commits, temporary removes them, apply them again on the top of the other branch. And create new branch. Create new Commit Id.

     - How is the history different from a merge?
       Git rebase is different from a merge because it change non linear  to linear.
       
      - Why should you never rebase commits that have been pushed and shared with others?
  Ans: Rebase rewrites commit history.When you push commits, others may already have pulled them. If you rebase and push again,Commit IDs will remain change, other developers now have old commits. Git sees them as completely different history,causes conflicts, confusion, broken branches.
  
     


## When would you use `rebase` vs `merge`?

---

## 🔹 Use Rebase When:

- You are working on your **local feature branch**
- You want to **clean up commits** before creating a Pull Request (PR)
- You prefer a **clean, linear commit history**
- You want to update your feature branch with the latest `main` changes before merging
- The branch is **not shared** with other team members



## 🔹 Use Merge When:

- The branch is already pushed and shared
- You are working in a team environment
- You want to preserve complete branch history
- You are merging a feature branch into main
- You do not want to rewrite commit history

## Task 3: Squash Commit vs Merge Commit

<img width="1063" height="607" alt="image" src="https://github.com/user-attachments/assets/189d5af5-b688-4a47-b2a7-9f1c4695a117" />
<img width="945" height="661" alt="image" src="https://github.com/user-attachments/assets/af9fc492-3002-4536-8d09-971359b72f2c" />
<img width="1187" height="374" alt="image" src="https://github.com/user-attachments/assets/8c1f6baa-b63a-4b32-8529-ad6dabd175f6" />


### What does squash merging do?
Squash merging combines all commits from a feature branch into a single commit before merging it into the main branch.

### When would you use squash merge vs regular merge?
- **Squash Merge**: Use when you want a clean and simple commit history.
- **Regular Merge**: Use when you want to preserve all individual commits and maintain the complete development history.

### What is the trade-off of squashing?
The main trade-off of squashing is that you lose the detailed commit history of the feature branch, which can make deep debugging or tracking specific changes more difficult.

## Task 5: Cherry Picking

<img width="987" height="908" alt="image" src="https://github.com/user-attachments/assets/598ac2b5-10a0-4f39-90f1-a4eeb0786965" />
<img width="960" height="937" alt="image" src="https://github.com/user-attachments/assets/91a4b2ba-5c50-449a-bbcc-42cc265adb7b" />

























