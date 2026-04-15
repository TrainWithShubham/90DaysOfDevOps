# Day 13 Answers: Advance Git & GitHub for DevOps Engineers

## Git Branching

Branches are a core concept in Git that allow you to isolate development work without affecting other parts of your repository. Each repository has one default branch, and can have multiple other branches. You can merge a branch into another branch using a pull request.

Branches let you develop features, fix bugs, or safely experiment with new ideas in a contained area of your repository.

## Git Revert and Reset

Git reset and git revert are two commonly used commands that allow you to remove or edit changes you’ve made in the code in previous commits. Both commands can be very useful in different scenarios.

## Git Rebase and Merge

### What Is Git Rebase?

Git rebase is a command that lets users integrate changes from one branch to another, and the commit history is modified once the action is complete. Git rebase helps keep a clean project history.

### What Is Git Merge?

Git merge is a command that allows developers to merge Git branches while keeping the logs of commits on branches intact. Even though merging and rebasing do similar things, they handle commit logs differently.

For a better understanding of Git Rebase and Merge, check out this [article](https://www.simplilearn.com/git-rebase-vs-merge-article).

## Tasks with Answers

### Task 1: Feature Development with Branches

1. **Create a Branch and Add a Feature:**
   - Add a text file called `version01.txt` inside the `Devops/Git/` directory with “This is the first feature of our application” written inside. 

**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day13/image/1%20Create%20a%20Branch%20and%20Add%20a%20Feature.png)

   - Create a new branch from `master`. 
     ```bash
     git checkout -b dev
     ```
**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day13/image/2%20Create%20a%20new%20branch.png)

   - Commit your changes with a message reflecting the added feature.
     ```bash
     git add Devops/Git/version01.txt
     git commit -m "Added new feature"
     ```

**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day13/image/3%20Commit%20your%20changes%20with%20a%20message%20reflecting.png)

2. **Push Changes to GitHub:**
   - Push your local commits to the repository on GitHub.
     ```bash
     git push origin dev
     ```
**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day13/image/4%20Push%20your%20local%20commits%20to%20the%20repository%20on%20GitHub.png)

3. **Add More Features with Separate Commits:**
   - Update `version01.txt` with the following lines, committing after each change:
     - 1st line: `This is the bug fix in development branch`
       ```bash
       echo "This is the bug fix in development branch" >> Devops/Git/version01.txt
       git commit -am "Added feature2 in development branch"
       ```
**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day13/image/5%20This%20is%20the%20bug%20fix%20in%20development%20branch.png)

  - 2nd line: `This is gadbad code`
       ```bash
       echo "This is gadbad code" >> Devops/Git/version01.txt
       git commit -am "Added feature3 in development branch"
       ```
**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day13/image/6%20This%20is%20gadbad%20code.png)

  - 3rd line: `This feature will gadbad everything from now`
       ```bash
       echo "This feature will gadbad everything from now" >> Devops/Git/version01.txt
       git commit -am "Added feature4 in development branch"
       ```
**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day13/image/7%20This%20feature%20will%20gadbad%20everything%20from%20now.png)

4. **Restore the File to a Previous Version:**
   - Revert or reset the file to where the content should be “This is the bug fix in development branch”.
     ```bash
     git revert HEAD~2
     ```
**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day13/image/8%20Restore%20the%20File%20to%20a%20Previous%20Version.png)

This command reverts the last two commits, effectively removing the "gadbad code" and "gadbad everything" lines.

### Task 2: Working with Branches

1. **Demonstrate Branches:**
   - Create 2 or more branches and take screenshots to show the branch structure.

**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day13/image/9%20Create%202%20or%20more%20branches.png)

2. **Merge Changes into Master:**
   - Make some changes to the `dev` branch and merge it into `master`.
     ```bash
     git checkout master
     git merge dev
     ```
**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day13/image/11%20Merge%20Changes%20into%20Master_main.png)

   - Screenshot of branch structure:
     - To visualize the branch structure, you can use `git log` with graph options or a graphical tool like GitKraken. 

**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day13/image/10%20Screenshot%20of%20branch%20structure.png)

3. **Practice Rebase:**
   - Try rebasing and observe the differences.
     ```bash
     git rebase master
     ```
**Answer**

![image](https://github.com/Bhavin213/90DaysOfDevOps/blob/master/2024/day13/image/12%20Practice%20Rebase.png)

   - During a rebase, Git re-applies commits from the current branch (in this case, dev) onto the target branch (master). This results in a linear commit history.

[LinkedIn](https://www.linkedin.com/in/bhavin-savaliya/)
