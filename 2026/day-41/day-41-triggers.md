### Trigger on Pull Request

```
name: Print PR Branches
on:
  pull_request:
    types: [opened, synchronize, reopened] # Triggers when PR is opened, updated, or reopened

jobs:
  print-branches:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code (optional, but good practice)
        uses: actions/checkout@v4

      - name: Print Source (Head) and Target (Base) Branches
        run: |
          echo "Source Branch (Head): ${{ github.head_ref }}"
          echo "Target Branch (Base): ${{ github.event.pull_request.base.ref }}"
        shell: bash
```
<img width="1009" height="637" alt="prchek" src="https://github.com/user-attachments/assets/23c42904-1aea-4825-8561-85fe1b5176c0" />

### Scheduled Trigger

```
name: Schedule_Trigger
on:
    schedule:
        - cron:  '0 0 * * *'

jobs:
    run-task:
      runs-on: ubuntu-latest
      steps:
          - name: checkout-code
            uses: actions/checkout@v4
            
          - name: Execute scheduled task
            run: echo ""This job runs daily at midnight UTC""
```

<img width="1024" height="632" alt="schedule" src="https://github.com/user-attachments/assets/5d641bf6-ecb2-44de-b6ca-9bc2cf20b082" />

### Manual Trigger

```
name: Manual Environment Deploy

on:
  workflow_dispatch:
    inputs:
      environment_name:
        description: 'Environment to deploy to (staging/production)'
        required: true
        type: choice
        options:
          - staging
          - production
        default: 'staging'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Print the input environment name
        run: |
          echo "The selected environment is: ${{ github.event.inputs.environment_name }}"name: Manual Environment Deploy

on:
  workflow_dispatch:
    inputs:
      environment_name:
        description: 'Environment to deploy to (staging/production)'
        required: true
        type: choice
        options:
          - staging
          - production
        default: 'staging'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Print the input environment name
        run: |
          echo "The selected environment is: ${{ github.event.inputs.environment_name }}"name: Manual Environment Deploy

on:
  workflow_dispatch:
    inputs:
      environment_name:
        description: 'Environment to deploy to (staging/production)'
        required: true
        type: choice
        options:
          - staging
          - production
        default: 'staging'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Print the input environment name
        run: |
          echo "The selected environment is: ${{ github.event.inputs.environment_name }}"
```
<img width="31" height="18" alt="manual1" src="https://github.com/user-attachments/assets/c822e60d-2029-40fb-951a-eb83a7ddd6f1" />
<img width="1024" height="624" alt="manual2" src="https://github.com/user-attachments/assets/1cc41e98-3d80-49b4-87ba-41f198fd834d" />

###  Matrix Builds

```
name: Matrix
on:
    push:
        branches: [main]
jobs:
    validate:
        runs-on: ubuntu-latest
        strategy:
          fail-fast: true
          matrix: 
              python-version: [3.11, 3.12, 3.13]
        steps:
         - name: checkout code
           uses: actions/checkout@v4
           
         - name: setup python
           uses: actions/setup-python@v5
           with: 
             python-version: ${{ matrix.python-version }}

         - name: Print Python-Version
           run: python --version![Uploading matrix.PNG…]()

```
<img width="1014" height="611" alt="image" src="https://github.com/user-attachments/assets/c51e87b3-68be-4ca0-9030-64a2c46a4c8f" />
