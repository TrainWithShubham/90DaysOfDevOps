# Day 26 – GitHub CLI: Manage GitHub from Your Terminal
Every time you switch to the browser to create a PR, check an issue, or manage a repo — you lose context. The GitHub CLI (gh) lets you do all of that without leaving your terminal. For DevOps engineers, this is essential — especially when you start automating workflows, scripting PR reviews, and managing repos at scale.

## Task 1: Install and Authenticate
### Step 1. Install GitHub CLI
- Install the GitHub CLI (`gh`) on your system.
```winget install --id GitHub.cli```
### Step 2 — Restart the terminal
After installation: Close PowerShell / VS Code & Open a new terminal
- run ```gh --version```
- Expected o/p:
```
gh version 2.x.x
https://github.com/cli/cli/releases
```
### Step 3 — Login to GitHub
``` gh auth login```
- Choose:
```
GitHub.com
HTTPS
Login with browser
```
- It will open your browser for authentication.
### Step 4 — Verify login
``` gh auth status```
- ✓ Logged in to github.com as ap****

## Authentication Methods Supported by gh
- Authentication Methods Supported by gh
### 1. Web Browser Authentication
- Opens a browser window
- You log in and authorize the CLI
- Most common and recommended method

### 2. Personal Access Token (PAT)
- You can authenticate using a GitHub Personal Access Token.
```gh auth login --with-token```
Useful for: automation, CI/CD pipelines

### 3. SSH Authentication
- Uses your existing SSH key configured with GitHub.
Best for: secure Git operations, developers already using SSH

### 4. GitHub Enterprise Authentication
- Allows authentication with private GitHub Enterprise servers.
## Task2 : Working with Repositories using GitHub CLI
### 1. Create a New Repository from the Terminal
Create a public repository with a README:

```bash
```gh repo create test-repo --public --clone --add-readme```
- Explanation:
test-repo → repository name
--public → makes the repository public
--clone → automatically clones it locally
--add-readme → adds a README file
```
### 2. Clone a Repository using GitHub CLI
- ```gh repo clone username/repo-name```
### 3. View Repository Details
```gh repo view test-repo```
### 4. List All Your Repositories
```gh repo list```
-you can limit the result:
```gh repo list --limit 20```
### 5. Open Repository in Browser
```gh repo view --web```
### 6. Delete the repository
```gh repo delete test-repo```

## Managing GitHub Issues using GitHub CLI

### 1. Create an Issue from the Terminal

Create an issue with a title, body, and label:
```gh issue create --title "Bug: Login page error" \```
```--body "Users are unable to log in due to an API failure." \```
``` --label bug```

- Explanation:
--title → Issue title
--body → Description of the issue
--label → Assign a label to categorize the issue

### 3. View a Specific Issue
``` gh issue view 12```
This shows:
Issue title
Description
Labels
Status
Comments

### 4. Close an Issue from the Terminal
```hg issue close 12``` Here 12 is a issue number

### How could you use gh issue in a script or automation?
- The gh issue command can be used in automation scripts to manage issues automatically.
***Automatically create issues for CI/CD failures
``` gh issue create --title "Build Failed" --body "The CI pipeline failed. Please check logs."```
