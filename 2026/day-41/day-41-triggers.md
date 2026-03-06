Task 1: Trigger on Pull Request
Create .github/workflows/pr-check.yml
Trigger it only when a pull request is opened or updated against main
Add a step that prints: PR check running for branch: <branch name>
<img width="797" height="355" alt="image" src="https://github.com/user-attachments/assets/51131ff0-61d7-451c-a4e0-ff5b599c702a" />

Create a new branch, push a commit, and open a PR
<img width="1113" height="421" alt="image" src="https://github.com/user-attachments/assets/ba99de41-65cd-4e4b-8366-0ca40fde5540" />

Watch the workflow run automatically
<img width="1062" height="312" alt="image" src="https://github.com/user-attachments/assets/4cb6d66a-ac56-401f-b260-64ee26b04cac" />

Verify: Does it show up on the PR page?
<img width="1182" height="595" alt="image" src="https://github.com/user-attachments/assets/424f9bed-fe9b-4984-9dc1-042692431902" />


Task 2: Scheduled Trigger
Add a schedule: trigger to any workflow using cron syntax
Set it to run every day at midnight UTC
<img width="762" height="273" alt="image" src="https://github.com/user-attachments/assets/77ab5547-fb3b-4226-9138-884a8d055463" />

Write in your notes: What is the cron expression for every Monday at 9 AM?
- cron expression: A cron expression is a string of 5 or 6 fields separated by spaces used to schedule recurring tasks in Unix-like systems and applications. It defines exactly when a job runs based on minutes, hours, day of the month, month, and day of the week, allowing for complex, automated time-based scheduling.
- cron expression for every monday at 9 AM is: "0 9 * * 1"


Task 3: Manual Trigger
Create .github/workflows/manual.yml with a workflow_dispatch: trigger
Add an input that asks for an environment name (staging/production)
Print the input value in a step
<img width="767" height="357" alt="image" src="https://github.com/user-attachments/assets/a3b822ed-74e9-4827-9569-fc418cfceddc" />

Go to the Actions tab → find the workflow → click Run workflow
<img width="1486" height="596" alt="image" src="https://github.com/user-attachments/assets/f0c1c895-6e05-421e-9121-1d86fc1ac835" />

Verify: Can you trigger it manually and see your input printed?
<img width="1382" height="633" alt="image" src="https://github.com/user-attachments/assets/a3a094c3-9e90-41d2-8159-cd684f271496" />


