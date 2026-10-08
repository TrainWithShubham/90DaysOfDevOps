# Day 48 - Docker Security Scan

Create this workflow file:

```text
.github/workflows/day-48-security-scan.yml
```

Paste this:

```yaml
name: Day 48 - Docker Security Scan

on:
  push:
    branches:
      - main
      - DevOps-practice
  workflow_dispatch:

jobs:
  security-scan:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Build Docker image
        run: docker build -t devops-cicd-lab:scan .

      - name: Scan Docker image with Trivy
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: devops-cicd-lab:scan
          format: table
          exit-code: 0
```

## Simple Explanation

This workflow scans the Docker image using Trivy.

Trivy checks the image for security issues and prints the result in the workflow logs.

I used:

```text
exit-code: 0
```

This keeps the lab workflow green while still showing the scan report.

## Screenshots To Take

```text
1. Day 48 Security Scan workflow passed
2. Trivy scan result in logs
```

