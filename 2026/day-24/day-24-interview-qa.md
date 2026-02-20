# 🎯 Day 24 – Interview Q&A

---

## Q1: What is Fast-Forward Merge?

When the target branch has not moved and Git simply moves the pointer forward without creating a merge commit.

---

## Q2: What is the difference between merge and rebase?

Merge preserves branch structure and creates a merge commit.  
Rebase rewrites history by replaying commits and making history linear.

---

## Q3: Why does rebase change commit hashes?

Because commit hash depends on parent commit. Changing parent creates new hash.

---

## Q4: When is rebase dangerous?

When used on shared or already pushed branches because it rewrites history.

---

## Q5: What is squash merge?

It combines multiple commits into one single commit before merging.

---

## Q6: What is stash used for?

To temporarily store uncommitted changes without committing.

---

## Q7: What does cherry-pick do?

It applies the diff of a specific commit onto the current branch.

---

## Q8: Why does cherry-pick conflict?

Because of:
- Context mismatch
- Logical dependency
- Overlapping changes
