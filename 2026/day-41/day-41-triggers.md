Task 1: Trigger on Pull Request
- Create .github/workflows/pr-check.yml
- Trigger it only when a pull request is opened or updated against main
- Add a step that prints: PR check running for branch: <branch name>
<img width="797" height="355" alt="image" src="https://github.com/user-attachments/assets/51131ff0-61d7-451c-a4e0-ff5b599c702a" />

Create a new branch, push a commit, and open a PR
<img width="1113" height="421" alt="image" src="https://github.com/user-attachments/assets/ba99de41-65cd-4e4b-8366-0ca40fde5540" />

Watch the workflow run automatically
<img width="1062" height="312" alt="image" src="https://github.com/user-attachments/assets/4cb6d66a-ac56-401f-b260-64ee26b04cac" />

Verify: Does it show up on the PR page?
<img width="1182" height="595" alt="image" src="https://github.com/user-attachments/assets/424f9bed-fe9b-4984-9dc1-042692431902" />


Task 2: Scheduled Trigger
- Add a schedule: trigger to any workflow using cron syntax
- Set it to run every day at midnight UTC
<img width="762" height="273" alt="image" src="https://github.com/user-attachments/assets/77ab5547-fb3b-4226-9138-884a8d055463" />

Write in your notes: What is the cron expression for every Monday at 9 AM?
- cron expression: A cron expression is a string of 5 or 6 fields separated by spaces used to schedule recurring tasks in Unix-like systems and applications. It defines exactly when a job runs based on minutes, hours, day of the month, month, and day of the week, allowing for complex, automated time-based scheduling.
- cron expression for every monday at 9 AM is: "0 9 * * 1"


Task 3: Manual Trigger
- Create .github/workflows/manual.yml with a workflow_dispatch: trigger
- Add an input that asks for an environment name (staging/production)
- Print the input value in a step
<img width="767" height="357" alt="image" src="https://github.com/user-attachments/assets/a3b822ed-74e9-4827-9569-fc418cfceddc" />

- Go to the Actions tab → find the workflow → click Run workflow
<img width="1486" height="596" alt="image" src="https://github.com/user-attachments/assets/f0c1c895-6e05-421e-9121-1d86fc1ac835" />

- Verify: Can you trigger it manually and see your input printed?
<img width="1382" height="633" alt="image" src="https://github.com/user-attachments/assets/a3a094c3-9e90-41d2-8159-cd684f271496" />


Task 4: Matrix Builds
Create .github/workflows/matrix.yml that:
- Uses a matrix strategy to run the same job across:
- Python versions: 3.10, 3.11, 3.12
- Each job installs Python and prints the version
  <img width="642" height="607" alt="image" src="https://github.com/user-attachments/assets/3e14a43a-8a5b-4558-9bfb-64969a7227d4" />

- Watch all 3 run in parallel
  <img width="1452" height="627" alt="image" src="https://github.com/user-attachments/assets/94b61ec1-fb2a-4641-939a-16959535e93b" />

- Then extend the matrix to also include 2 operating systems — how many total jobs run now?
  <img width="625" height="625" alt="image" src="https://github.com/user-attachments/assets/e81efc11-c48f-4f9b-8558-3cdb950dffda" />
  <img width="1298" height="722" alt="image" src="https://github.com/user-attachments/assets/c886ee82-5091-48e0-944d-d3bb69750235" />


Task 5: Exclude & Fail-Fast
- In your matrix, exclude one specific combination (e.g., Python 3.10 on Windows)
- Set fail-fast: false — trigger a failure in one job and observe what happens to the rest
  <img width="665" height="746" alt="image" src="https://github.com/user-attachments/assets/92965728-cc5c-4b5e-a82b-ce5e540d3cc9" />
  <img width="1288" height="702" alt="image" src="https://github.com/user-attachments/assets/0bee1c22-7e27-45ac-be01-0b0a76b2f0e4" />

- Write in your notes: What does fail-fast: true (the default) do vs false?
  
fail-fast: It controls what happens to other matrix jobs when one job fails. By default, fail-fast is set to true. This means if one job in the matrix fails, GitHub will cancel all the remaining running or queued jobs in that matrix. And if fail-fast is set to false, GitHub will continue running all jobs even if one job fails.



