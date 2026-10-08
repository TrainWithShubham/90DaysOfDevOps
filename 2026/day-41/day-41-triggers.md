# Day 41 – Triggers & Matrix Builds

## What I learned today

Today I learned different ways to start a GitHub Actions workflow, and how to run one job many times at once using a matrix.

---

## Task 1: Pull Request trigger

I made a file called pr-check.yml. It runs only when someone opens or updates a Pull Request into my branch. It is not run on a normal push.

What happened: I opened a Pull Request, and this workflow ran by itself. It showed up as a check on the PR page.

## Task 2: Schedule trigger

I added a schedule trigger to a workflow. It runs every day at midnight UTC, without me clicking anything.

Question: What is the cron code for "every Monday at 9 AM"?

My answer: 0 9 \* \* 1

## Task 3: Manual trigger

I made a file called manual.yml. It does not run by itself. I go to the Actions tab and click "Run workflow" to start it. It also asks me to type an environment name before running.

What happened: I clicked "Run workflow," typed an environment name, and the logs printed exactly what I typed.

## Task 4: Matrix Build

I made a file called matrix.yml. Instead of writing many jobs by hand, I used a matrix. GitHub made one job automatically for every Python version I listed: 3.10, 3.11, and 3.12.

What happened: 3 jobs ran at the same time, one for each Python version.

Then I added 2 operating systems to the matrix as well.

Question: How many total jobs run now?

My answer: 6 jobs (3 Python versions times 2 operating systems)

## Task 5: Exclude and fail-fast

I removed one combination I did not want to test: Python 3.10 on Windows. Now only 5 jobs run instead of 6.

I also turned off fail-fast, so all jobs keep running even if one of them fails.

Question: What does fail-fast true do, compared to fail-fast false?

My answer: fail-fast true is the normal default. If one job fails, GitHub stops all the other jobs right away, even ones still working fine. fail-fast false lets every job finish on its own, no matter what happens to the others. This way I can see full results from every combination.

## Summary in my own simple words

- Pull Request trigger: runs only when a PR is opened or changed.
- Schedule trigger: runs by itself at a fixed time, every day or week.
- Manual trigger: runs only when I click a button, and can ask me for input first.
- Matrix build: one job definition that automatically becomes many jobs, one for each combination I list.
- Exclude: removes one unwanted combination from the matrix.
- fail-fast false: lets every job finish, even if one of them fails.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
