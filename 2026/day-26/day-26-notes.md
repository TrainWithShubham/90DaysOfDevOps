# Day 26 – GitHub CLI: Manage GitHub from Your Terminal

---

# 1. Installation & Authentication

## Installation

gh installed via:

sudo apt install gh

Verified using:

gh --version

---

## Authentication

Command used:

gh auth login

Authentication Methods Supported:

- Browser-based OAuth (recommended)
- Personal Access Token (PAT)
- SSH (for Git operations)
- HTTPS (for Git operations)

Important Understanding:

SSH authenticates Git operations (push/pull).
GitHub CLI requires OAuth token because it interacts with GitHub APIs (issues, PRs, workflows).

Verified login using:

gh auth status

Token scopes example:

'admin:public_key', 'delete_repo', 'gist', 'read:org', 'repo'

---

# 2. Working with Repositories

## Create Repository

gh repo create day-26-gh-practice --public --clone --add-readme

Flags:

--clone → Automatically clones repo locally
--add-readme → Creates initial commit with README
--public → Makes repo public

---

## View Repository

gh repo view
gh repo view --json name,visibility,defaultBranchRef

JSON output is useful for automation and CI/CD scripting.

---

## List Repositories

gh repo list
gh repo list --json name,isFork,visibility

JSON output allows filtering and scripting.

---

## Delete Repository

Required additional scope:

gh auth refresh -h github.com -s delete_repo

Delete command:

gh repo delete owner/repo --yes

DevOps Insight:
GitHub API operations require specific OAuth scopes.

---

# 3. Issues Management

## Create Issue

gh issue create \
  --repo owner/repo \
  --title "Title" \
  --body "Body" \
  --label "bug"

Note:
If label does not exist, command fails.

---

## List Issues

gh issue list --repo owner/repo

---

## View Issue (JSON)

gh issue view 1 \
  --repo owner/repo \
  --json number,title,body,labels,state

---

## Close Issue

gh issue close 1 --repo owner/repo

---

## Automation Use Cases

- Create issue automatically on production failure
- Create issue when security scan fails
- Auto-create issue for nightly test failures
- Incident tracking integration

JSON output enables conditional automation.

---

# 4. Pull Request Lifecycle

## Create Branch & Push

git checkout -b feature-branch
git push origin feature-branch

---

## Create PR

gh pr create \
  --repo owner/repo \
  --title "Title" \
  --body "Body" \
  --base master \
  --head feature-branch

---

## List PRs

gh pr list --repo owner/repo

---

## View PR (JSON)

gh pr view 2 \
  --repo owner/repo \
  --json number,title,state,mergeable

---

## Merge PR

gh pr merge 2 --merge --delete-branch

Merge Methods:

--merge → Regular merge commit
--squash → Combine commits into single commit
--rebase → Linear history without merge commit

---

## When to Use Each Merge Strategy

Merge:
- Preserve full branch history

Squash:
- Clean main branch
- Combine multiple small commits

Rebase:
- Maintain linear history
- Avoid merge commits

---

# 5. GitHub Actions & Workflows

## List Workflow Runs

gh run list --repo owner/repo

---

## View Specific Run

gh run view <run-id> --repo owner/repo

---

## Automation Use Cases

- Check workflow status before deployment
- Detect failed pipeline automatically
- Fetch logs programmatically
- Trigger rollback if workflow fails
- CI/CD health monitoring

---

# Key DevOps Takeaways

- gh eliminates browser dependency
- OAuth scopes control API permissions
- JSON output enables automation
- Full PR lifecycle possible from terminal
- CI/CD workflows can be monitored via CLI
- Suitable for scripting and infrastructure automation

---

Day 26 Complete.
