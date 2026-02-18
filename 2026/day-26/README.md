# Day 26 – GitHub CLI: Manage GitHub from Your Terminal

## Task

Every time you switch to the browser to create a PR, check an issue, or manage a repo — you lose context. The **GitHub CLI (`gh`)** lets you do all of that without leaving your terminal. For DevOps engineers, this is essential — especially when you start automating workflows, scripting PR reviews, and managing repos at scale.

---

## Expected Output
- A markdown file: `day-26-notes.md` with your observations and answers
- Add `gh` commands to your `git-commands.md`

---

## Challenge Tasks

### Task 1: Install and Authenticate
1. Install the GitHub CLI on your machine
2. Authenticate with your GitHub account
3. Verify you're logged in and check which account is active
4. Answer in your notes: What authentication methods does `gh` support?

---

### Task 2: Working with Repositories
1. Create a **new GitHub repo** directly from the terminal — make it public with a README
2. Clone a repo using `gh` instead of `git clone`
3. View details of one of your repos from the terminal
4. List all your repositories
5. Open a repo in your browser directly from the terminal
6. Delete the test repo you created (be careful!)

---

### Task 3: Issues
1. Create an issue on one of your repos from the terminal — give it a title, body, and a label
2. List all open issues on that repo
3. View a specific issue by its number
4. Close an issue from the terminal
5. Answer in your notes: How could you use `gh issue` in a script or automation?

---

### Task 4: Pull Requests
1. Create a branch, make a change, push it, and create a **pull request** entirely from the terminal
2. List all open PRs on a repo
3. View the details of your PR — check its status, reviewers, and checks
4. Merge your PR from the terminal
5. Answer in your notes:
   - What merge methods does `gh pr merge` support?
   - How would you review someone else's PR using `gh`?

---

### Task 5: GitHub Actions & Workflows (Preview)
1. List the workflow runs on any public repo that uses GitHub Actions
2. View the status of a specific workflow run
3. Answer in your notes: How could `gh run` and `gh workflow` be useful in a CI/CD pipeline?

(Don't worry if you haven't learned GitHub Actions yet — this is a preview for upcoming days)

---

### Task 6: Useful `gh` Tricks
Explore and try these — add the ones you find useful to your `git-commands.md`:
1. `gh api` — make raw GitHub API calls from the terminal
2. `gh gist` — create and manage GitHub Gists
3. `gh release` — create and manage releases
4. `gh alias` — create shortcuts for commands you use often
5. `gh search repos` — search GitHub repos from the terminal

---

## Hints
- `gh help` and `gh <command> --help` are your best friends
- Most `gh` commands work with `--repo owner/repo` to target a specific repo
- Use `--json` flag with most commands to get machine-readable output (useful for scripting)
- `gh pr create --fill` auto-fills the PR title and body from your commits

---

## Submission
1. Add your `day-26-notes.md` to `2026/day-26/`
2. Update `git-commands.md` with `gh` commands — this completes your Git & GitHub reference from Days 22–26
3. Push to your fork

---

## Learn in Public

Share your favorite `gh` commands or a screenshot of creating a PR from the terminal on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
