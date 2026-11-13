# 📝 Week 4 Challenge — Solution & Implementation

### 90 Days of DevOps | Git & GitHub | DevOps Batch 9

<p align="center">
  <img src="https://img.shields.io/badge/Week-04-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Topic-Git%20%26%20GitHub-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Type-Hands--On%20Implementation-green?style=for-the-badge" />
</p>

## 📌 Introduction

This document contains the practical implementation of the **Week 4 Git & GitHub Challenge** as part of the 90 Days of DevOps journey.

The objective was to understand Git fundamentals, repository management, branching, remote operations, authentication, commit history, and collaboration through Pull Requests.

Instead of simply learning commands, I performed hands-on exercises to understand how Git works in real-world development workflows.

---

## 🛠️ Environment Setup

| Component | Details |
|---|---|
| Operating System | Linux / Ubuntu / Windows (update accordingly) |
| Version Control | Git |
| Repository Hosting | GitHub |
| Authentication | HTTPS / PAT and SSH |
| Code Editor | VS Code |
| Challenge Repository | 90DaysOfDevOps |

### Verify Git Installation

```bash
git --version
```

**Observation:** Verified that Git is installed and ready to use.

---

# 🚀 Task 1 — Fork & Clone Repository

### Objective
Create a personal copy of the original repository and clone it to the local machine.

### Step 1: Fork Repository

Original repository:

[90DaysOfDevOps — GitHub](https://github.com/LondheShubham153/90DaysOfDevOps)

Forked the repository into my GitHub account.

### Step 2: Clone Repository

```bash
git clone https://github.com/<username>/90DaysOfDevOps.git
```

### Step 3: Navigate to the Project Directory

```bash
cd 90DaysOfDevOps/2025/git/01_Git_and_Github_Basics
```

### Step 4: Verify Repository

```bash
git status
git remote -v
```

**Key Learning:**

- Fork creates a copy of another user's repository on GitHub.
- Clone downloads a repository to the local machine.
- Remote connects a local repository with a hosted repository.

### 📸 Evidence

Add your fork and clone screenshots here.

```text
screenshots/
├── fork.png
└── clone.png
```

---

# 📁 Task 2 — Create Files and Commit Changes

### Objective
Practice creating files, staging changes, and saving them as commits.

### Step 1: Create Challenge Directory

```bash
mkdir week-4-challenge
cd week-4-challenge
```

### Step 2: Create an Information File

```bash
touch info.txt
```

Added introductory information to the file.

### Step 3: Check Repository Status

```bash
git status
```

### Step 4: Stage Changes

```bash
git add info.txt
```

### Step 5: Commit Changes

```bash
git commit -m "Initial commit: Add introductory information"
```

**Key Learning:**

- `git add` moves changes into the staging area.
- `git commit` saves staged changes in the repository history.
- `git status` displays the current state of the working directory.

### 📸 Evidence

Add screenshots showing file creation, staging, and commit.

```text
screenshots/
├── file-creation.png
└── initial-commit.png
```

---

# 🔐 Task 3 — Remote Configuration and Authentication

### Objective
Understand how local repositories communicate with GitHub using HTTPS authentication.

### Step 1: Verify Remote URL

```bash
git remote -v
```

The `origin` remote should point to my fork.

### Step 2: HTTPS Authentication

Used GitHub authentication through Git Credential Manager or a Personal Access Token when prompted.

**Note:** PATs should never be exposed in remote URLs, screenshots, command history, or committed files.

### Step 3: Push Changes

```bash
git push origin <branch-name>
```

### Step 4: Fetch Remote Updates

```bash
git fetch origin
```

### Step 5: Pull Remote Changes

```bash
git pull origin main
```

**Key Learning:**

| Command | Purpose |
|---|---|
| `git remote -v` | Displays configured remotes |
| `git push` | Uploads local commits to remote |
| `git fetch` | Downloads remote updates without merging |
| `git pull` | Fetches and integrates remote changes |

### 📸 Evidence

```text
screenshots/
├── remote-configuration.png
└── push-operation.png
```

---

# 📜 Task 4 — Explore Git Commit History

### Objective
Understand how Git maintains the history of project changes.

### Commands Executed

```bash
git log
git log --oneline
git log --oneline --graph --all
git show <commit-id>
```

### Observations

Git commit history provides information about:

1. Commit hash — unique identifier of a commit.
2. Author — person who created the commit.
3. Date — when the commit was created.
4. Commit message — description of the changes.
5. Changes — files and code modifications introduced.

**Key Learning:**

Git maintains a history of changes, making it easier to track development and investigate previous modifications.

### 📸 Evidence

```text
screenshots/
└── git-log.png
```

---

# 🌿 Task 5 — Branching and Switching

### Objective
Understand how branches allow developers to work independently without directly modifying the main branch.

### Step 1: Create and Switch to a Feature Branch

```bash
git switch -c feature-update
```

### Step 2: Modify the File

Updated `info.txt` with additional information.

### Step 3: Stage and Commit

```bash
git add info.txt
git commit -m "Feature update: Enhance introductory information"
```

### Step 4: Push Feature Branch

```bash
git push -u origin feature-update
```

### Step 5: Verify Branches

```bash
git branch
git branch -a
```

**Key Learning:**

- Branches isolate development work.
- Multiple developers can work on different branches.
- Feature branches help maintain stability in the main branch.

### 📸 Evidence

```text
screenshots/
├── feature-branch.png
└── feature-push.png
```

---

# 🔀 Task 6 — Merge Conflict Resolution (Optional)

### Objective
Understand how Git handles incompatible changes made to the same file.

### Step 1: Create Experimental Branch

```bash
git switch main
git pull origin main
git switch -c experimental
```

### Step 2: Modify the Same Line

Updated the same line in `info.txt` with different content.

### Step 3: Commit Experimental Changes

```bash
git add info.txt
git commit -m "Experimental update"
```

### Step 4: Switch to Feature Branch

```bash
git switch feature-update
```

### Step 5: Merge Experimental Branch

```bash
git merge experimental
```

### Step 6: Resolve Conflict

When Git identifies incompatible changes:

- Open the conflicting file.
- Review both versions.
- Select or combine the required changes.
- Remove Git conflict markers.

### Step 7: Complete the Merge

```bash
git add info.txt
git commit -m "Resolve merge conflict"
```

### Verify the Result

```bash
git status
git log --oneline --graph --all
```

**Key Learning:**

A merge conflict occurs when Git cannot automatically combine changes. Manual resolution is required before completing the merge.

### 📸 Evidence

```text
screenshots/
├── merge-conflict.png
└── conflict-resolution.png
```

---

# ⭐ Bonus Task — SSH Authentication

### Objective
Configure SSH authentication to communicate securely with GitHub.

### Step 1: Generate SSH Key

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
```

### Step 2: Start SSH Agent

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### Step 3: Display Public Key

```bash
cat ~/.ssh/id_ed25519.pub
```

### Step 4: Add SSH Key to GitHub

Navigate to:

**GitHub → Settings → SSH and GPG keys → New SSH key**

Paste the public key and save it.

### Step 5: Test SSH Connection

```bash
ssh -T git@github.com
```

### Step 6: Update Remote URL

```bash
git remote set-url origin git@github.com:<username>/90DaysOfDevOps.git
```

### Step 7: Push Using SSH

```bash
git push origin feature-update
```

**Key Learning:**

SSH provides key-based authentication, allowing GitHub communication without repeatedly entering HTTPS credentials.

### 📸 Evidence

```text
screenshots/
├── ssh-key-generation.png
├── github-ssh-key.png
└── ssh-authentication.png
```

---

# 🧠 Critical Thinking — Importance of Branching Strategies

Branching strategies play an important role in collaborative software development.

### 1. Feature Isolation
Developers can implement new features without affecting the main branch.

### 2. Parallel Development
Multiple developers can work on different tasks simultaneously.

### 3. Conflict Management
Separate branches help organize changes and make integration conflicts easier to identify.

### 4. Code Reviews
Pull Requests allow developers to review and discuss changes before merging.

### 5. Production Stability
The main branch can remain stable while new features and bug fixes are developed independently.

---

# 📤 Pull Request Submission

### Objective
Contribute the completed challenge work to the original repository.

### Pull Request Details

| Field | Details |
|---|---|
| Original Repository | LondheShubham153/90DaysOfDevOps |
| Source Repository | Your GitHub fork |
| Source Branch | `feature-update` |
| Target Branch | `main` |
| PR Title | Week 4 Challenge - DevOps Batch 9: Git & GitHub |

### Pull Request Workflow

```text
Original Repository
        |
       Fork
        |
     Your Fork
        |
      Clone
        |
   Create Branch
        |
    Make Changes
        |
      Commit
        |
      Push
        |
   Pull Request
        |
   Code Review
        |
      Merge
```

**Pull Request Link:** [Add your PR URL here]

---

# 💡 Key Learnings & Takeaways

Through this challenge, I gained practical knowledge of:

- Git repository initialization and management.
- Forking and cloning open-source repositories.
- Staging and committing changes.
- Branch creation and switching.
- Understanding commit history.
- Remote repository operations.
- HTTPS and SSH authentication.
- Merge conflicts and resolution.
- Pull Request creation and collaboration.

The biggest takeaway was understanding that Git is not just about storing code; it is about managing changes and enabling effective collaboration between developers.

---

# 📸 Challenge Screenshots

Add your actual screenshots here to showcase the implementation.

| Task | Screenshot |
|---|---|
| Fork & Clone | `screenshots/fork.png` |
| Initial Commit | `screenshots/initial-commit.png` |
| Remote Configuration | `screenshots/remote-configuration.png` |
| Git Log | `screenshots/git-log.png` |
| Branch Creation | `screenshots/feature-branch.png` |
| Merge Conflict | `screenshots/merge-conflict.png` |
| SSH Authentication | `screenshots/ssh-authentication.png` |
| Pull Request | `screenshots/pull-request.png` |

---

# 🔗 Learning Resources

- [Official Git Documentation](https://git-scm.com/docs)
- [GitHub Documentation](https://docs.github.com/)
- [GitHub Forking Guide](https://docs.github.com/en/get-started/quickstart/fork-a-repo)
- [GitHub SSH Authentication](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [Git Branching Strategies](https://www.atlassian.com/git/tutorials/comparing-workflows)

---

<p align="center">
  <b>WEEK 04 — COMPLETED THROUGH PRACTICAL LEARNING 🚀</b><br/><br/>
  <i>Learn by doing. Break things. Fix them. Grow every day.</i><br/><br/>
  <b>#90DaysOfDevOps #Git #GitHub #DevOps #LearningInPublic</b>
</p>