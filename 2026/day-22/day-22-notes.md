## Day 22 – Notes

### 1. What is Git?

Git is a distributed version control system that tracks changes in files over time.  
It helps manage project history and allows multiple people to work on the same codebase.

---

### 2. Why is Git Important in DevOps?

Git is the foundation of DevOps because:

- CI/CD pipelines start from Git
- Code reviews are done through Git
- Infrastructure as Code (like Ansible, Terraform) is stored in Git
- Rollbacks are possible because Git stores complete history
- Collaboration happens using branches and pull requests

Without Git, DevOps workflows cannot function.

---

### 3. Git vs GitHub

- Git is a tool installed on a local machine.
- GitHub is a hosting platform for Git repositories.
- You can use Git without GitHub.
- GitHub uses Git, but Git is not equal to GitHub.

---

### 4. Difference between git add and git commit

- `git add` moves changes from the working directory to the staging area.
- `git commit` moves changes from the staging area to the repository history.

---

### 5. What does the staging area do?

The staging area stores changes before committing them to the repository.  
It allows selective commits so you can control what gets included in a commit.

---

### 6. What does git log show?

`git log` shows the commit history of the repository including:
- Commit hash
- Author
- Date
- Commit message

---

### 7. What is the .git/ folder?

The `.git/` folder contains all repository data including:
- Commit history
- Branch information
- Objects database
- Configuration

If the `.git/` folder is deleted, the project remains but it is no longer a Git repository. All history is lost.

---

### 8. Working Directory vs Staging Area vs Repository

- **Working Directory** → Where you edit files.
- **Staging Area** → Where changes are prepared before committing.
- **Repository** → Where committed changes are permanently stored in history.


