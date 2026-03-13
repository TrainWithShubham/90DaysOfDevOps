**TASK -1**
1. Verify Git is installed on your machine

   <img width="570" height="70" alt="Screenshot 2026-02-15 at 11 17 27 AM" src="https://github.com/user-attachments/assets/1c892e6a-eacb-40f5-9d1d-feb732a811e0" />


2. Set up your Git identity — name and email
   
<img width="770" height="195" alt="Screenshot 2026-02-15 at 11 22 46 AM" src="https://github.com/user-attachments/assets/1b4ce96e-3697-4799-9f41-83be23f03e64" />

3. Verify your configuration

<img width="768" height="124" alt="Screenshot 2026-02-15 at 11 26 08 AM" src="https://github.com/user-attachments/assets/4ce5efea-5777-47e0-831a-98e87c2fe87e" />


**TASK-2**
1. Create a new folder called `devops-git-practice`

2. Initialize it as a Git repository

3. Check the status — read and understand what Git is telling you

<img width="609" height="189" alt="Screenshot 2026-02-15 at 11 28 25 AM" src="https://github.com/user-attachments/assets/b72a182b-7509-4e21-a1db-283e1334e478" />

4.Explore the hidden `.git/` directory — look at what's inside
<img width="718" height="324" alt="Screenshot 2026-02-15 at 11 29 33 AM" src="https://github.com/user-attachments/assets/fe224056-fc75-4264-8eea-13b80cdc358d" />

**TASK-3**
1. Create a file called `git-commands.md` inside the repo
2. Add the Git commands you've used so far, organized by category:
   - **Setup & Config**
   - **Basic Workflow**
   - **Viewing Changes**
   - 
  <img width="809" height="279" alt="Screenshot 2026-02-15 at 11 39 12 AM" src="https://github.com/user-attachments/assets/e8e4fd92-f3ed-478a-b0d6-98451e613713" />

**TASK-4 **
==========

1. Stage your file
2. Check what's staged
<img width="920" height="245" alt="Screenshot 2026-02-15 at 11 43 21 AM" src="https://github.com/user-attachments/assets/b3395586-0ed6-4312-b8ea-d27b76a34823" />

3. Commit with a meaningful message

<img width="1076" height="90" alt="Screenshot 2026-02-15 at 11 45 02 AM" src="https://github.com/user-attachments/assets/cb6c9caf-f8b8-448d-8a30-26551a672eac" />

4. View your commit history
   
<img width="773" height="127" alt="Screenshot 2026-02-15 at 11 45 55 AM" src="https://github.com/user-attachments/assets/86fcabab-d26e-4678-bcb0-7802372f1508" />


**Task 5: Make More Changes and Build History**

1. Edit `git-commands.md` — add more commands as you discover them
<img width="868" height="318" alt="Screenshot 2026-02-15 at 11 48 41 AM" src="https://github.com/user-attachments/assets/e2e0b126-3d64-422e-9e94-a979484f114b" />

2. Check what changed since your last commit

<img width="879" height="606" alt="Screenshot 2026-02-15 at 11 52 45 AM" src="https://github.com/user-attachments/assets/3f98694a-5f9a-4d19-9d1c-4b3a0a1bfcb9" />


3. Stage and commit again with a different, descriptive message

4. Repeat this process at least **3 times** so you have multiple commits in your history

5. View the full history in a compact format
<img width="916" height="124" alt="Screenshot 2026-02-15 at 11 57 50 AM" src="https://github.com/user-attachments/assets/8819e179-5eca-4d01-b9c6-9cb79338ac27" />

**TASK-6 Understand the Git Workflow**

-->List all branches in your repo 
git branch

-->Create a new branch called feature-1
git checkout feature-1

Switch to feature-1
git switch feature-1


-->Create a new branch and switch to it in a single command — call it feature-2
git checkout -b feature-2

-->Try using git switch to move between branches — how is it different from git checkout?
git swith feature-1
switch is a new feature in git speciffilcay designed to switch between branch and checkout it similar to it but we can use chekout to create the branch if not present.


-->Make a commit on feature-1 that does not exist on main
git add .
git commit -m "test-feautre1 file which not exist on master"

-->Switch back to main — verify that the commit from feature-1 is not there

git switch master

-->Delete a branch you no longer need

git switch master
git branch -d feature-1 ( user -D if branch not merged)














   
