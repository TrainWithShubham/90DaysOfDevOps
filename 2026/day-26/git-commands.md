# Master GitHub CLI (gh) Reference Cheat Sheet (Day 26)

## 1. Authentication & Setup
* `gh auth login`: Authenticate with GitHub account via browser or token.
* `gh auth status`: Verify active logged-in account and token permissions.
* `gh config set editor <editor>`: Configure default text editor for the CLI.

## 2. Repository Management (`gh repo`)
* `gh repo create <name> --public --readme`: Create a new remote repo with a README.
* `gh repo clone <owner/repo>`: Clone a repository quickly.
* `gh repo view --web`: Open current repository in the browser.
* `gh repo list`: List your repositories.
* `gh repo delete <name>`: Delete a repository.
* `gh repo fork <owner/repo>`: Fork any public repository.

## 3. Issues Management (`gh issue`)
* `gh issue create --title "Title" --body "Desc" --label "bug"`: Create an issue.
* `gh issue list`: List open issues.
* `gh issue view <number>`: View specific issue details and comments.
* `gh issue close <number>`: Close an issue.
* `gh issue reopen <number>`: Reopen a closed issue.

## 4. Pull Requests (`gh pr`)
* `gh pr create --fill`: Create a PR automatically using commit messages.
* `gh pr list`: List open pull requests.
* `gh pr view <number>`: Check PR status, checks, and reviewers.
* `gh pr checkout <number>`: Checkout a PR branch locally for testing.
* `gh pr review <number> --approve`: Approve a pull request.
* `gh pr merge <number> --squash`: Merge a PR using squash method.

## 5. GitHub Actions & Workflows (`gh run` & `gh workflow`)
* `gh run list`: List recent workflow runs.
* `gh run view <run-id>`: View details of a specific workflow run.
* `gh run view <run-id> --log-failed`: View logs specifically for failed runs.
* `gh workflow list`: List all available workflows in the repo.
* `gh workflow run <file-name>`: Trigger a workflow manually.

## 6. Advanced CLI Utilities (`gh api`, `gh gist`, `gh release`, `gh alias`)
* `gh api <endpoint>`: Make raw GitHub REST/GraphQL API requests.
* `gh gist create <file>`: Create a GitHub Gist from a file.
* `gh release create <tag> --notes "Release notes"`: Create a GitHub release.
* `gh alias set <alias> '<command>'`: Create custom command shortcuts.
* `gh search repos <query>`: Search public GitHub repos from the terminal.
