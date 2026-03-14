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




