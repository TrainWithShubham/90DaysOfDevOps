# Day 26: GitHub CLI (gh) – Manage GitHub from Your Terminal

## Task 1: Install and Authenticate
* **What authentication methods does `gh` support?**
  *Answer:* `gh` primarily supports authentication via web browser login (`gh auth login`), personal access tokens (PATs) passed via environment variables or terminal prompts, and SSH keys. It safely stores credentials in the system's secure credential store.

## Task 2: Working with Repositories
* **Observations & Hands-On:** 
  * Created public repos instantly with README using `gh repo create <name> --public --readme`.
  * Cloned repos directly with `gh repo clone` without navigating to the browser.
  * Inspected repo details, listed all repositories with `gh repo list`, opened them in the browser via `gh repo view --web`, and safely cleaned up test repos using `gh repo delete`.

## Task 3: Issues
* **Created issue:** Tested creating issues with a title, body, and labels directly from the CLI (`gh issue create`).
* **Managed issues:** Listed open issues (`gh issue list`), viewed specific issues by number (`gh issue view`), and closed them (`gh issue close`).
* **How could you use `gh issue` in a script or automation?**
  *Answer:* By passing the `--json` flag (e.g., `gh issue list --json number,title`), I can pipe the output into tools like `jq` to build automation scripts. For example, automatically labeling incoming bugs, assigning issues to specific engineers based on keywords, or generating a tracking issue if a cron job or CI/CD pipeline crashes.

## Task 4: Pull Requests
* **Workflow tested:** Created a new branch, made local modifications, pushed to remote, and raised a pull request entirely from the terminal (`gh pr create --fill`).
* **PR Management:** Listed open PRs (`gh pr list`), inspected reviews and checks (`gh pr view`), checked out a PR locally for testing (`gh pr checkout`), and merged it using squash method (`gh pr merge --squash`).
* **What merge methods does `gh pr merge` support?**
  *Answer:* It supports standard merge (`--merge`), squash and merge (`--squash`), and rebase and merge (`--rebase`).
* **How would you review someone else's PR using `gh`?**
  *Answer:* I can check out their branch locally with `gh pr checkout <PR-number>` to test the code on my machine, inspect the checks status using `gh pr checks`, and submit my review via `gh pr review <PR-number> --approve` or `--request-changes`.

## Task 5: GitHub Actions & Workflows (Preview)
* **Explored:** Listed workflow runs (`gh run list`), inspected specific run details and failed logs (`gh run view --log-failed`), and manually triggered workflows (`gh workflow run`).
* **How could `gh run` and `gh workflow` be useful in a CI/CD pipeline?**
  *Answer:* They allow developers and SREs to monitor pipeline health, debug failing tests by pulling logs directly to the terminal (`--log-failed`), and trigger manual or parameter-driven deployments without ever needing to open the GitHub web dashboard.

## Task 6: Useful `gh` Tricks
* **Tricks integrated into workflow:**
  * `gh api`: To make raw REST/GraphQL requests against GitHub's API.
  * `gh gist`: To instantly share configuration snippets or logs.
  * `gh release`: To automate tagging and publishing release artifacts.
  * `gh alias`: To map frequently used long commands to short custom shortcuts.
  * `gh search repos`: To query repositories across GitHub directly from the command line.
## Live Terminal Test Check
