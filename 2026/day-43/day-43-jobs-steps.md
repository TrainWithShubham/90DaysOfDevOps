# Day 43 – Jobs, Steps, Env Vars and Conditionals

## What I learned today

Today I learned how to control the flow of my pipeline. I learned how to make jobs run in a certain order, how to use environment variables at different levels, how to pass data between jobs, and how to run steps only when certain conditions are true.

---

## Task 1: Multi-Job Workflow

I made a file called multi-job.yml with three jobs: build, test, and deploy. I used needs so that test only starts after build finishes successfully, and deploy only starts after test finishes successfully.

What happened: the Actions graph showed a clean chain, build then test then deploy, connected one after another, all green.

In my own words: needs tells a job to wait for another job to finish successfully before it starts. Without needs, all jobs would try to run at the same time.

---

## Task 2: Environment Variables

I used environment variables at three different levels in one workflow.

Workflow level: APP_NAME, set once at the top, available to every job in the file.

Job level: ENVIRONMENT, set inside one job, only available to that job.

Step level: VERSION, set inside one step, only available to that step.

I printed all three together in one step, and they all worked. I also printed two GitHub context variables: the commit SHA and the actor, which is the username of whoever triggered the run.

What happened: all three variables printed correctly, along with the real commit SHA and my GitHub username.

---

## Task 3: Job Outputs

I made one job called set-date that creates a value, today's date, and saves it as an output. I made a second job called read-date that waits for the first job, then reads and prints that same value.

What happened: the second job printed the exact same date that the first job generated, proving the value passed correctly between them.

Question: Why would you pass outputs between jobs?

My answer: Each job runs on its own separate machine, so jobs do not share memory or files automatically. If one job creates a value that a later job needs, like a version number or a generated ID, outputs are the proper way to hand that value over.

---

## Task 4: Conditionals

In one workflow, I added four things:

A step that only runs when the branch is my main working branch.

A step that only runs when the previous step failed. I forced a step to fail on purpose to test this.

A job that only runs on a push event, not on a pull request.

A step with continue-on-error set to true.

What happened: the step that failed on purpose showed a red error message, but the whole job still finished successfully, because continue-on-error let it move on instead of stopping everything. The very next step correctly detected that failure and ran because of it.

Question: What does continue-on-error true do?

My answer: It lets one step fail without stopping the rest of the job or marking the whole workflow as failed. This is useful for optional steps where a failure should not block the rest of the pipeline.

---

## Task 5: Putting It Together

I made a file called smart-pipeline.yml. It has a lint job and a test job that run at the same time, in parallel, since neither one needs the other. Then it has a summary job that waits for both of them to finish using needs, and prints whether the push was to my main branch or a feature branch, plus the actual commit message.

What happened: the graph showed lint and test side by side, both connecting into summary. The summary job correctly printed the branch message and the real commit message.

---

## Summary in my own simple words

- needs: makes one job wait for another job to finish successfully before it starts.
- Environment variables can be set at the workflow level, job level, or step level, and lower levels do not remove the ones above them, they all work together.
- outputs: lets one job pass a value to another job, since jobs run separately and do not share data on their own.
- if: lets a step or job run only when a certain condition is true, like a specific branch or a certain event type.
- continue-on-error: true lets a step fail without stopping the whole job.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
