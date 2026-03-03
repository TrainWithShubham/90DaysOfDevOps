### Day 40 – Your First GitHub Actions Workflow
----
#### Task 1: Set Up
- Create a new public GitHub repository called github-actions-practice
- Clone it locally
- Create the folder structure: .github/workflows/

**Explanition:**

- A public repositroy is made with name `tws_github_workflows`.Cloned locally and first `.yml file` is made with command `nano .github/workflows/heelo.yml`.A workflow is written and the changes are pushed to the  GitHub repository.


<img src="Images/Task1.png" width="900">

<img src="Images/2-1.png" width="900">
<img src="Images/2-2.png" width="900">

----
#### Task 2: Hello Workflow
- Create .github/workflows/hello.yml with a workflow that:

- Triggers on every push
- Has one job called greet
- Runs on ubuntu-latest
- Has two steps:
 - [ ] Step 1: Check out the code using actions/checkout
 - [ ] Step 2: Print Hello from GitHub Actions!
- Push it. Go to the Actions tab on GitHub and watch it run.

- Verify: Is it green? Click into the job and read every step.


<img src="Images/2-3.png" width="900">

---
#### Task 3: Understand the Anatomy
- Look at your workflow file and write in your notes what each key does:

**on:**  Specifies the events that trigger the workflow.GitHub Actions will run the workflow only when the specified event occurs.


**jobs:** Defines one or more independent taskAllows parallelization and organizing tasks into logical units.s that run as part of the workflow.
**runs-on:** Specifies the type of runner (virtual machine) the job will run on.Tells GitHub what environment your steps need.
**steps:** Defines the sequence of individual commands or actions that a job executes.Each step can either run a shell command (run) or use a prebuilt GitHub Action (uses).
**uses:** Refers to a prebuilt GitHub Action that your step will run.Lets you reuse actions like checking out code, setting up Python, building Docker images, etc.
**run:** Runs shell commands on the runner.Runs shell commands on the runner.
**name: (on a step)**A human-readable name for the step.Makes workflow logs clear and readable; shows up in the Actions UI.

---
#### Task 4: Add More Steps
- Update hello.yml to also:

- Print the current date and time
- Print the name of the branch that triggered the run (hint: GitHub provides this as a variable)
- List the files in the repo
- Print the runner's operating system
- Push again — watch the new run.


<img src="Images/4-1.png" width="900">

<img src="Images/4-2.png" width="900">


>`actions/checkout@v4` works with  `uses` command not `run`.


----


#### Task 5: Break It On Purpose
- Add a step that runs a command that will fail (e.g., exit 1 or a misspelled command)
- Push and observe what happens in the `Actions` tab
- Fix it and push again
- Write in your notes: What does a failed pipeline look like? How do you read the error?

<img src="Images/5-1.png" width="900">

>Any mistyping in command gives error 127.


<img src="Images/5-2.png" width="900">

>To introduce error 1 a step is included.
 
<img src="Images/5-3.png" width="900">

> All the errors are removed and `Actions` shows a green workflow outcome.
