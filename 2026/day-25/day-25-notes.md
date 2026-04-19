## Challenge Tasks
- What is the difference between `--soft`, `--mixed`, and `--hard`?
   - Which one is destructive and why?

         --hard is destructive because it overwrites the working Directory. If  uncommitted code changes in files, git reset --hard will wipe them out instantly.

   - When would you use each one?
        
         --soft -> when we realized that we forgot to add a file to the last commit or want to join two commits together into one.
         --mixed -> when we want to change the commit message and our code is safe, but have to git add it again.
         --hard -> it deletes the commit also and remove content of files that are changed in this commit

   - Should you ever use `git reset` on commits that are already pushed?
      
         If  reset and "Force Push," are used then it delete the history that colleagues might have already pulled. This creates "diverged histories" and can lead to hours of manual cleanup.

### Task 2: Git Revert — Hands-On

   - How is `git revert` different from `git reset`?
     
         git reset is a History Rewriting tool. It physically moves the HEAD pointer backward as if the commit never happened, effectively deleting or moving commits from the history log.

         git revert is a History Appending tool. It doesn't move the pointer backward; instead, it moves the pointer forward by adding a new commit that performs the inverse operation of an older commit.
   - Why is revert considered **safer** than reset for shared branches?
      
         git revert is safer because it does not alter existing history.

         If we have already pushed our code to a shared repository (like GitHub/GitLab), git reset will break the history for everyone else on our team (because their local copy won't match the new, "shorter" history). git revert is perfectly safe to push, as it simply adds a new change that everyone else can pull without conflicts
   - When would you use revert vs reset?

         Use git reset when:

 - You are working only on your local machine and haven't pushed your work to a remote server.

 - You made a mistake in your very recent local commits and want to "clean up" your personal workspace before sharing it.

       Use git revert when:

 - You have already pushed your code to a remote repository.

- You want to undo a specific change but need to maintain a clear audit trail of who reverted what and when.

- You are working on a team and need to ensure your "undo" action doesn't disrupt the history of your teammates.

### Task 3 Git: Reset vs. Revert Comparison

| Feature | `git reset` | `git revert` |
| :--- | :--- | :--- |
| **What it does** | Moves the branch pointer backward to a previous commit. | Creates a **new** commit that performs the inverse (opposite) of an existing commit. |
| **Removes commit from history?** | **Yes.** It "erases" the commits from the history log. | **No.** It keeps the original commits and adds a new one to the log. |
| **Safe for shared/pushed branches?** | **No.** It rewrites history, which causes conflicts for team members. | **Yes.** Since it adds a new commit, it is safe to push. |
| **When to use** | Use for **private, local changes** that  haven't shared/pushed yet. | Use for **public, pushed changes** where we need to undo something safely. |

---

### Task 4: Branching Strategies
# Branching Strategies: Documentation

## 1. Trunk-Based Development
* **How it works:** Developers merge small, frequent updates directly into a single "trunk" (or `main`) branch, often multiple times a day. Long-lived feature branches are avoided.
* **Flow:** 
  `[Main/Trunk] <-- (commit/merge) <-- [Developer A]`
  `[Main/Trunk] <-- (commit/merge) <-- [Developer B]`
* **Used:** High-performing DevOps teams practicing CI/CD.
* **Pros:** Minimal merge conflicts; high visibility; forces automated testing; enables very fast release cycles.
* **Cons:** Requires high developer discipline; relies heavily on automated test suites; can be daunting for beginners.

## 2. GitHub Flow
* **How it works:** A simple, branch-based workflow. Create a descriptive branch from `main`, push it, open a Pull Request (PR) for review, and merge it back into `main` once approved.
* **Flow:** 
  `Main <--- (create branch) --- Feature Branch --- (PR & Merge) ---> Main`
* **Used:** Web applications and SaaS products with only one version in production.
* **Pros:** Simple to learn; keeps `main` deployable; encourages code reviews through PRs.
* **Cons:** Struggles with multiple production versions; if `main` breaks, it blocks deployments.

## 3. GitFlow
* **How it works:** A strict, structured strategy using multiple long-lived branches: `main` (production), `develop` (integration), `feature/`, `release/`, and `hotfix/`.
* **Flow:** 
  `Main <--- (Release) <--- Develop <--- Feature Branch`
* **Used:** Complex projects needing multi-version support or strict release gates.
* **Pros:** Highly organized; excellent for complex release schedules; clear separation of concerns.
* **Cons:** High complexity; slower release cycles; potential for "merge hell"; less suitable for CI/CD.

---

