## Day 23 – Notes

### 1. What is a branch in Git?

A branch in Git is an independent line of development.  
It allows you to work on features, fixes, or experiments without affecting the main codebase.

---

### 2. Why do we use branches instead of committing everything to main?

We use branches to:

- Develop features safely without breaking main
- Fix bugs in isolation
- Allow multiple developers to work simultaneously
- Keep production code stable

Changes are merged into main only after testing and review.

---

### 3. What is HEAD in Git?

HEAD is a pointer that refers to the currently checked-out branch and its latest commit.

It tells Git where you are in the commit history.

---

### 4. What happens when you switch branches?

When you switch branches:

- Git updates your working directory to match the selected branch.
- Files reflect the state of the branch’s latest commit.
- Commits from other branches are not visible unless merged.

If you create a new branch, it starts from the commit you are currently on.

