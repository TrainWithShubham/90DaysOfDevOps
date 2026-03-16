#Multi-Jobs-Works 

```
name: Sequential Workflow Example

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      - name: Build the application
        run: echo "Building..."

  test:
    needs: build # The 'test' job will run only after the 'build' job completes
    runs-on: ubuntu-latest
    steps:
      - name: Run tests
        run: echo "Testing..."

  deploy:
    needs: [build, test] # The 'deploy' job will run only after both 'build' and 'test' jobs complete
    runs-on: ubuntu-latest
    steps:
      - name: Deploy the application
        run: echo "Deploying..."

```



