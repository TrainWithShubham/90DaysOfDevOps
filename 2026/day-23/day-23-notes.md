# Day 23 – Notes

---

## 1. What is a branch in Git?

A branch in Git is an independent line of development.  
It allows you to work on features, fixes, or experiments without affecting the main codebase.

---

## 2. Why do we use branches instead of committing everything to main?

We use branches to:

- Develop features safely without breaking main
- Fix bugs in isolation
- Allow multiple developers to work simultaneously
- Keep production code stable

Changes are merged into main only after testing and review.

---

## 3. What is HEAD in Git?

HEAD is a pointer that refers to the currently checked-out branch and its latest commit.  

It tells Git where you are in the commit history.

---

## 4. What happens when you switch branches?

When you switch branches:

- Git updates your working directory to match the selected branch.
- Files reflect the state of the branch’s latest commit.
- Commits from other branches are not visible unless merged.

If you create a new branch, it starts from the commit you are currently on.

---

## 5. origin vs upstream

- `origin` is the default name of the remote repository connected to your local repo.
- `upstream` is usually used to refer to the original repository when working with forks.

---

## 6. git fetch vs git pull

- `git fetch` downloads changes from the remote repository but does not merge them into the current branch.
- `git pull` downloads changes and immediately merges them into the current branch.

```
git pull = git fetch + git merge
```

---

## 7. Clone vs Fork

- Clone is copying a repository from GitHub to your local machine.
- Fork is creating a copy of someone else's repository under your own GitHub account.

Clone is used to work locally.  
Fork is used when contributing to someone else's project without direct access.

---

## 8. How to Keep a Fork Updated

To keep a fork updated:

1. Add original repository as upstream  
2. Run `git fetch upstream`  
3. Run `git merge upstream/main`  

