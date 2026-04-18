Task 1: Multi-Job Workflow
Create .github/workflows/multi-job.yml with 3 jobs:
- build — prints "Building the app"
- test — prints "Running tests"
- deploy — prints "Deploying"
Make test run only after build succeeds. Make deploy run only after test succeeds.
<img width="588" height="665" alt="image" src="https://github.com/user-attachments/assets/e76b6c37-9aa3-4d76-92ae-0f3c1ac292c8" />
<img width="940" height="298" alt="image" src="https://github.com/user-attachments/assets/5979a0f0-4acf-46e6-bc85-9d5c94aa5d25" />


Task 2: Environment Variables
In a new workflow, use environment variables at 3 levels:
- Workflow level — APP_NAME: myapp
- Job level — ENVIRONMENT: staging
- Step level — VERSION: 1.0.0
Print all three in a single step and verify each is accessible.
<img width="740" height="845" alt="image" src="https://github.com/user-attachments/assets/cc829c41-a79b-4134-831c-76497261b226" />
<img width="940" height="516" alt="image" src="https://github.com/user-attachments/assets/6e200c2f-37f6-46f1-ba02-39688bbb8846" />


Task 3: Job Outputs
- Create a job that sets an output — e.g., today's date as a string
- Create a second job that reads that output and prints it
- Pass the value using outputs: and needs.<job>.outputs.<name>
<img width="886" height="635" alt="image" src="https://github.com/user-attachments/assets/1b453d3e-de48-4b20-8d7f-9c0ea0fa195e" />
<img width="1108" height="447" alt="image" src="https://github.com/user-attachments/assets/4ef98308-8540-4006-93ba-bc20edb9d66e" />

- Write in your notes: Why would you pass outputs between jobs?
In GitHub Actions, each job runs on a separate runner (machine). Because of this, jobs do not share variables, memory, or files directly.
So if one job produces some data that another job needs, we use job outputs to pass that information.


Task 4: Conditionals
In a workflow, add:
- A step that only runs when the branch is main
- A job that only runs on push events, not on pull requests
- A step that only runs when the previous step failed
  <img width="671" height="682" alt="image" src="https://github.com/user-attachments/assets/0c44d895-5a02-4a9a-b3a0-00ae2421b939" />
  <img width="1238" height="866" alt="image" src="https://github.com/user-attachments/assets/4173422c-1767-4051-804c-5cc89e050eaa" />
  
- A step with continue-on-error: true — what does this do?
  <img width="708" height="702" alt="image" src="https://github.com/user-attachments/assets/79694d38-cab3-4d2f-83d6-dc38f00abf4c" />
  <img width="1082" height="870" alt="image" src="https://github.com/user-attachments/assets/80be4dce-6f46-4533-91c8-76ae1b8881d5" />

Task 5: Putting It Together
Create .github/workflows/smart-pipeline.yml that:
- Triggers on push to any branch
- Has a lint job and a test job running in parallel
- Has a summary job that runs after both, prints whether it's a main branch push or a feature branch push, and prints the commit message
  <img width="836" height="708" alt="image" src="https://github.com/user-attachments/assets/d5563fe8-312f-4d27-a2e0-20deb81284d6" />
  <img width="1295" height="557" alt="image" src="https://github.com/user-attachments/assets/770c2cde-73f6-4ace-bdaf-8ff4fcdf1862" />













