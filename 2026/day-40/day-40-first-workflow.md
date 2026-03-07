<img width="996" height="624" alt="runnner" src="https://github.com/user-attachments/assets/b145c4a7-a9a1-46d0-b591-77929f6e3725" />Created a repo github-actions-practice
then clone to local machine


### Hello Workflows

```
name: hello worksflow
on:
    push:
        branches: [main]
jobs:
  greet:
    runs-on: ubuntu-latest
    steps:
    - name: checkout-code
      uses: actions/checkout@v4
    - name: print greeting
      run: echo ""Hello from GitHub Actions!"
```

<img width="1024" height="635" alt="hello workflows" src="https://github.com/user-attachments/assets/59b6b502-9c5c-4b96-8926-c06319a5d32a" />


## Understand the Anatomy

- name: Name of the workflow.
- on: Workflow runs whenever code is pushed.
- runs-on: Runner where job executes.
- steps: Tasks executed inside the job.
- uses: Used to run a reusable GitHub Action created by someone else or by your organization.
- run: Executes a shell command.
- name (on-step): Provides a human-readable label for the step in the workflow logs.

# Print current date 
```
name: hello worksflow
on:
    push:
        branches: [main]
jobs:
  greet:
    runs-on: ubuntu-latest
    steps:
    - name: checkout-code
      uses: actions/checkout@v4
    - name: print greeting
      run: echo ""Hello from GitHub Actions!"
    - name: print current date and time
      run: date "+%y-%m-%d %H:%M:%S"
```
<img width="1015" height="640" alt="current_date_time" src="https://github.com/user-attachments/assets/8695e103-fb1b-4db5-890d-7bc786b52d2d" />

# List all files in directory
    ls -l: List all the file in the repo

``` name: hello worksflow
on:
    push:
        branches: [main]
jobs:
  greet:
    runs-on: ubuntu-latest
    steps:
    - name: checkout-code
      uses: actions/checkout@v4
    - name: print greeting
      run: echo "Hello from GitHub Actions!"
    - name: Print current date and time
      run: date "+%y-%m-%d %H:%M:%S"
    - name: Print branch
      run: echo "Branch name is ${{github.ref_name}}"
    - name: List the file in repo
      run: ls -l
```
<img width="975" height="607" alt="list_file" src="https://github.com/user-attachments/assets/b5a0fc64-7c56-458e-aefb-0b430292842a" />

# Print runner of Workflow
```
name: hello worksflow
on:
    push:
        branches: [main]
jobs:
  greet:
    runs-on: ubuntu-latest
    steps:
    - name: checkout-code
      uses: actions/checkout@v4
    - name: print greeting
      run: echo "Hello from GitHub Actions!"
    - name: Print current date and time
      run: date "+%y-%m-%d %H:%M:%S"
    - name: Print branch
      run: echo "Branch name is ${{github.ref_name}}"
    - name: List the file in repo
      run: ls -l
    - name: Print runner operating system
      run: echo  Runner OS is "${{runner.os}}"
```
<img width="996" height="624" alt="runnner" src="https://github.com/user-attachments/assets/e657d812-f7d7-4d37-9f6a-c24934608bc1" />

 **Adding wrong command**
 The workflow log shows: 
 ```
Run exit 1
Error: Process completed with exit code 1.
```
```
✔ Checkout code
✔ Print greeting
✔ Print current date
✔ Print branch name
✔ List files
✔ Print runner OS
✖ Intentional failure step
```
The job stops immediately after the failure.


