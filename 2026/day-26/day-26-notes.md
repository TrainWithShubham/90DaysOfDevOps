# What authentication methods does `gh` support?

GitHub CLI (`gh`) supports the following authentication methods:

---

## 1 Web Browser (OAuth Device Flow)

- Login using a web browser
- A one-time code is generated in the terminal
- User enters the code in the browser and authorizes GitHub CLI
- Recommended and easiest method for beginners

---

## 2 Personal Access Token (PAT)

- User generates a Personal Access Token from GitHub
- Token is pasted into the terminal for authentication
- Commonly used in automation, CI/CD pipelines, and scripts

Example:

```bash
gh auth login --with-token
```
## 3 SSH Authentication

- Uses SSH keys to authenticate Git operations

- No password required after setup

- Mostly used by developers and DevOps engineers

---

# How could you use `gh issue` in a script or automation?

The `gh issue` command can be used in scripts and automation to:

- Automatically create issues when a build fails in CI/CD
- Generate issues for detected bugs from automated testing
- Assign issues to team members programmatically
- Close issues automatically when a PR is merged
- Track system alerts and create GitHub issues from monitoring tools

In DevOps workflows, `gh issue` helps integrate GitHub issue management into automated pipelines and scripts.

---

# What merge methods does `gh pr merge` support?

The `gh pr merge` command supports three merge methods:

1. Merge Commit
   - Creates a merge commit
   - Preserves full branch history

2. Squash and Merge
   - Combines all commits into one single commit
   - Keeps history clean

3. Rebase and Merge
   - Reapplies commits on top of the base branch
   - Maintains linear history

---

# How would you review someone else's PR using `gh`?

You can review a PR using the following commands:

- View PR details:
  gh pr view <number>

- Checkout the PR locally:
  gh pr checkout <number>

- Check CI status:
  gh pr checks <number>

- Add a review comment:
  gh pr review <number> --comment -b "Looks good"

- Approve a PR:
  gh pr review <number> --approve

- Request changes:
  gh pr review <number> --request-changes -b "Please fix the issue"

  ---

# How could `gh run` and `gh workflow` be useful in a CI/CD pipeline?

The `gh run` and `gh workflow` commands are useful in CI/CD pipelines because:

## 1. Monitoring Pipeline Status
- Developers can check if builds are passing or failing directly from the terminal.
- Example: `gh run list`

## 2. Debugging Failures
- View logs of failed workflow runs without opening the browser.
- Example: `gh run view <run-id> --log`

## 3. Triggering Workflows
- Workflows can be triggered manually using:
  `gh workflow run <workflow-name>`

## 4. Automation and Scripting
- CI status can be checked in scripts.
- Automatic notifications or rollback actions can be triggered based on workflow results.

## 5. DevOps Efficiency
- Reduces context switching between terminal and browser.
- Makes CI/CD monitoring faster and scriptable.


---


# Useful GitHub CLI (`gh`) Tricks

## 1. gh api
- Make raw GitHub API calls
- Useful for automation and scripting
- Example:
  gh api user

## 2. gh gist
- Create and manage GitHub Gists
- Example:
  gh gist create file.txt

## 3. gh release
- Create and manage releases
- Example:
  gh release create v1.0.0 --title "Release" --notes "Notes"

## 4. gh alias
- Create shortcuts for frequently used commands
- Example:
  gh alias set prl "pr list"

## 5. gh search repos
- Search GitHub repositories from terminal
- Example:
  gh search repos devops --limit 5