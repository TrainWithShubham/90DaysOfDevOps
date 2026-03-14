Task 1: Fork and Clone the Repository
git clone <https://github.com/apurva-kri/90DaysOfDevOps.git>
cd 2025/git/01_Git_and_Github_Basics
mkdir week-4-challenge
cd week-4-challenge
git init
vim info.txt
git add info.txt
git commit -m "Initial commit: Add info.txt with introductory content"
Task 3: Configure Remote URL with PAT and Push/Pull
git remote set-url origin https://@github.com/apurva-kri/90DaysOfDevOps.git
git push -u origin main
git pull origin main
Task 4: Explore Your Commit History
git log
Task 5: Advanced Branching and Switching
git branch feature-update
git switch feature-update
git add info.txt
git commit -m "Feature update: Enhance info.txt with additional details"
git push origin feature-update

Branching strategies are essential in collaborative development because they help teams work together efficiently and safely. By isolating features and bug fixes in separate branches, developers can work without affecting the stability of the main codebase. This separation also enables parallel development, allowing multiple team members to work on different tasks simultaneously without interfering with each other’s progress.

Well-defined branching practices help reduce merge conflicts by keeping changes organized and focused within their own branches. Finally, they make code reviews more effective, as reviewers can easily understand the purpose of a branch, evaluate changes in isolation, and ensure quality before merging into the main branch.

