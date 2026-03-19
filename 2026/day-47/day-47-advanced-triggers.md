Task 1: Pull Request Event Types
Create .github/workflows/pr-lifecycle.yml that triggers on pull_request with specific activity types:
Trigger on: opened, synchronize, reopened, closed
Add steps that:
- Print which event type fired: ${{ github.event.action }}
- Print the PR title: ${{ github.event.pull_request.title }}
- Print the PR author: ${{ github.event.pull_request.user.login }}
- Print the source branch and target branch
- Add a conditional step that only runs when the PR is merged (closed + merged = true)
- Test it: create a PR, push an update to it, then merge it. Watch the workflow fire each time with a different event type.
<img width="922" height="861" alt="image" src="https://github.com/user-attachments/assets/4aa42a26-a9f8-46f4-8d33-b24be24677b1" />


Task 2: PR Validation Workflow
Create .github/workflows/pr-checks.yml — a real-world PR gate:
- Trigger on pull_request to main
- Add a job file-size-check that:
- Checks out the code
- Fails if any file in the PR is larger than 1 MB
- Add a job branch-name-check that:
- Reads the branch name from ${{ github.head_ref }}
- Fails if it doesn't follow the pattern feature/*, fix/*, or docs/*
- Add a job pr-body-check that:
- Reads the PR body: ${{ github.event.pull_request.body }}
- Warns (but doesn't fail) if the PR description is empty
- Verify: Open a PR from a badly named branch — does the check fail?
  <img width="1042" height="617" alt="image" src="https://github.com/user-attachments/assets/7ab6d404-28eb-436c-b775-bef9b87fe8d2" />


Task 3: Scheduled Workflows (Cron Deep Dive)
Create .github/workflows/scheduled-tasks.yml:
- Add a schedule trigger with cron: '30 2 * * 1' (every Monday at 2:30 AM UTC)
- Add another cron entry: '0 */6 * * *' (every 6 hours)
- In the job, print which schedule triggered using ${{ github.event.schedule }}
- Add a step that acts as a health check — curl a URL and check the response code
 <img width="915" height="605" alt="image" src="https://github.com/user-attachments/assets/bc20622d-96a4-4c9d-b7ad-0162eec46b0a" />
 
Write in your notes:
- The cron expression for: every weekday at 9 AM IST
  30 3 * * 1-5
- The cron expression for: first day of every month at midnight
  0 0 1 * *
- Why GitHub says scheduled workflows may be delayed or skipped on inactive repos
  Scheduled workflows may be delayed or skipped on inactive repositories as a resource management policy to prioritize active projects and prevent unnecessary compute usage


Task 4: Path & Branch Filters
Create .github/workflows/smart-triggers.yml:
Trigger on push but only when files in src/ or app/ change:
on:
  push:
    paths:
      - 'src/**'
      - 'app/**'
Add paths-ignore in a second workflow that skips runs when only docs change:
paths-ignore:
  - '*.md'
  - 'docs/**'
Add branch filters to only trigger on main and release/* branches
Test it: push a change to a .md file — does the workflow skip?
<img width="925" height="466" alt="image" src="https://github.com/user-attachments/assets/d732ce56-5c79-41ca-afab-b33cf2e03bbd" />
<img width="860" height="455" alt="image" src="https://github.com/user-attachments/assets/c94681d3-a0a0-450f-a97e-cf5caf2897eb" />

- Write in your notes: When would you use paths vs paths-ignore?
  - Use paths when you want a workflow to run only if specific files or directories are modified. This is ideal for scoped, efficient workflows in monorepos.
  - Use paths-ignore when you want a workflow to run on most changes, except when specific files (like documentation or meta-files) are updated.


Task 5: workflow_run — Chain Workflows Together
Create two workflows:
- .github/workflows/tests.yml — runs tests on every push
  <img width="791" height="697" alt="image" src="https://github.com/user-attachments/assets/2db611f7-1628-4088-b91f-d80e57ac335f" />

.github/workflows/deploy-after-tests.yml — triggers only after tests.yml completes successfully:
on:
  workflow_run:
    workflows: ["Run Tests"]
    types: [completed]
In the deploy workflow, add a conditional:
Only proceed if the triggering workflow succeeded (${{ github.event.workflow_run.conclusion == 'success' }})
Print a warning and exit if it failed
Verify: Push a commit — does the test workflow run first, then trigger the deploy workflow?
<img width="893" height="615" alt="image" src="https://github.com/user-attachments/assets/b75785c1-8f33-4c16-b210-494edc396a34" />

