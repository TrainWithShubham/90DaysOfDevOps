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

### Managing Pull Requests using GitHub CLI

### 1. Create a Branch and Make Changes
- create a new branch ```git checkout -b feature-upt```
- Make changes to a file and commit them:
```
git add .
git commit -m "Update documentation"
```
- Push the branch to GitHub:
``` git push origin feature-upt```

### 2. Create a Pull Request from the Terminal
```
gh pr create --title "Update documentation" \
--body "Improved documentation and added new examples."
```
` This will create a pull request from your branch to the main branch.
### 3. List All Open Pull Requests
```gh pr list```
### 4. View Pull Request Details
```gh pr view 15```
### 5. Merge a Pull Request from the Terminal
```gh pr merge 15```
- Merge Methods Supported by ```gh pr merge```
GitHub CLI supports three merge methods:

Method	Command	Description
Merge Commit	gh pr merge --merge	Keeps all commits and creates a merge commit
Squash Merge	gh pr merge --squash	Combines all commits into one commit
Rebase Merge	gh pr merge --rebase	Reapplies commits on top of the base branch

## How to Review Someone Else's Pull Request using gh
- View the PR:```gh pr view <PR-number>```
- Checkout the PR locally: ```gh pr checkout <PR number>```
- Review the changes: ```git diff```
- Approve the PR: ```gh pr review <PR-number> --approve```
- Request changes: ```gh pr review <PR-number> --request-changes```
- Add a comment: ```gh pr comment <PR-number> --body "Looks good!"```

## GitHub Actions & Workflows (Preview)

GitHub CLI allows you to interact with GitHub Actions workflows directly from the terminal.

---

### 1. List Workflow Runs

You can list workflow runs for the current repository:

```bash
gh run list
```
### Example Output
```
STATUS   TITLE                     WORKFLOW      BRANCH   EVENT   ID
✓        Update documentation      CI Pipeline   main     push    123456
✓        Fix API tests             CI Pipeline   main     push    123455
```
### 2. View the Status of a Specific Workflow Run
``` gh run view <run-id>``` Eg: ```gh run view 123456```
You can also open it in the browser:
```gh run view 123456 --web```
- List Available Workflows
```gh workflow list```
Example:
```
NAME              STATE
CI Pipeline       active
Deploy Workflow   active
```
### How could gh run and gh workflow be useful in a CI/CD pipeline?
- The GitHub CLI commands help developers and DevOps engineers manage CI/CD pipelines directly from the terminal.
Eg:
- Monitor CI/CD pipeline status ```gh run list```
This allows engineers to quickly check if builds or deployments are successful.
- Debug workflow failures ```gh run view <run-id> - This helps inspect logs and identify why a pipeline failed.
- Trigger or manage workflows
Using gh workflow commands, teams can manage automation workflows without leaving the terminal.

## Useful GitHub CLI (`gh`) Tricks

The GitHub CLI provides powerful commands that allow developers to interact with GitHub directly from the terminal.

---

### 1. `gh api` – Call the GitHub API

You can make raw GitHub API requests directly from the terminal.

Example: Get information about the authenticated user.

```bash
gh api user
```
Use Case
- Automate GitHub tasks
- Retrieve repository data
- Integrate GitHub with scripts

### gh gist – Manage GitHub Gists
- A Gist is a feature on GitHub that lets you store and share small pieces of code, text, or notes online.
- gh gist – Manage GitHub Gists ```gh gist create file.txt```
- create a public gist ```gh gist create file.txt --public
-list your gist ```gh gist list```

### gh release – Manage Releases
- Create and manage GitHub releases. ```gh release create v1.0.0```
- create a release with notes ```gh release create v1.0.0 --notes "Initial release"``` 
- ```gh release list

### 4. gh alias – Create Command Shortcuts
- 4. gh alias – Create Command Shortcuts ```gh alias set prs "pr list"```
now you can run ```gh prs``` to list pull request
Use Case
-Save time with frequently used commands
-Simplify long CLI commands

### 5. gh search repos – Search Repositories
- 5. gh search repos – Search Repositories ```gh search repos devops```
- limit results: ```gh search repos devops --limit 10```
- Search by language:  ```gh search repos "kubernetes language:go"```

Note: ```gh pr create --fill``` auto-fills the PR title and body from your commits