# Week 4: Git & GitHub Advanced Challenge 

This challenge covers advanced Git concepts essential for real-world DevOps workflows. By the end of this challenge, you will:  

- Understand how to work with Pull Requests effectively.  
- Learn to undo changes using Reset & Revert.  
- Use Stashing to manage uncommitted work.  
- Apply Cherry-picking for selective commits.  
- Keep a clean commit history using Rebasing.  
- Learn industry-standard Branching Strategies.  

## **Topics Covered**  
1. Pull Requests – Collaborating in teams.  
2. Reset & Revert – Undo changes safely.  
3. Stashing – Saving work temporarily.  
4. Cherry-picking – Selecting specific commits.  
5. Rebasing – Maintaining a clean history.  
6. Branching Strategies – Industry best practices.  

## **Challenge Tasks**  

### **Task 1: Working with Pull Requests (PRs)**  
**Scenario:** You are working on a new feature and need to merge your changes into the main branch using a Pull Request.  

1. Fork a repository and clone it locally.  
   ```bash
   git clone <your-forked-repo-url>
   cd <repo-name>
   ```  
2. Create a feature branch and make changes.  
   ```bash
   git checkout -b feature-branch
   echo "New Feature" >> feature.txt
   git add .
   git commit -m "Added a new feature"
   ```  
3. Push the changes and create a Pull Request.  
   ```bash
   git push origin feature-branch
   ```  
4. Open a PR on GitHub, request a review, and merge it once approved.  

**Document in `solution.md`**  
- Steps to create a PR.  
- Best practices for writing PR descriptions.  
- Handling review comments.  

---

### **Task 2: Undoing Changes – Reset & Revert**  
**Scenario:** You accidentally committed incorrect changes and need to undo them.  

1. Create and modify a file.  
   ```bash
   echo "Wrong code" >> wrong.txt
   git add .
   git commit -m "Committed by mistake"
   ```  
2. Soft Reset (keeps changes staged).  
   ```bash
   git reset --soft HEAD~1
   ```  
3. Mixed Reset (unstages changes but keeps files).  
   ```bash
   git reset --mixed HEAD~1
   ```  
4. Hard Reset (removes all changes).  
   ```bash
   git reset --hard HEAD~1
   ```  
5. Revert a commit safely.  
   ```bash
   git revert HEAD
   ```  

**Document in `solution.md`**  
- Differences between `reset` and `revert`.  
- When to use each method.  

---

### **Task 3: Stashing - Save Work Without Committing**  
**Scenario:** You need to switch branches but don’t want to commit incomplete work.  

1. Modify a file without committing.  
   ```bash
   echo "Temporary Change" >> temp.txt
   git add temp.txt
   ```  
2. Stash the changes.  
   ```bash
   git stash
   ```  
3. Switch to another branch and apply the stash.  
   ```bash
   git checkout main
   git stash pop
   ```  

**Document in `solution.md`**  
- When to use `git stash`.  
- Difference between `git stash pop` and `git stash apply`.  

---

### **Task 4: Cherry-Picking - Selectively Apply Commits**  
**Scenario:** A bug fix exists in another branch, and you only want to apply that specific commit.  

1. Find the commit to cherry-pick.  
   ```bash
   git log --oneline
   ```  
2. Apply a specific commit to the current branch.  
   ```bash
   git cherry-pick <commit-hash>
   ```  
3. Resolve conflicts if any.  
   ```bash
   git cherry-pick --continue
   ```  

**Document in `solution.md`**  
- How cherry-picking is used in bug fixes.  
- Risks of cherry-picking.  

---

### **Task 5: Rebasing - Keeping a Clean Commit History**  
**Scenario:** Your branch is behind the main branch and needs to be updated without extra merge commits.  

1. Fetch the latest changes.  
   ```bash
   git fetch origin main
   ```  
2. Rebase the feature branch onto main.  
   ```bash
   git rebase origin/main
   ```  
3. Resolve conflicts and continue.  
   ```bash
   git rebase --continue
   ```  

**Document in `solution.md`**  
- Difference between `merge` and `rebase`.  
- Best practices for rebasing.  

---

### **Task 6: Branching Strategies Used in Companies**  
**Scenario:** Understand real-world branching strategies used in DevOps workflows.  

1. Research and explain Git workflows:  
   - Git Flow (Feature, Release, Hotfix branches).  
   - GitHub Flow (Main + Feature branches).  
   - Trunk-Based Development (Continuous Integration).  

2. Simulate a Git workflow using branches.  
   ```bash
   git branch feature-1
   git branch hotfix-1
   git checkout feature-1
   ```  

**Document in `solution.md`**  
- Which strategy is best for DevOps and CI/CD.  
- Pros and cons of different workflows.  

---

## **How to Submit**  

1. **Push your work to GitHub.**  
   ```bash
   git add .
   git commit -m "Completed Git & GitHub Advanced Challenge"
   git push origin main
   ```  

2. **Create a Pull Request.**  
   - Title:  
     ```
     Git & GitHub Advanced Challenge - Completed
     ```
   - PR Description:  
     - Steps followed for each task.  
     - Screenshots or logs (if applicable).  
     - 
3. **Share Your Experience on LinkedIn:**  
   - Write a LinkedIn post summarizing your Week 4 Git & GitHub challenge experience.  
   - In your post, include:
     - A brief description of the challenge and what you learned.
     - Screenshots or excerpts from your `solution.md` that highlight key steps or interesting findings.
     - The hashtags: **#90DaysOfDevOps #Git #GitHub #VersionControl #DevOps**
     - Optionally, links to any blog posts or related GitHub repositories that further explain your journey.
     
---

## **Additional Resources**  
- [Git Official Documentation](https://git-scm.com/doc)  
- [Git Reset & Revert Guide](https://www.atlassian.com/git/tutorials/resetting-checking-out-and-reverting)  
- [Git Stash Explained](https://git-scm.com/book/en/v2/Git-Tools-Stashing-and-Cleaning)  
- [Cherry-Picking Best Practices](https://www.atlassian.com/git/tutorials/cherry-pick)  
- [Branching Strategies for DevOps](https://www.atlassian.com/git/tutorials/comparing-workflows)  

---

Happy coding and best of luck with this challenge! Document your journey thoroughly and be sure to explore the additional resources if you get stuck.
