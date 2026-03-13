# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry-Pick

---

## Task 1: Git Merge

### Hands-On Walkthrough

#### Fast-forward merge (`feature-login`)

```bash
# Start from main, create feature-login
git switch -c feature-login

# Add commits (main has NOT moved since we branched)
echo "login form html" >> login.md && git add . && git commit -m "feat: add login form"
echo "login validation" >> login.md && git add . && git commit -m "feat: add login validation"

# Switch back to main and merge
git switch main
git merge feature-login
# Output: Updating a1c88f0..7d2e04a
#         Fast-forward
```

Because `main` had no new commits since `feature-login` was created, Git simply moved the `main` pointer forward. No merge commit was created.

```
Before:           main
                    ↓
        A ── B ── C
                   \
                    D ── E  ← feature-login

After fast-forward:
        A ── B ── C ── D ── E
                             ↑
                           main (moved forward)
```

---

#### Merge commit (`feature-signup`)

```bash
git switch -c feature-signup
echo "signup form" >> signup.md && git add . && git commit -m "feat: add signup form"

# Add a commit to main BEFORE merging — this is the key difference
git switch main
echo "readme update" >> README.md && git add . && git commit -m "docs: update readme"

# Now merge — branches have diverged
git merge feature-signup
# Git opens editor for merge commit message
# Output: Merge made by the 'ort' strategy
```

```
Before:           main
                    ↓
        A ── B ── C ── M1  ← (new commit on main)
                   \
                    D ── E  ← feature-signup

After merge commit:
        A ── B ── C ── M1 ── ●  ← merge commit (main)
                   \        /
                    D ── E
```

---

### Intentional Merge Conflict

```bash
git switch -c feature-conflict
# Edit line 1 of config.md on this branch
echo "timeout=60" > config.md && git add . && git commit -m "set timeout to 60"

git switch main
# Edit the SAME line 1 of config.md on main
echo "timeout=30" > config.md && git add . && git commit -m "set timeout to 30"

git merge feature-conflict
# CONFLICT (content): Merge conflict in config.md
# Automatic merge failed; fix conflicts and then commit the result.
```

The file now contains conflict markers:
```
<<<<<<< HEAD
timeout=30
=======
timeout=60
>>>>>>> feature-conflict
```

To resolve: edit the file to keep the correct value, then:
```bash
git add config.md
git commit -m "resolve: keep timeout=60 from feature-conflict"
```

---

### Answers

**What is a fast-forward merge?**

A fast-forward merge happens when the branch being merged is directly ahead of the target branch — meaning the target has no new commits since the branch was created. Git doesn't need to create a merge commit; it just moves the target branch pointer forward to the tip of the feature branch. The result is a perfectly linear history with no merge commit at all.

**When does Git create a merge commit instead?**

Git creates a merge commit when both branches have diverged — i.e., both have commits the other doesn't have. Git finds the common ancestor commit, applies both sets of changes, and records a new commit with two parents. This preserves the full branching structure in the history.

**What is a merge conflict?**

A merge conflict occurs when two branches make changes to the same part of the same file and Git cannot automatically determine which version to keep. Git pauses the merge, marks the conflicting sections in the file with `<<<<<<<`, `=======`, and `>>>>>>>` markers, and waits for you to manually choose the correct content. After resolving, you stage the file and complete the merge with a commit.

---

## Task 2: Git Rebase

### Hands-On Walkthrough

```bash
git switch main
git switch -c feature-dashboard
echo "widget 1" >> dashboard.md && git add . && git commit -m "feat: add widget 1"
echo "widget 2" >> dashboard.md && git add . && git commit -m "feat: add widget 2"
echo "widget 3" >> dashboard.md && git add . && git commit -m "feat: add widget 3"

# Move main ahead (simulate another dev's work)
git switch main
echo "navbar update" >> navbar.md && git add . && git commit -m "feat: update navbar"

# Rebase feature-dashboard onto the new main
git switch feature-dashboard
git rebase main
```

**`git log --oneline --graph --all` after rebase:**
```
* f9a1b2c (HEAD -> feature-dashboard) feat: add widget 3
* 8e3d4a1 feat: add widget 2
* 2b5c6f0 feat: add widget 1
* 7d2e04a (main) feat: update navbar
* a1c88f0 docs: update readme
* 3b6d711 Initial commit
```

The history is perfectly linear — no merge commit, no branch fork visible.

**Compare with what merge would look like:**
```
*   c3f8a21 (HEAD -> feature-dashboard) Merge branch 'main' into feature-dashboard
|\
| * 7d2e04a (main) feat: update navbar
* | f9a1b2c feat: add widget 3
* | 8e3d4a1 feat: add widget 2
* | 2b5c6f0 feat: add widget 1
|/
* a1c88f0 docs: update readme
```

---

### Answers

**What does rebase actually do to your commits?**

Rebase re-plays your commits on top of a new base commit. For each commit on your branch, Git:
1. Temporarily removes it (saves the diff as a patch)
2. Moves to the new base (the tip of `main`)
3. Re-applies the patch as a brand new commit

The new commits have different SHA hashes even if the content is identical — they are literally new commits with a different parent. The old commits are abandoned and will eventually be garbage-collected.

**How is the history different from a merge?**

Merge preserves the true history — you can see exactly when branches diverged and converged. Rebase rewrites history to appear as though all work happened sequentially on a single line. Rebase produces a cleaner `git log`, but merge is a more truthful record of what actually happened.

**Why should you never rebase commits that have been pushed and shared?**

When you rebase, Git creates entirely new commits with new hashes. If collaborators have already based work on your original commits, their history and yours now disagree about what those commits are. When they try to push or pull, Git sees two divergent histories and either produces confusing conflicts or, if forced, silently discards their work. The golden rule: **never rewrite public history**.

**When to use rebase vs merge?**

| Situation | Use |
|-----------|-----|
| Keeping a local feature branch up to date with main | Rebase |
| Preparing clean commits before opening a PR | Rebase (interactive) |
| Merging a completed feature into main | Merge (preserves context) |
| Working on a shared branch others are using | Merge only |
| Want linear history in a solo or small team project | Rebase |

---

## Task 3: Squash Commit vs Merge Commit

### Hands-On Walkthrough

```bash
# feature-profile: several messy commits
git switch -c feature-profile
echo "v1" >> profile.md && git add . && git commit -m "wip: start profile"
echo "v2" >> profile.md && git add . && git commit -m "fix: typo"
echo "v3" >> profile.md && git add . && git commit -m "fix: formatting"
echo "v4" >> profile.md && git add . && git commit -m "wip: almost done"
echo "v5" >> profile.md && git add . && git commit -m "feat: profile complete"

git switch main
git merge --squash feature-profile
# Stages all changes but does NOT create a commit yet
git commit -m "feat: add user profile page"

git log --oneline
# → only ONE new commit on main despite 5 commits on the branch
```

```bash
# feature-settings: regular merge for comparison
git switch -c feature-settings
echo "s1" >> settings.md && git add . && git commit -m "feat: settings layout"
echo "s2" >> settings.md && git add . && git commit -m "feat: settings logic"

git switch main
git merge feature-settings --no-ff
# → creates a merge commit; both individual commits visible in git log
```

---

### Answers

**What does squash merging do?**

`git merge --squash` takes all commits from the feature branch, combines their diffs into a single set of staged changes in your working directory, but does NOT create a commit. You then write one clean, meaningful commit yourself. The feature branch's individual commits never appear in `main`'s history.

**When to use squash vs regular merge?**

| Scenario | Use |
|----------|-----|
| Branch has messy WIP / fixup commits not worth preserving | Squash |
| Feature has well-structured, meaningful commits worth keeping | Regular merge |
| Team convention is one commit per PR | Squash |
| You want full audit trail of development steps | Regular merge |

**Trade-off of squashing**

You lose the granular history of how the feature was built. If a bug is introduced, `git bisect` can only narrow it to the squash commit — not the specific small commit that caused it. Squashing also makes it harder to understand the reasoning behind individual changes when reading history later.

---

## Task 4: Git Stash

### Hands-On Walkthrough

```bash
# Make uncommitted changes
echo "work in progress" >> feature.md

# Try to switch branches — Git warns you
git switch main
# error: Your local changes to the following files would be overwritten by checkout:
#   feature.md
# Please commit or stash your changes before switching.

# Stash the work-in-progress
git stash push -m "WIP: feature.md changes"
# Saved working directory and index state On feature-1: WIP: feature.md changes

# Now the switch works
git switch main
# Do urgent work on main...
echo "hotfix" >> navbar.md && git add . && git commit -m "fix: urgent navbar hotfix"

# Go back and restore stashed work
git switch feature-1
git stash pop
# Applied and dropped stash@{0}
```

#### Stashing multiple times and listing

```bash
git stash push -m "experiment A"
# make more changes
git stash push -m "experiment B"

git stash list
# stash@{0}: On feature-1: experiment B
# stash@{1}: On feature-1: experiment A
# stash@{2}: On feature-1: WIP: feature.md changes

# Apply a specific stash by index (does not drop it)
git stash apply stash@{1}

# Drop a stash manually after applying
git stash drop stash@{1}

# Or apply and drop in one step
git stash pop stash@{0}
```

---

### Answers

**`git stash pop` vs `git stash apply`**

| | `git stash pop` | `git stash apply` |
|---|---|---|
| Applies stash? | Yes | Yes |
| Removes from stash list? | Yes (drops it) | No (keeps it) |
| Use when | You're done with this stash | You want to apply to multiple branches or keep as backup |

**Real-world stash scenarios**

- A critical production bug is reported mid-feature — stash your WIP, switch to `main`, create a hotfix branch
- You started coding on the wrong branch — stash, switch to the correct branch, pop
- You want to test how the codebase behaves without your changes temporarily
- Quickly check something on another branch without making a throwaway commit

---

## Task 5: Cherry-Pick

### Hands-On Walkthrough

```bash
git switch -c feature-hotfix
echo "change A" >> app.md && git add . && git commit -m "fix: change A"
echo "change B" >> app.md && git add . && git commit -m "fix: change B  ← we want this one"
echo "change C" >> app.md && git add . && git commit -m "feat: change C"

git log --oneline
# a3f9c21 feat: change C
# 7b2d1e0 fix: change B  ← target commit hash
# 4c8a0f3 fix: change A

git switch main
git cherry-pick 7b2d1e0
# [main f1e2d3c] fix: change B
# 1 file changed, 1 insertion(+)

git log --oneline
# f1e2d3c fix: change B    ← only this commit, applied cleanly
# ...previous main commits
```

---

### Answers

**What does cherry-pick do?**

`git cherry-pick <hash>` takes the diff introduced by a specific commit and re-applies it as a new commit on the current branch. Like rebase, it creates a new commit with a new hash — the content is the same but the parent lineage is different. It does not move or delete the original commit from its source branch.

**When to use cherry-pick in a real project**

- A bug fix was committed to a feature branch but needs to go to `main` immediately without merging the entire feature
- You're maintaining multiple release branches (v1.x, v2.x) and need to backport a security patch to each
- Someone accidentally committed a useful change to the wrong branch
- You want to apply a single config change from an experimental branch to production

**What can go wrong with cherry-picking**

- **Duplicate commits**: If you later merge the source branch, Git may not recognize the cherry-picked commit as already applied, resulting in duplicate changes (or conflicts)
- **Context loss**: A commit may depend on earlier commits that don't exist on the target branch, causing conflicts
- **Diverging history**: The same logical change now exists as two different commits with different hashes, making history harder to read
- **Over-use as a crutch**: Frequent cherry-picking is often a sign of a branching strategy that should be revisited

---

*Day 24 complete — merge strategies, rebase mechanics, stash workflow, and cherry-pick all covered.*