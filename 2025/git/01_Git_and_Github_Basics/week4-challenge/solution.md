# Solution to Git Basic Tasks

### Commands that I used:

```
git init                   → Initializes a repo in my local  
git add info.txt           → Stages a file to that repo  
git commit -m "Message"    → Final commit  
git push -u origin main    → Push commit to remote  
git pull origin main       → Verify/pull changes  
git log                    → View commit history  
git branch feature-update  → Creates new branch  
git switch <branch name>   → Switching branches  
```

---

### Brief explanation on why branching strategies are important in collaborative development:

- **Isolating features and bug fixes**  
  Creating a new branch rather than working on main/master helps avoid downtime for end users, allowing developers to work in a solo environment and pull changes after staging/testing.

  - **Facilitating parallel development**  
    Allows multiple developers to write code on different features and collaborate efficiently.

    - **Reducing merge conflicts**  
      Prevents conflicts when each developer works in a specified branch.

      - **Enabling effective code reviews**  
        Makes it easier to review new features, updates, or commits before merging.
