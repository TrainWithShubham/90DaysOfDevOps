# Day 49 - Final CI/CD Pipeline

Create this workflow file:

```text
.github/workflows/day-49-final-pipeline.yml
```

Paste this:

```yaml
name: Day 49 - Final CI/CD Pipeline

on:
  push:
    branches:
      - main
      - DevOps-practice
  workflow_dispatch:

env:
  IMAGE_NAME: devops-cicd-lab

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.12"

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt

      - name: Run Python tests
        run: pytest scripts/test_app.py

  docker:
    runs-on: ubuntu-latest
    needs: test

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set short SHA
        run: echo "SHORT_SHA=${GITHUB_SHA::7}" >> $GITHUB_ENV

      - name: Build Docker image
        run: |
          docker build -t ${{ secrets.DOCKER_USERNAME }}/${{ env.IMAGE_NAME }}:latest .
          docker tag ${{ secrets.DOCKER_USERNAME }}/${{ env.IMAGE_NAME }}:latest ${{ secrets.DOCKER_USERNAME }}/${{ env.IMAGE_NAME }}:sha-${{ env.SHORT_SHA }}

      - name: Log in to Docker Hub
        if: github.ref == 'refs/heads/main' || github.ref == 'refs/heads/DevOps-practice'
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_TOKEN }}

      - name: Push Docker image
        if: github.ref == 'refs/heads/main' || github.ref == 'refs/heads/DevOps-practice'
        run: |
          docker push ${{ secrets.DOCKER_USERNAME }}/${{ env.IMAGE_NAME }}:latest
          docker push ${{ secrets.DOCKER_USERNAME }}/${{ env.IMAGE_NAME }}:sha-${{ env.SHORT_SHA }}
```

## Simple Explanation

This is the final CI/CD pipeline.

It has two jobs:

```text
test
docker
```

The Docker job runs only after the test job passes.

That means the image is pushed only when the tests are successful.

## Screenshots To Take

```text
1. Day 49 Final Pipeline workflow passed
2. Test job passed
3. Docker job passed
4. Docker Hub image updated
```

