Task 1: GitHub-Hosted Runners
- Create a workflow with 3 jobs, each on a different OS: (ubuntu-latest, windows-latest, macos-latest)
- In each job, print: OS name, runner's hostname, and the current user running the job
  <img width="546" height="707" alt="image" src="https://github.com/user-attachments/assets/dabdb64f-f346-4ee4-8f60-9d1536124650" />

- Watch all 3 run in parallel
  <img width="1293" height="603" alt="image" src="https://github.com/user-attachments/assets/9a4d36c5-e243-4ead-a65e-0ec1267b9dd7" />

- Write in your notes: What is a GitHub-hosted runner? Who manages it?
  A GitHub-hosted runner is a virtual machine provided by GitHub that executes GitHub Actions workflows. When a workflow is triggered, GitHub automatically creates a temporary machine to run the job. And GitHub-hosted runners are fully managed by GitHub.


Task 2: Explore What's Pre-installed
- On the ubuntu-latest runner, run a step that prints: Docker version, Python version, Node version, Git version.
  <img width="507" height="472" alt="image" src="https://github.com/user-attachments/assets/01b1975d-1225-4a7d-bbf9-da2a23fd587f" />

- Look up the GitHub docs for the full list of pre-installed software on ubuntu-latest
  You can find it [here](https://github.com/actions/runner-images)
  
- Write in your notes: Why does it matter that runners come with tools pre-installed?
  GitHub-hosted runners come with many commonly used development tools already installed. This is important for several reasons like Faster CI/CD Pipelines, Simple Workflow Configuration, Consistent Build Environment and Reduce Maintenance Effort.


Task 3: Set Up a Self-Hosted Runner
- Go to your GitHub repo → Settings → Actions → Runners → New self-hosted runner
- Choose Linux as the OS
- Follow the instructions to download and configure the runner on:
- Your local machine, OR
- A cloud VM (EC2, Utho, or any VPS)
- Start the runner — verify it shows as Idle in GitHub
- Verify: Your runner appears in the Runners list with a green dot.
  <img width="977" height="432" alt="image" src="https://github.com/user-attachments/assets/c0dbab25-e4e6-42a3-911c-f56e7c13acb2" />
  <img width="1052" height="256" alt="image" src="https://github.com/user-attachments/assets/007db879-0e25-420a-844e-49da7eb6a2f8" />


Task 4: Use Your Self-Hosted Runner
- Create .github/workflows/self-hosted.yml
- Set runs-on: self-hosted
- Add steps that:
  - Print the hostname of the machine (it should be YOUR machine/VM)
  - Print the working directory
  - Create a file and verify it exists on your machine after the run
- Trigger it and watch it run on your own hardware
  <img width="761" height="635" alt="image" src="https://github.com/user-attachments/assets/d946793b-e275-4600-a31a-bb0ea2640b04" />
  <img width="847" height="645" alt="image" src="https://github.com/user-attachments/assets/3a0a2961-3618-489f-8184-9ec35601b20d" />

- Verify: Check your machine — is the file there?
<img width="1142" height="93" alt="image" src="https://github.com/user-attachments/assets/27bc8e23-bfb7-475b-a02e-6ec8a65c7cdb" />

Task 5: Labels
- Add a label to your self-hosted runner (e.g., my-linux-runner)
  <img width="1100" height="217" alt="image" src="https://github.com/user-attachments/assets/39d9bd20-ac03-4dc7-8a1f-e3ad59dce67a" />

- Update your workflow to use runs-on: [self-hosted, my-linux-runner]
  <img width="761" height="633" alt="image" src="https://github.com/user-attachments/assets/f2fbc09f-f959-4a38-bce6-6e78c340ae5e" />

- Trigger it — does it still pick up the job?
<img width="1277" height="482" alt="image" src="https://github.com/user-attachments/assets/79a3ccf3-6227-49f5-aa40-02ac403b6a66" />

- What is Labels in GitHub Action?
  
Labels in a GitHub Actions runner are used to target specific runners for a job defined in a workflow file. They allow you to control which machine executes a particular job, especially in self-hosted environments.

- Why Are Labels Useful When You Have Multiple Self-Hosted Runners?
  
Labels become important when a project has multiple self-hosted runners with different capabilities.
They allow workflows to run on the correct machine based on requirements.

  



