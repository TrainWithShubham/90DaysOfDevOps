Task 1: Set Up
Create a new public GitHub repository called github-actions-practice?
- In the GitHub portal -> profile -> Repositories -> Click on New Button -> Enter the repository name and hit the create repository button.
<img width="1571" height="631" alt="image" src="https://github.com/user-attachments/assets/22e35c5a-0d41-480e-a567-803d531fb0ed" />

  
Clone it locally?
- Clone repo using the git clone <repo url> command
<img width="1020" height="105" alt="image" src="https://github.com/user-attachments/assets/0e7ce87f-0649-4e4b-a3cc-c3a2be54937f" />

  
Create the folder structure: .github/workflows/
- Go into repo with cd github-actions-practice
- mkdir -p .github/workflows
<img width="842" height="227" alt="image" src="https://github.com/user-attachments/assets/bb3317cd-5f3a-40f5-b0fa-5b938eca5e3e" />



Task 2: Hello Workflow
Create .github/workflows/hello.yml with a workflow that:
Triggers on every push
Has one job called greet
Runs on ubuntu-latest
Has two steps:
Step 1: Check out the code using actions/checkout
Step 2: Print Hello from GitHub Actions!

- Created file .github/workflows/hello.yml
<img width="865" height="213" alt="image" src="https://github.com/user-attachments/assets/2b148ed2-e3e8-4e7c-8836-df64e35cd634" />
<img width="546" height="302" alt="image" src="https://github.com/user-attachments/assets/807c5b7c-8a9c-45a2-ab52-f44fa54377eb" />

 Push it to GitHub. Go to the Actions tab and watch it run.
<img width="1132" height="272" alt="image" src="https://github.com/user-attachments/assets/c64c0cb9-314f-4447-b189-4ca064396150" />
<img width="1342" height="482" alt="image" src="https://github.com/user-attachments/assets/d8f199a8-71d4-4740-adf1-388cbc5ff4a1" />



Task 3: Understand the Anatomy
Look at your workflow file and write in your notes what each key does:

- on: Defines the trigger event. In this case, the workflow runs every time there is a push to the repository.
- jobs: It is used to define a collection of tasks or steps that run together on a specific machine or environment. A workflow can have multiple jobs.
- runs-on: Specifies which virtual machine will run the job.
- steps: Defines a sequence of tasks inside a job. Steps run one by one in sequence order or parallelly.
- uses: Used to run a pre-built GitHub Action. This checks out the repository code onto the runner.
- run: Executes shell commands on the runner.
- name: (on a step) Gives a readable label to a step so it’s easier to understand in the Actions UI.


Task 4: Add More Steps
Update hello.yml to also:

Print the current date and time
Print the name of the branch that triggered the run (hint: GitHub provides this as a variable)
List the files in the repo
Print the runner's operating system
Push again — watch the new run.
<img width="612" height="576" alt="image" src="https://github.com/user-attachments/assets/12f1b348-68e6-4e7b-8f9f-1702125397ff" />



Task 5: Break It On Purpose
1. Add a step that runs a command that will fail (e.g., exit 1 or a misspelled command)?
    Added a failing step:
          - name: Break the pipeline
            run: exit 1
   <img width="1355" height="656" alt="image" src="https://github.com/user-attachments/assets/7050fe29-3270-400d-8107-dad1d6376881" />


2. Push and observe what happens in the Actions tab
   After commiting the changes puipeline turned RED and the Job stopped immediately.


3. Fix it and push again
   As part of fixing removed the failing step and commit again. Now the pipeline turned geer again
  <img width="1128" height="710" alt="image" src="https://github.com/user-attachments/assets/001880ec-3d47-4684-9e18-0a3cbc5b2012" />

