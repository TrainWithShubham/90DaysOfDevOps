What is CI/CD?
- CI/CD stands for Continuous Integration and Continuous Delivery (or Deployment). It's a DevOps practice that automates building, testing, and deploying code changes, enabling faster and more reliable software releases. 


Task 1: The Problem
Think about a team of 5 developers all pushing code to the same repo manually deploying to production.

Problem Scenarios
What can go wrong?
- Code conflicts between developers
- Manual deployment mistakes
- Someone forgets to test before deploying
- Different environments (Dev vs Prod mismatch)
- Hard to track who deployed what

What does "it works on my machine" mean and why is it a real problem?
- "It works on my machine" means that the code runs perfectly on the developer's system but fails in staging or production environment because of different OS version, dependencies, db version and missing environment variables. It's a real problem because software should behave the same everywhere otherwise deployments become unpredictable and risky. 

How many times a day can a team safely deploy manually?
- 1 or 2 times hardly. Even that carries high risk.


Task 2: CI vs CD
Research and write short definitions (2-3 lines each):

Continuous Integration — what happens, how often, what it catches?
- Continuous Integration is the practice of automatically testing and validating code every time developers push changes to the repository. It usually runs on every pull request or push, builds the application, runs automated tests, checks code quality,
- What It Catches: Broken builds, Failing tests, Integration issues, Dependency conflicts.
- Real-World Example: A developer pushes code to GitHub → Tests automatically run → If tests fail, the merge is blocked.
  
Continuous Delivery — how it's different from CI, what "delivery" means?
- Continuous Delivery ensures that after passing CI, the application is always ready to be deployed to production. Deployment is still a manual approval step, but everything else is automated.
- Here "Delivery" Means: The code is ready for release anytime.
- Real-World Example: Code passes tests → Docker image is built → Pushed to registry → Ready to deploy to staging or production with one click.

Continuous Deployment — how it differs from Delivery, when teams use it?
- Continuous Deployment goes one step further. If code passes all tests, it is automatically deployed to production without manual approval.
- When Teams Use It: SaaS products, High automation maturity, Strong test coverage.
- Real-World Example: Developer merges PR → Tests pass → Automatically deployed to production → Users get update immediately.

  
Task 3: Pipeline Anatomy
A pipeline has these parts — write what each one does:

Trigger — what starts the pipeline
- A trigger is the event that tells the pipeline to start working. Without a trigger, nothing happens.
- Common Triggers: Code push to a branch, Pull request created, Manual trigger, Scheduled cron job.
  
Stage — a logical phase (build, test, deploy)
- A stage is a high-level phase in the pipeline. It groups related activities together.
- Common Stages: Build, Test, Security Scan, Package, Deploy.

Job — a unit of work inside a stage
- A job is a specific set of tasks executed on a runner. Each stage can have one or multiple jobs and jobs can run sequentially or parallel.
 
Step — a single command or action inside a job
- A step is a single command or action inside a job. Steps run one after another inside the same job.

Runner — the machine that executes the job
- Runner are the servers that execute your GitHub Actions workflows when triggered.
  
Artifact — output produced by a job
- An artifact is something created during the pipeline that is saved for later use.


Task 4: Draw a Pipeline
Draw a CI/CD pipeline for below scenario:

A developer pushes code to GitHub. The app is tested, built into a Docker image, and deployed to a staging server.
- <img width="1146" height="1600" alt="image" src="https://github.com/user-attachments/assets/789b03fa-5b6a-4166-81af-a5b96c87a475" />

Task 5: Explore in the Wild
Open any popular open-source repo on GitHub (Kubernetes, React, FastAPI — pick one you know). Find their .github/workflows/ folder. Open one workflow YAML file.
Write in your notes:
- I selected the workflow from the layer5io meshery repository, specifically the Scheduled Benchmark Tests workflow found under .github/workflows/scheduled-benchmarks.yml.
- Although this workflow is part of a GitHub Action project rather than the main Meshery repo, it is directly related to Meshery and widely used for performance CI/CD in the ecosystem.
  
What triggers it?
- This workflow is triggered by a schedule event, meaning it runs automatically at fixed times based on a cron schedule. Scheduled workflows are useful for recurring tasks such as nightly tests, performance benchmarks, or maintenance checks without any manual push or pull request.

How many jobs does it have?
- While the full YAML could include multiple jobs, this workflow is centered on a single main job (e.g., performance-test or similar). This job runs performance benchmarks using Meshery tools and actions.

What does it do? (best guess)
- This workflow automates performance testing with Meshery. It likely does the following:
  - It is used for performance benchmark against defined targets
  - It executes benchmark tests and collects performance metrics.
  - It is used to stores or reports results, enabling automated performance tracking over time.

