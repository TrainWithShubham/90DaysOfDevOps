# Day 49 – DevSecOps: Add Security to Your CI/CD Pipeline

## Introduction

Until now, the CI/CD pipeline was responsible for **building, testing, packaging, and deploying the application automatically**. However, modern software delivery also requires **security to be integrated into the pipeline itself**.

DevSecOps means **embedding security checks directly into the CI/CD pipeline so vulnerabilities are detected early during development instead of after deployment**.

Instead of waiting for a separate security review after release, the pipeline automatically performs security checks every time code is pushed or a pull request is opened.

This approach ensures that **security becomes part of the development workflow rather than an afterthought**.

---

# What is DevSecOps?

DevSecOps stands for **Development + Security + Operations**.

It means integrating security practices into every stage of the CI/CD pipeline.

### Without DevSecOps

Developers build the application and deploy it to production.  
Later, a security team scans the system and discovers vulnerabilities.  
Fixing these vulnerabilities at that stage can take significant time and may disrupt production systems.

### With DevSecOps

Security checks run automatically as part of the pipeline:

PR opened → security checks run → vulnerabilities detected early → developer fixes before merge.

This significantly reduces risk and prevents insecure code or images from reaching production.

---

# Key DevSecOps Principles

## 1. Catch Problems Early

Detecting vulnerabilities early in the development lifecycle saves time and reduces risk.

A vulnerability discovered in a pull request can usually be fixed within minutes.  
The same vulnerability discovered in production may require emergency patches and service interruptions.

---

## 2. Automate Security Checks

Security should not depend on manual checks.

Automated scans ensure every change is evaluated consistently and no step is forgotten.

CI/CD pipelines allow security scans to run automatically on every commit or pull request.

---

## 3. Fail the Pipeline on Critical Issues

Security scans should behave like tests.

If a serious vulnerability is detected, the pipeline should fail and prevent deployment until the issue is fixed.

This prevents insecure builds from progressing further in the delivery process.

---

## 4. Never Store Secrets in Code

Sensitive information such as API keys, tokens, and passwords must never be committed to the repository.

Instead, secrets should be stored securely using **GitHub Secrets** and accessed by workflows at runtime.

---

## 5. Apply the Principle of Least Privilege

Workflows should only receive the minimum permissions required to perform their tasks.

Restricting permissions reduces the damage that could occur if a workflow or action is compromised.

---

# Task 1 – Docker Image Vulnerability Scan (Trivy)

Docker images may contain vulnerabilities inherited from their base operating system or installed packages.

To detect these vulnerabilities automatically, **Trivy** was added to the pipeline.

The scan runs **after building the Docker image but before pushing or deploying it**.

### Workflow Step

```yaml
- name: Scan Docker Image for Vulnerabilities
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: 'your-username/your-app:latest'
    format: 'table'
    exit-code: '1'
    severity: 'CRITICAL,HIGH'
```

### What This Step Does

Trivy scans the Docker image layers and compares installed packages against vulnerability databases.

Key parameters:

- **image-ref** – The Docker image to scan
- **format: table** – Displays results in readable format
- **exit-code: 1** – Fails the pipeline if vulnerabilities are found
- **severity** – Limits failure to high-risk vulnerabilities

### Scan Result

During the scan, a vulnerability was detected:

CVE detected: **CVE-2026-0861**

Affected packages:

- libc-bin  
- libc6  

These packages are part of the **Debian operating system layer**.

### Base Image Used

```
python:3.13-slim
```

The vulnerability originates from the **Debian base image**, not from Python itself.

This demonstrates how container security scanning helps identify issues inherited from base images.

---

# Task 2 – GitHub Secret Scanning

GitHub provides built-in tools to detect leaked credentials in repositories.

Two important security features were enabled:

### Secret Scanning

Secret scanning continuously monitors the repository for exposed secrets such as:

- API keys
- AWS access keys
- authentication tokens
- private keys

If a secret is detected, GitHub raises a security alert so maintainers can immediately revoke and rotate the credentials.

---

### Push Protection

Push protection prevents secrets from ever reaching the repository.

If a developer attempts to commit a file containing a known credential pattern, GitHub blocks the push and displays a warning.

### Difference Between Secret Scanning and Push Protection

Secret scanning detects secrets **after they have already been committed to the repository**.

Push protection prevents secrets **before the commit is accepted by the repository**.

Push protection therefore acts as a preventive control, while secret scanning is a detection mechanism.

---

### Example Scenario

If a developer accidentally commits an AWS key:

```
AWS_ACCESS_KEY_ID=AKIAxxxxxxxx
```

GitHub will:

1. Detect the pattern
2. Block the push (if push protection is enabled)
3. Generate a security alert

The developer must remove the secret before pushing again.

---

# Task 3 – Dependency Vulnerability Scan

Application dependencies may contain known vulnerabilities.

To detect risky packages early, the pipeline uses **GitHub Dependency Review**.

This check runs in the **Pull Request pipeline**.

### Workflow Step

```yaml
- name: Check Dependencies for Vulnerabilities
  uses: actions/dependency-review-action@v4
  with:
    fail-on-severity: critical
```

### How Dependency Review Works

When a pull request is opened, GitHub compares dependency files between:

- the base branch (main)
- the pull request branch

If new dependencies are introduced, they are checked against the **GitHub Advisory Database**.

If a dependency contains a critical vulnerability, the PR check fails.

This prevents insecure libraries from being merged into the main branch.

---

# Task 4 – Restrict Workflow Permissions

By default, GitHub Actions workflows receive broad permissions through the `GITHUB_TOKEN`.

To improve security, workflow permissions were restricted.

### Basic Read-Only Permission

```yaml
permissions:
  contents: read
```

This allows workflows to read repository contents but prevents them from modifying the repository.

---

### Workflow with PR Interaction

If a workflow needs to interact with pull requests:

```yaml
permissions:
  contents: read
  pull-requests: write
```

This allows the workflow to comment on PRs while still limiting unnecessary permissions.

---

### Why Limiting Workflow Permissions is Important

Many workflows use third-party GitHub Actions from the marketplace.

If one of these actions becomes compromised, excessive permissions could allow malicious behavior.

Restricting permissions minimizes the potential damage.

---

### Risks of Excessive Permissions

If a compromised action has write access to the repository, it could:

- Push malicious code into the repository
- Modify workflow files to execute harmful scripts
- Leak sensitive secrets stored in the pipeline
- Create unauthorized commits or tags
- Open or manipulate pull requests

Following the **principle of least privilege** helps protect the repository from supply chain attacks.

---

# Task 5 – Final Secure Pipeline

After implementing DevSecOps improvements, the pipeline now includes automated security checks.

### Pull Request Pipeline

```
PR opened
  → build & test
  → dependency vulnerability check
  → PR checks pass or fail
```

### Main Branch Pipeline

```
Merge to main
  → build & test
  → Docker build
  → Trivy container scan
  → Docker push (only if scan passes)
  → deploy
```

### Continuous Security Features

```
GitHub secret scanning
Push protection for secrets
```

---

# Final DevSecOps Pipeline Diagram

```
Developer opens PR
        │
        ▼
Build & Test
        │
        ▼
Dependency Review Scan
        │
        ▼
PR Approved & Merged
        │
        ▼
Build Application
        │
        ▼
Build Docker Image
        │
        ▼
Trivy Vulnerability Scan
        │
        ▼
Push Image to Registry
        │
        ▼
Deploy Application
```

---

# What I Learned

DevSecOps integrates security directly into the CI/CD pipeline.

Instead of performing security checks after deployment, vulnerabilities are detected automatically during development.

By adding container scanning, dependency checks, secret protection, and permission restrictions, the pipeline now prevents insecure code, vulnerable dependencies, and exposed credentials from reaching production.

This approach improves both **security and reliability of the software delivery process**.
