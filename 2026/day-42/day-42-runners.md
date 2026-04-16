# 🏃 Day 42 – Runners: GitHub-Hosted & Self-Hosted
> By Mohammad Adnan Khan | 90DaysOfDevOps

---

## 📌 Task 1: GitHub-Hosted Runners

**What is a GitHub-Hosted Runner?**
A GitHub-hosted runner is a virtual machine provided and managed by GitHub. You don't need to set it up — GitHub handles everything including OS, software, maintenance, and security.

**Who manages it?** GitHub manages it completely — you just use it!

```yaml
name: Multi-OS Jobs

on:
  push:
    branches: [main]

jobs:
  ubuntu-job:
    runs-on: ubuntu-latest
    steps:
      - name: Print OS info
        run: |
          echo "OS: Ubuntu"
          echo "Hostname: $(hostname)"
          echo "User: $(whoami)"

  windows-job:
    runs-on: windows-latest
    steps:
      - name: Print OS info
        run: |
          echo "OS: Windows"
          echo "Hostname: $env:COMPUTERNAME"
          echo "User: $env:USERNAME"

  macos-job:
    runs-on: macos-latest
    steps:
      - name: Print OS info
        run: |
          echo "OS: macOS"
          echo "Hostname: $(hostname)"
          echo "User: $(whoami)"
```

---

## 📌 Task 2: Pre-installed Software on ubuntu-latest

```yaml
- name: Check pre-installed tools
  run: |
    echo "Docker: $(docker --version)"
    echo "Python: $(python3 --version)"
    echo "Node: $(node --version)"
    echo "Git: $(git --version)"
```

**Why does it matter that runners come with tools pre-installed?**
- No need to install Docker, Python, Git on every run → saves time
- Consistent environment for every pipeline run
- Focus on your workflow logic, not environment setup
- Free compute time not wasted on installations

---

## 📌 Task 3: Self-Hosted Runner Setup ✅

**Steps followed:**
1. GitHub repo → Settings → Actions → Runners → New self-hosted runner
2. Selected: Linux, x64
3. Downloaded and configured runner on AWS EC2

```bash
# Download runner
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.332.0.tar.gz -L \
  https://github.com/actions/runner/releases/download/v2.332.0/actions-runner-linux-x64-2.332.0.tar.gz

# Verify checksum
echo "f2094522a6b9afeab07ffb586d1eb3f190b6457074282796c497ce7dce9e0f2a  actions-runner-linux-x64-2.332.0.tar.gz" | shasum -a 256 -c

# Extract
tar xzf ./actions-runner-linux-x64-2.332.0.tar.gz

# Configure
./config.sh --url https://github.com/AddyKhan257/Git-Hub-Action-Zero-To-Hero \
  --token YOUR_TOKEN

# Start runner
./run.sh
```

**Runner registered as:** `khanshab`
**Labels:** `self-hosted`, `Linux`, `X64`, `prod`
**Status:** ✅ Idle — showing green in GitHub

---

## 📌 Task 4: Workflow Using Self-Hosted Runner

```yaml
name: Self-Hosted Job

on:
  workflow_dispatch:

jobs:
  run-on-my-machine:
    runs-on: self-hosted
    steps:
      - name: Print hostname
        run: echo "Running on $(hostname)"

      - name: Print working directory
        run: pwd

      - name: Create a file
        run: |
          echo "Created by GitHub Actions on $(date)" > proof.txt
          cat proof.txt

      - name: Verify file exists
        run: ls -la proof.txt
```

**Result:** File `proof.txt` was created on my EC2 server! ✅
**Hostname showed:** `ip-172-31-35-160` — my actual AWS EC2 machine!

---

## 📌 Task 5: Runner Labels

**Label added:** `prod`

```yaml
# Target specific runner using labels
jobs:
  deploy:
    runs-on: [self-hosted, Linux, prod]
    steps:
      - run: echo "Running on prod runner!"
```

**Why are labels useful when you have multiple runners?**
- You might have `dev`, `staging`, `prod` runners
- Labels let you target the right machine for the right job
- Example: deploy to prod only runs on the `prod` labelled runner
- Prevents accidentally running prod code on dev machines

---

## 📌 Task 6: GitHub-Hosted vs Self-Hosted

| | GitHub-Hosted | Self-Hosted |
|---|---|---|
| **Who manages it?** | GitHub manages everything | You manage the server |
| **Cost** | Free (with limits) | You pay for the server |
| **Pre-installed tools** | Docker, Python, Node, Git etc. | You install what you need |
| **Good for** | Open source, quick pipelines | Private repos, custom hardware |
| **Security concern** | Code runs on GitHub's servers | Code runs on YOUR server — more control |
| **Persistence** | Fresh VM every run | Files persist between runs |
| **Speed** | Depends on GitHub queue | Depends on your server specs |

---

## 🎯 Key Learnings from Day 42

1. **GitHub-hosted runners** = Virtual machines managed by GitHub, free with limits
2. **Self-hosted runners** = Your own server registered to GitHub
3. `runs-on: ubuntu-latest` = GitHub's server
4. `runs-on: self-hosted` = YOUR server
5. **Labels** help target specific runners in multi-runner setups
6. Self-hosted runners are perfect for production deployments
7. `./run.sh` starts the runner, `./svc.sh install` makes it a permanent service

---

## 📸 Screenshots
- ✅ Self-hosted runner registered (runner config in terminal)
- ✅ Runner showing as Idle in GitHub (khanshab — green dot)

---

## 🔗 References
- GitHub: [AddyKhan257/90DaysOfDevOps](https://github.com/AddyKhan257/90DaysOfDevOps/tree/master/2026/day-42)

---

*Day 42 of 90DaysOfDevOps Challenge*
*#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham*
