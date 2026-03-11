### Github-hoted-Runner
**Task 1**
Multiple-os and printed: OS, hostname and user

```
name: Multi-OS Info Workflow

on: [push, workflow_dispatch]

jobs:
  build:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
    steps:
    - name: Print OS, Hostname, and User
      run: |
        # Commands for Linux and macOS runners
        if [ "$RUNNER_OS" == "Linux" ] || [ "$RUNNER_OS" == "macOS" ]; then
          echo "OS: $RUNNER_OS"
          echo "Hostname: $(hostname)"
          echo "User: $(whoami)"
          
        # Commands for Windows runners (using PowerShell)
        elif [ "$RUNNER_OS" == "Windows" ]; then
          echo "OS: $env:RUNNER_OS"
          echo "Hostname: $env:COMPUTERNAME"
          echo "User: $env:USERNAME"
        fi
      shell: bash
```
<img width="1024" height="768" alt="Screenshot (4)" src="https://github.com/user-attachments/assets/ab0d1d2b-c988-4d52-8738-23ee932b8f50" />

A GitHub Runner is the machine (virtual or physical) that executes the jobs in your GitHub Actions workflow. It works by cloning your repository, installing necessary software, and running the commands defined in your .yml files. 
GitHub Docs
GitHub Docs
 +3
Who manages the runner depends on the type of runner you choose:
1. GitHub-hosted Runners
What they are: Fresh virtual machines (Ubuntu, Windows, or macOS) provided by GitHub for each job.
Who manages them: GitHub.
Management duties: GitHub handles all hardware, operating system updates, security patches, and pre-installed software.
Best for: Users who want a "zero-maintenance" solution and don't need highly specialized hardware.

### Task 2
 ** Print Version of Docker, git, pyhthon and node**
  ```
name: Ubuntu-Runner
on: 
    workflow_dispatch:

jobs:
    Print-software-version:
        runs-on: ubuntu-latest

        steps:
            - name: Print Version
              run: | 
                   docker --version
                   python --version
                   node --version
                   git --version
```
<img width="1000" height="490" alt="runner" src="https://github.com/user-attachments/assets/c2c21c05-f4ec-4280-816b-0fca478d7d33" />

