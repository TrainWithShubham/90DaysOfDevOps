# GitHub CLI (gh) Commands – Day 26

gh auth login
gh auth status
gh auth logout

## Repository Management
gh repo create <name> --public --add-readme
gh repo clone <owner/repo>
gh repo view
gh repo view --web
gh repo view <repo-name> --web
gh repo list
gh repo list <username>
gh repo delete <name>

## Issues
- gh issue create --title "Title" --body "Description"
- gh issue list
- gh issue view <number>
- gh issue close <number>

## Pull Requests
gh pr create --title "Title" --body "Description"
gh pr list
gh pr view <number>
gh pr view <number> --web
gh pr checks <number>
gh pr merge <number>
gh pr checkout <number>
gh pr review <number> --comment -b "message"
gh pr review <number> --approve
gh pr review <number> --request-changes -b "message"

## GitHub Actions (Preview)
gh run list
gh run list --repo <owner/repo>
gh run view <run-id>
gh run view <run-id> --repo <owner/repo>
gh run view <run-id> --log
gh workflow list
gh workflow run <workflow-name>

## Useful Tricks
🔹 GitHub API
gh api user
gh api repos/<owner>/<repo>


🔹 Gist
gh gist create <file>
gh gist list


🔹 Releases
gh release create v1.0.0 --title "Title" --notes "Notes"
gh release list


🔹 Alias
gh alias set <shortcut> "<command>"



🔹 Search
gh search repos <keyword>
gh search repos <keyword> --limit 5
---

# Summary

GitHub CLI allows managing:
- Repositories
- Issues
- Pull Requests
- Releases
- Workflows
- API calls

All directly from the terminal without opening the browser.