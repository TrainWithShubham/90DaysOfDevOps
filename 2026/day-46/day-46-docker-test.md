# Day 46 - Docker Container Test

Create this workflow file:

```text
.github/workflows/day-46-docker-test.yml
```

Paste this:

```yaml
name: Day 46 - Docker Test

on:
  push:
    branches:
      - main
      - DevOps-practice
  workflow_dispatch:

jobs:
  docker-test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Build Docker image
        run: docker build -t devops-cicd-lab:test .

      - name: Run container
        run: |
          docker run -d -p 5000:5000 --name devops-lab devops-cicd-lab:test
          sleep 5

      - name: Test running container
        run: curl -f http://localhost:5000

      - name: Stop container
        if: always()
        run: docker stop devops-lab
```

## Simple Explanation

This workflow checks if the Docker container really works.

It builds the image, runs the container, and tests the app with:

```text
curl http://localhost:5000
```

If the app does not respond, the workflow fails.

## Screenshots To Take

```text
1. Day 46 Docker Test workflow passed
2. Logs showing curl test worked
```
