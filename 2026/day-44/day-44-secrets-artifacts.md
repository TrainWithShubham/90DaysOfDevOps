Day 44 - Secrets, Artifacts and Real Tests in CI

## Objective

In this lab, I learned how to use GitHub Actions for real CI work. I practiced storing secrets safely, using secrets as environment variables, uploading and downloading artifacts, running a real test script, and using cache to speed up dependency installation.

## Repository Secrets

I created repository secrets in GitHub from:

`Settings > Secrets and variables > Actions > New repository secret`

Secrets created:

- `MY_SECRET_MESSAGE`
- `DOCKER_USERNAME`
- `DOCKER_TOKEN`

I used `MY_SECRET_MESSAGE` in a workflow without printing the actual secret value.

The workflow printed:

```text
The secret is set: true
```

When I tried to print the secret directly, GitHub masked it in the logs as:

```text
***
```

## Why Secrets Should Not Be Printed

Secrets should never be printed in CI logs because logs can be viewed by other people, saved for later, or shared in screenshots. Even though GitHub masks secrets automatically, it is safer to avoid exposing secret values in any command output.

## Using Secrets as Environment Variables

I passed secrets into workflow steps using environment variables.

Example:

```yaml
env:
  MY_SECRET_MESSAGE: ${{ secrets.MY_SECRET_MESSAGE }}
```

This keeps sensitive values out of the code and allows the workflow to use them securely.

## Docker Secrets

I added these Docker-related secrets for the next lab:

- `DOCKER_USERNAME`
- `DOCKER_TOKEN`

`DOCKER_USERNAME` stores my Docker Hub username.

`DOCKER_TOKEN` stores my Docker Hub personal access token.

I did not hardcode these values in the workflow files.

## Uploading Artifacts

I created a workflow that generated a report file and uploaded it using:

```yaml
uses: actions/upload-artifact@v4
```

The artifact can be downloaded from the GitHub Actions workflow run page.

Screenshot:

```text
Add artifact download screenshot here
```

## Downloading Artifacts Between Jobs

I created another workflow with two jobs:

- Job 1 generated a file and uploaded it as an artifact.
- Job 2 downloaded the artifact and printed its contents.

This showed how files can be passed between jobs in a CI pipeline.

## When Artifacts Are Useful

Artifacts are useful in real pipelines for saving:

- Test reports
- Build outputs
- Log files
- Coverage reports
- Screenshots
- Compiled packages

They are helpful when one job creates a file and another job needs to use it.

## Running Real Tests in CI

I added a Python test script in the repo:

```text
scripts/check_day_44.py
```

The workflow checks out the code, sets up Python, and runs the script.

If the script exits with a non-zero code, the CI pipeline fails. After fixing the script, the workflow passes successfully.

Screenshot:

```text
Add passing test run screenshot here
```

## Caching

I used `actions/cache@v4` to cache Python pip dependencies.

The cache path was:

```text
~/.cache/pip
```

The cache is stored by GitHub Actions and reused in future workflow runs when the cache key matches. This can make dependency installation faster.

## What I Learned

In this lab, I learned that GitHub Actions can do more than run simple commands. It can securely use secrets, store workflow output files as artifacts, pass files between jobs, run real tests, and use caching to improve performance.

This was my first step toward building a more realistic CI pipeline.
