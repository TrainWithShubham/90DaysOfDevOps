# Day 47 - Python Tests

Create this workflow file:

```text
.github/workflows/day-47-python-tests.yml
```

Paste this:

```yaml
name: Day 47 - Python Tests

on:
  push:
    branches:
      - main
      - DevOps-practice
  workflow_dispatch:

jobs:
  python-tests:
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

      - name: Run tests
        run: pytest scripts/test_app.py
```

## Simple Explanation

This workflow runs Python tests in GitHub Actions.

It installs the app dependencies and runs:

```text
pytest scripts/test_app.py
```

If any test fails, the workflow fails.

## Screenshots To Take

```text
1. Day 47 Python Tests workflow passed
2. Logs showing pytest passed
```

