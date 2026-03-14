### 1️⃣ What Can Go Wrong?
When **5 developers push code and deploy manually**, many problems can happen:
**Code Conflicts**
- Two developers modify the same file
- When merged, the application may break.

**Untested Code in Production**
  - Code may be deployed without proper testing.
  - Bugs reach production.
    
**Human Error**
Exmple:
- Deploy wrong branch
- Miss a file during deployment
- Wron environment variable
- Wrong server

**Overwriting Changes**
Developer A deploys version 1
Devolper B deploys older version by mistakes

**Environment Differences**
Production may not match the production machine.
```
id="envdiff"

Dev machine: Node 18
Server: Node 16
```
Apppliction may crash

**Depoyment Downtime**
Manual Deployment offent cause:
- service intteruption
- longer process

### 2️⃣ What Does “It Works on My Machine” Mean?

 This Means: 
  The code works correctly on the Developer's computer but fails in another environment (testing or production).

Exmple:

Developer machine:

 ```
id="devenv"
Node 18
Decoker installed
Correct environment variable
```
Production Server

```
id="prodenv"
Node 16
missing dependency
Different OS configuration
```
Result: Application Crashes.
As we can see both developer and production have different verion of node, dependency is missing in production and OS is defferent.

This is why DevOps uses:
- Docker
- CI/CDpipeline
- Infrastrcture as code

They ensure the same environment everywhere.

### 3️⃣ How Many Times Can a Team Safely Deploy Manually?

1-2 times per day at most
Maual deployment require;
- coordination
- downtime window
- testing after deploymet

Example workflow:

```
id="maualdeploy"

Prepare release
Stop server
Upload files
Test manually
```
This take time and risky.
 **How CI/CD Solves This**
 with CI/CD:

 ```
id="cicdflow"
Developer pushes code
↓
Automated tests run
↓
Build artifact
↓
Deploy automatically
```
Benefits:
- Deploy 10–100 times per day
- Consistent environments
- No manual mistakes
- Faster feedback

Companies like **Amazon deploy thousands of times per day** using CI/CD.

### CI VS CD

**Continuous Integration**: CI stands for Continuous Integration, a software development practice where developers frequently—often multiple times a day—merge their code changes into a central, shared repository.

CI ensures that every code change is automatically tested and validated.

Typical CI steps:
```
Code Push → Build → Test → Validate
```
Example CI pipeline:
- Developer pushes code to GitHub
- GitHub Actions runs automatically
- Install dependencies
- Run unit tests
- Build application
- Report success or failure

**Continuous Delivery**: Code is ready for deployment but requires manual approval.
```
CI → staging deploy → manual approval → production
```
**Continuous Deployment**: Deployment happens automatically without approval.
```
CI → staging → production automatically
```



**Typical DevOps CI/CD Pipeline**

```
Developer
   ↓
GitHub Push
   ↓
CI Pipeline
   ↓
Build
   ↓
Test
   ↓
Create Artifact (Docker Image)
   ↓
Push to Registry
   ↓
CD Pipeline
   ↓
Deploy to Server / Kubernetes
```
### Pipeline Anotomy
A pipeline has these parts — write what each one does:

 - **Trigger**: A trigger starts the pipeline automatically.
Common triggers include code push, pull request, scheduled jobs, or manual runs.

Example:
```
</> YAML
on: push
```
- **Stage**: stages has three parts:
  *Build*: The build stage compiles the application and installs dependencies.
It ensures the code can be packaged into a runnable artifact like a binary, JAR file, or Docker image.

*Test*: Automated tests run to verify the application works correctly.
These may include unit tests, integration tests, and security scans.

*Deploy*: The application is deployed to environments like staging or production servers.
Deployment can target VMs, containers, or Kubernetes clusters.

- **Job**: job is a group of steps that run together on the same runner (machine).
It performs a specific task in the pipeline such as building the application, running tests, or deploying the app.

In simple words:
A job is a stage of work made up of multiple steps.

- **Step**: This is where actual commands run.
```
  name: CI Pipeline

on: push

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Print message
        run: echo "Building application"

      - name: Show system info
        run: uname -a
```

- **Runner**: A runner is the machine (server/VM) that executes the jobs in a GitHub Actions workflow.

In simple terms:

A runner is the computer where your CI/CD pipeline actually runs.
It executes all the steps and commands defined in your workflow.

```
runs-on: ubuntu-latest
```
runs-on: ubuntu-latest → tells GitHub which runner to use.

- **runs-on: ubuntu-latest**: The pipeline creates a deployable artifact such as a Docker image, compiled binary, or packaged application.
Artifacts are usually stored in registries or artifact repositorie

### CI/CD pipeline for this scenario:

A developer pushes code to GitHub. The app is tested, built into a Docker image, and deployed to a staging server.

![IMG_5373](https://github.com/user-attachments/assets/b23f015a-192d-4698-9150-676bf7c0f947)
