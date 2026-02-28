# 📘 Day 24 – Advanced Git (Merge, Rebase, Squash, Stash, Cherry-Pick)

---

# 1️⃣ Git Merge

## 🔹 Fast-Forward Merge

Condition:
Target branch has not moved since feature branch was created.

Example:

A → B → C (feature)
      ↑
    master

After merge:

A → B → C (master)

✔ No merge commit  
✔ Pointer just moves forward  

---

## 🔹 Merge Commit

Condition:
Both branches moved independently after common ancestor.

Before:

        D (feature)
       /
A → B → C
            \
             E (master)

After merge:

        D
       /  \
A → B → C → E → M

✔ Merge commit (M) created  
✔ Two parents  
✔ Branch history preserved  

---

## 🔹 Merge Conflict

Occurs when:
- Same file
- Same line(s)
- Modified differently

Resolution:
1. Open file
2. Remove conflict markers
3. Keep correct logic
4. git add
5. Complete merge

---

# 2️⃣ Git Rebase

## 🔹 What Rebase Does

Replays current branch commits on top of another branch.

Before:

        D
       /
A → B → C → E

After rebase:

A → B → C → E → D'

✔ Linear history  
✔ No merge commit  
✔ Commit hashes change  

---

## 🔹 Why Hash Changes?

Commit hash depends on:
- Content
- Parent
- Metadata

Changing parent → new hash.

---

## 🔹 When to Use Rebase

✔ Private feature branches  
✔ Before merging for clean history  

---

## 🔹 When NOT to Use Rebase

❌ Shared branches  
❌ Already pushed commits  
❌ Production branches  

Rebase rewrites history → force push required.

---

# 3️⃣ Squash Merge

## 🔹 What It Does

Combines all commits into one.

Feature branch:

Fix typo  
Refactor logic  
Add validation  

After squash:

Add profile feature  

✔ Clean history  
✔ One commit per feature  
❌ Individual commits lost  

---

# 4️⃣ Git Stash

## 🔹 Purpose

Temporarily store uncommitted changes.

---

## 🔹 Commands

git stash  
git stash apply  
git stash pop  
git stash list  

---

## 🔹 Important

- Not branch-specific
- Applies to current branch
- Can cause conflicts
- Stored locally

---

# 5️⃣ Cherry-Pick

## 🔹 What It Does

Applies specific commit diff to current branch.

git cherry-pick <hash>

---

## 🔹 Internally

- Applies patch (diff)
- Uses surrounding context lines
- If context mismatch → conflict

---

## 🔹 Conflict Causes

✔ Logical dependency  
✔ Same line modification  
✔ Context mismatch  
✔ Ambiguous identical blocks  

---

## 🔹 Best Practices

✔ Keep commits independent  
✔ Inspect with git show  
✔ Use git cherry-pick -x  
✔ Separate hotfix from feature work  

---

# 🎯 Final Learnings

Merge → preserves history  
Rebase → rewrites history  
Squash → compresses history  
Stash → temporary working storage  
Cherry-pick → selective patch application  
