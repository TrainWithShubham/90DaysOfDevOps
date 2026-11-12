
## Task 2: Branching Commands

**Difference between `git switch` and `git checkout`:**

`git checkout` is an older, overloaded command used for both switching branches AND restoring files. Because it did too many things, it caused confusion. Git introduced `git switch` purely and specifically for switching branches, making it a much safer and clearer command.

## Task 3: Push to GitHub

**Difference between `origin` and `upstream`:**

- **`origin`**: This is the default alias Git gives to your own remote repository (e.g., your personal repo or your fork on GitHub). It's where your local changes are pushed by default.
- **`upstream`**: This refers to the original, central repository that you forked from. Developers track `upstream` to fetch updates made by the core team and keep their own `origin` fork in sync.

## Task 4: Pull from GitHub

**Difference between `git fetch` and `git pull`:**

- **`git fetch`**: It only downloads the latest metadata and commits from the remote repository to your local machine, but it **does not** automatically merge them into your current working files. It's a safe way to review what has changed remotely before applying it.
- **`git pull`**: It performs two actions in a single command: it runs `git fetch` to download the changes, and then immediately runs `git merge` to integrate those changes directly into your active working directory.

## Task 5: Clone vs Fork

**1. What is the difference between clone and fork?**

- **Clone**: A Git command that downloads an exact copy of a repository to your local machine. It connects your local environment to the remote repository.
- **Fork**: A GitHub-specific feature (not a Git command) that creates a personal copy of someone else's repository under your own GitHub account. You fork when you don't have write access to the original repo but want to propose changes.

**2. When would you clone vs fork?**

- **Clone**: When you have read/write access to a repository (like your own project or your team's internal repo) and want to work on it locally.
- **Fork**: When you want to contribute to a public open-source project where you do NOT have direct write access.

**3. After forking, how do you keep your fork in sync with the original repo?**

You add the original repository as a new remote called `upstream` (`git remote add upstream <Original-Repo-URL>`). Then, you regularly run `git fetch upstream` and `git merge upstream/main` to sync their latest changes into your local branch, which you can then push to your own `origin` fork.
