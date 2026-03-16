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

### ENVIROMENT LEVEL
```
name: Environment Level
on:
  workflow_dispatch: null
  
env:
  APP_NAME: myapp
  
jobs:
  print_env:
    runs-on: ubuntu-latest
    
    env:
      ENVIRONMENT: staging
      
    steps:
      - name: Print all variables
        env:
          VERSION: 1.0.0
        run: |
          echo "App Name: $APP_NAME"
          echo "Environment: $ENVIRONMENT"
          echo "Version: $VERSION"
```




