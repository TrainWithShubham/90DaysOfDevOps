# Day 26 – GitHub CLI: Manage GitHub from Your Terminal

## Task 1: Install and Authenticate
### 1. Install the GitHub CLI on your machine
- `winget install --id GitHub.cli`
--------
### 2. Authenticate with your GitHub account
- `gh auth login`
------
### 3. Verify you're logged in and check which account is active
- `gh auth status` or use to see active user `gh api user`
-----------
### 4. What authentication methods does `gh` support?
- Browser-based OAuth login
- Personal Access Token (PAT)
- SSH key authentication
- GitHub Enterprise authentication
---

## Task 2: Working with Repositories
### 1. Create a **new GitHub repo** directly from the terminal — make it public with a README
- `gh repo create gh-cli-test --public --description "Test repo from CLI" --add-readme --clone`
---------
### 2. Clone a repo using `gh` instead of `git clone`
- `gh repo clone owner/repo`
---------
### 3. View details of one of your repos from the terminal
- Go to inside repo and then use it 
- `gh repo view`
---------
### 4. List all your repositories
- `gh repo list`
- `gh repo list --limit 20`
---------
### 5. Open a repo in your browser directly from the terminal
- `gh repo view --web`
---------
### 6. Delete the test repo you created (be careful!)
- `gh repo delete gh-cli-test --confirm` this will delete permanently.

---

## Task 3: Issues
### 1. Create an issue on one of your repos from the terminal — give it a title, body, and a label
- `gh issue create --title "Fix login bug" --body "Users cannot log in when password contains special characters." --label "bug"`
-----
### 2. List all open issues on that repo
- `gh issue list`
----------
### 3. View a specific issue by its number
- `gh issue view 1` or web `gh issue view 1 --web`
-----------
### 4. Close an issue from the terminal
- `gh issue close 1`
---------
### 5. Answer in your notes: How could you use `gh issue` in a script or automation?
- Automatically create issues from CI failures
- Generate bug tickets from logs
- Bulk close stale issues
- Script project setup
- Export issues as JSON using --json for dashboards
- `gh issue list --json title,number`

---

## Task 4: Pull Requests
1. Create a branch, make a change, push it, and create a **pull request** entirely from the terminal
- `git switch -c feature-cli-test`
- `echo "CLI change" >> README.md`
- `git add .`
- `git commit -m "Add CLI change"`
- `git push -u origin feature-cli-test`
---------
### 2. List all open PRs on a repo
- `gh pr create --fill`
or do manually
- `gh pr create --title "Add CLI change" --body "Test PR created from terminal"`
--------
### 3. View the details of your PR — check its status, reviewers, and checks
- `gh pr list`
---------
### 4. Merge your PR from the terminal
- `gh pr view 1` or `gh pr view 1 --json statusCheckRollup,reviewRequests`
-------
### 5. Answer in your notes:
### 1. What merge methods does `gh pr merge` support?
    - `gh pr merge 1 --merge` or `gh pr merge 1 --squash` or `gh pr merge 1 --rebase`
    - --merge (merge commit)
    - --squash (squash into single commit)
    - --rebase (rebase merge)
### 2. How would you review someone else's PR using `gh`?
   - `gh pr view <number>`
   - `gh pr checkout <number>`
   - Add review `gh pr review <number> --approve`
    - `gh pr review <number> --comment`
    - `gh pr review <number> --request-changes`

---

## Task 5: GitHub Actions & Workflows (Preview)
### 1. List the workflow runs on any public repo that uses GitHub Actions
- `gh run list` 
----------
### 2. View the status of a specific workflow run
- `gh run view <run-id>` or watch logs `gh run watch`
----------
### 3. Answer in your notes: How could `gh run` and `gh workflow` be useful in a CI/CD pipeline?
- Trigger workflows from terminal: `gh workflow run build.yml`
- Monitor CI status without browser
- Auto-cancel failed runs
- Integrate into deployment scripts
- Gate production deployment on CI success
Useful in:
- Automated deployment pipelines
- Infrastructure scripting
- DevOps workflows

(Don't worry if you haven't learned GitHub Actions yet — this is a preview for upcoming days)

---

## Task 6: Useful `gh` Tricks
Explore and try these — add the ones you find useful to your `git-commands.md`:
### 1. `gh api` — make raw GitHub API calls from the terminal
Useful for: `gh api repos/:owner/:repo`
- Advanced automation
- Custom scripts
- Accessing unsupported features
---------
### 2. `gh gist` — create and manage GitHub Gists
- `gh gist create file.txt` it will create
- `gh gist list` it will list
--------
### 3. `gh release` — create and manage releases
- `gh release create v1.0.0 --notes "First release"` it will create release.
- `gh release upload v1.0.0 file.zip` it will upload asset or files.
---------
### 4. `gh alias` — create shortcuts for commands you use often
- `gh alias set co "pr checkout"` it will create shortcut.
- `gh co 15` use like this
-------------
### 5. `gh search repos` — search GitHub repos from the terminal
- `gh search repos react --limit 5` it will search
- `gh search repos --stars ">50000"` it will search by stars
- 

---
## Takeaways

- gh turns GitHub into a programmable interface.

- It supports full PR lifecycle management.

- It integrates with CI/CD.

- It enables scripting and automation.

- It reduces browser dependency.

---------
