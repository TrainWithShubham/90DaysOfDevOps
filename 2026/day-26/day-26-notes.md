# Day 26 – GitHub CLI (gh)

Today I learned how to use GitHub directly from the terminal using GitHub CLI (`gh`). This helps developers and DevOps engineers manage repositories, pull requests, issues, and workflows without opening the browser repeatedly.

---

# Task 1 – Install and Authenticate GitHub CLI

## Installed GitHub CLI

I installed GitHub CLI on Windows and verified installation using:

```bash
gh --version
```

Output showed installed version successfully.

---

## Authentication

Used command:

```bash
gh auth login
```

Selected:

- GitHub.com
- HTTPS
- Login with web browser

Authenticated GitHub account through browser.

Verified login using:

```bash
gh auth status
```

---

# Authentication Methods Supported by gh

GitHub CLI supports:

- Browser authentication
- Personal Access Token (PAT)
- SSH authentication
- GitHub Enterprise authentication

---

# Task 2 – Working with Repositories

## Create Repository from Terminal

Command used:

```bash
gh repo create gh-cli-demo --public --clone --add-readme
```

This:

- created repository
- added README
- cloned repository locally

---

## Clone Repository Using gh

```bash
gh repo clone owner/repository-name
```

Example:

```bash
gh repo clone asmasaiyed104/90DaysOfDevOps
```

---

## View Repository Details

```bash
gh repo view
```

---

## List All Repositories

```bash
gh repo list
```

---

## Open Repository in Browser

```bash
gh repo view --web
```

---

## Delete Repository

```bash
gh repo delete gh-cli-demo
```

This command permanently deletes repository, so it should be used carefully.

---

# Task 3 – Issues

## Create Issue

```bash
gh issue create
```

OR directly:

```bash
gh issue create --title "Test Issue" --body "Testing GitHub CLI issue creation" --label bug
```

---

## List Issues

```bash
gh issue list
```

---

## View Specific Issue

```bash
gh issue view 1
```

---

## Close Issue

```bash
gh issue close 1
```

---

# How gh issue Can Be Used in Automation

`gh issue` can be used in scripts to:

- automatically create bug reports
- create deployment incident tickets
- generate DevOps alerts
- automate monitoring workflows

---

# Task 4 – Pull Requests

## Create Branch

```bash
git checkout -b feature-gh-cli
```

---

## Make Changes and Commit

```bash
git add .
git commit -m "Added GitHub CLI practice"
```

---

## Push Branch

```bash
git push origin feature-gh-cli
```

---

## Create Pull Request from Terminal

```bash
gh pr create --fill
```

This automatically fills PR title and description from commit message.

---

## List Pull Requests

```bash
gh pr list
```

---

## View PR Details

```bash
gh pr view
```

---

## Merge Pull Request

```bash
gh pr merge
```

---

# Merge Methods Supported

GitHub CLI supports:

- merge
- squash
- rebase

Examples:

```bash
gh pr merge --merge
gh pr merge --squash
gh pr merge --rebase
```

---

# Reviewing Someone Else’s PR

Commands used:

```bash
gh pr checkout <pr-number>
```

This downloads PR locally for testing and review.

Review command:

```bash
gh pr review
```

---

# Task 5 – GitHub Actions & Workflows

## List Workflow Runs

```bash
gh run list
```

Example for public repository:

```bash
gh run list --repo cli/cli
```

---

## View Workflow Run Details

```bash
gh run view <run-id>
```

---

# How gh run and gh workflow Help in CI/CD

These commands help:

- monitor pipelines
- check deployment status
- rerun failed workflows
- automate CI/CD monitoring
- integrate GitHub Actions into shell scripts

---

# Task 6 – Useful gh Commands

## GitHub API

```bash
gh api user
```

---

## GitHub Gist

```bash
gh gist create notes.txt
```

---

## GitHub Release

```bash
gh release create v1.0
```

---

## Create Alias

```bash
gh alias set co "pr checkout"
```

Use alias:

```bash
gh co 5
```

---

## Search GitHub Repositories

```bash
gh search repos devops
```

---

# Important Commands Learned Today

```bash
gh auth login
gh auth status
gh repo create
gh repo clone
gh repo list
gh issue create
gh issue list
gh pr create
gh pr list
gh pr merge
gh run list
gh workflow list
```

---

# Difference Between Git and GitHub CLI

| Tool              | Purpose                     |
| ----------------- | --------------------------- |
| Git               | Version control system      |
| Git Bash          | Terminal environment        |
| GitHub CLI (`gh`) | Manage GitHub from terminal |

---

# Final Learning

Today I learned:

- how to install and configure GitHub CLI
- how to manage repositories from terminal
- how to create issues and pull requests without browser
- how DevOps engineers automate GitHub workflows
- how GitHub CLI helps with CI/CD and automation

GitHub CLI makes GitHub management faster and more efficient for DevOps workflows.
