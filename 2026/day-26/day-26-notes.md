# Day 26 - GitHub CLI (gh) & Automation

## Task 1: Authentication
**What authentication methods does `gh` support?**
The GitHub CLI supports authenticating via a web browser (OAuth device flow) or by manually supplying a GitHub Personal Access Token (PAT).

## Task 3: Automating Issues
**How could you use `gh issue` in a script or automation?**
You can integrate `gh issue create` into server monitoring scripts. For example, if a nightly backup script fails, the bash script can automatically trigger a command to open an issue on GitHub and tag the infrastructure team, requiring zero human intervention.

## Task 4: Pull Requests
**What merge methods does `gh pr merge` support?**
It supports standard merge commits (`--merge`), squash merging (`--squash`), and rebase merging (`--rebase`).
**How would you review someone else's PR using `gh`?**
You can use `gh pr checkout <pr-number>` to instantly download their proposed code to your local machine, test it in your own terminal, and then use `gh pr review` to approve or reject it.

## Task 5: CI/CD Pipeline Preview
**How could `gh run` and `gh workflow` be useful in a CI/CD pipeline?**
Instead of logging into the GitHub website to see if a deployment pipeline failed, you can use `gh run list` in your terminal to check the status. You can even write scripts that trigger deployments automatically using `gh workflow run`.