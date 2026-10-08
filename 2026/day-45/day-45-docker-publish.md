# Day 45 - Docker Build And Push

Create this workflow file:

```text
.github/workflows/docker-publish.yml
```

Paste this:

```yaml
name: Day 45 - Docker Publish

on:
  push:
    branches:
      - main
      - DevOps-practice
  workflow_dispatch:

env:
  IMAGE_NAME: devops-cicd-lab

jobs:
  docker-build-push:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set short SHA
        run: echo "SHORT_SHA=${GITHUB_SHA::7}" >> $GITHUB_ENV

      - name: Log in to Docker Hub
        if: github.ref == 'refs/heads/main' || github.ref == 'refs/heads/DevOps-practice'
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_TOKEN }}

      - name: Build Docker image
        run: |
          docker build -t ${{ secrets.DOCKER_USERNAME }}/${{ env.IMAGE_NAME }}:latest .
          docker tag ${{ secrets.DOCKER_USERNAME }}/${{ env.IMAGE_NAME }}:latest ${{ secrets.DOCKER_USERNAME }}/${{ env.IMAGE_NAME }}:sha-${{ env.SHORT_SHA }}

      - name: Push Docker image
        if: github.ref == 'refs/heads/main' || github.ref == 'refs/heads/DevOps-practice'
        run: |
          docker push ${{ secrets.DOCKER_USERNAME }}/${{ env.IMAGE_NAME }}:latest
          docker push ${{ secrets.DOCKER_USERNAME }}/${{ env.IMAGE_NAME }}:sha-${{ env.SHORT_SHA }}
```

## Simple Explanation

This workflow builds a Docker image and pushes it to Docker Hub.

It uses these GitHub secrets:

```text
DOCKER_USERNAME
DOCKER_TOKEN
```

It creates two image tags:

```text
latest
sha-shortcommit
```

## Screenshots To Take

```text
1. GitHub Actions workflow passed
2. Docker Hub image page
3. latest tag on Docker Hub
4. sha tag on Docker Hub
5. Local app running at localhost:5001
```
