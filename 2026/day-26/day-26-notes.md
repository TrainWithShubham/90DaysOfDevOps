# Day 26: GitHub CLI Observations & Answers

## Task 1: Authentication
**What authentication methods does `gh` support?**
1. **Web Browser:** Authenticate via a one-time code and a GitHub login window.
2. **Personal Access Token (PAT):** For environments where a browser isn't accessible.
3. **SSH Keys:** `gh` can generate, manage, and upload SSH keys to your account.

## Task 3: Issues Automation
**How could you use `gh issue` in a script or automation?**
- **CI/CD Failures:** Automatically create an issue if a GitHub Action or Jenkins build fails, attaching the error logs to the body.
- **Dependency Updates:** Script a weekly check for outdated packages and open an issue for the team to review.
- **Bulk Management:** Use a bash `for` loop to add labels or close multiple stale issues at once.

## Task 4: Pull Requests
**What merge methods does `gh pr merge` support?**
- **Create a merge commit:** Standard merge where all history is preserved.
- **Rebase and merge:** Commits from the PR are rebased onto the main branch.
- **Squash and merge:** All commits from the PR are combined into a single commit on the main branch.

**How would you review someone else's PR using `gh`?**
- Use `gh pr checkout <number>` to pull their code locally to test it.
- Use `gh pr diff` to see exactly what lines of code changed.
- Use `gh pr review --approve` or `--comment` to give feedback.


