Task 1: Understand workflow_call
- What is a reusable workflow?
  A reusable workflow is a GitHub Actions workflow that can be called from another workflow.
  Instead of duplicating the same CI/CD logic across multiple workflows, you:
  - Write it once
  - Reuse it anywhere
    
- What is the workflow_call trigger?
  workflow_call is a trigger that defines a reusable workflow, allowing you to call one workflow from another. This reduces duplication and simplifies maintenance by centralizing common CI/CD logic.
  Example:
  on:
    workflow_call:
  
- How is calling a reusable workflow different from using a regular action (uses:)?
  While both use the uses: keyword, calling a reusable workflow is fundamentally different from using a regular action (or composite action) in terms of where they are called and what they can contain.
  Placement in YAML:
  - Reusable Workflows are called at the job level. They cannot be used as a step within a job.
  - Regular Actions are called at the step level within a job.
  Contents and Structure:
  - Reusable Workflows can contain multiple jobs, each with their own runners (runs-on), strategy matrices, and environment settings.
  - Regular Actions (specifically composite actions) can only contain steps and cannot define their own jobs or specify different runners.
  Logging and Visibility:
  - Reusable Workflows provide detailed logs for every individual job and step they contain, making them easier to debug.
  - Regular Actions appear as a single entry in the workflow logs, even if they internally run many steps.
  Secrets and Parameters:
  - Reusable Workflows have native support for passing secrets via the secrets: keyword.
  - Regular Actions (composite) generally require secrets to be passed as standard inputs.
  External Access:
  - Regular Actions can be published to the GitHub Marketplace for public use.
  - Reusable Workflows cannot be published to the Marketplace and are primarily for internal organization use.
 
     
- Where must a reusable workflow file live?
  .github/workflows/


Task 2: Create Your First Reusable Workflow
Create .github/workflows/reusable-build.yml:
- Set the trigger to workflow_call
- Add an inputs: section with:
    - app_name (string, required)
    - environment (string, required, default: staging)
- Add a secrets: section with:
    - docker_token (required)
- Create a job that:
    - Checks out the code
    - Prints Building <app_name> for <environment>
    - Prints Docker token is set: true (never print the actual secret)
<img width="746" height="715" alt="image" src="https://github.com/user-attachments/assets/7bde9c38-4747-417e-bb3c-9c90017502ed" />


Task 3: Create a Caller Workflow
Create .github/workflows/call-build.yml:
- Trigger on push to main
- Add a job that uses your reusable workflow:
  jobs:
    build:
      uses: ./.github/workflows/reusable-build.yml
      with:
        app_name: "my-web-app"
        environment: "production"
      secrets:
        docker_token: ${{ secrets.DOCKER_TOKEN }}
- Push to main and watch it run
Verify: In the Actions tab, do you see the caller triggering the reusable workflow? Click into the job — can you see the inputs printed?
<img width="983" height="817" alt="image" src="https://github.com/user-attachments/assets/cb2e3894-74a4-4cd4-88bd-26c971b97338" />

Task 4: Add Outputs to the Reusable Workflow
Extend reusable-build.yml:
- Add an outputs: section that exposes a build_version value
- Inside the job, generate a version string (e.g., v1.0-<short-sha>) and set it as output
- In your caller workflow, add a second job that:
- Depends on the build job (needs:)
- Reads and prints the build_version output
- Verify: Does the second job print the version from the reusable workflow?
<img width="975" height="490" alt="image" src="https://github.com/user-attachments/assets/1f428d31-5f07-4714-b53a-6932b812953b" />


Task 5: Create a Composite Action
Create a custom composite action in your repo at .github/actions/setup-and-greet/action.yml:
- Define inputs: name and language (default: en)
- Add steps that:
- Print a greeting in the specified language
- Print the current date and runner OS
- Set an output called greeted with value true
- Use the composite action in a new workflow with uses: ./.github/actions/setup-and-greet
Verify: Does your custom action run and print the greeting?
<img width="896" height="818" alt="image" src="https://github.com/user-attachments/assets/a2075395-04b9-4ce5-901f-39b952166d26" />


Task 6: Reusable Workflow vs Composite Action
Feature	Reusable Workflow	Composite Action
Triggered by	workflow_call	uses: in a step
Can contain jobs?	Yes (multiple jobs)	No (only steps)
Can contain multiple steps?	Yes	Yes
Lives where?	.github/workflows/	.github/actions/<action-name>/
Can accept secrets directly?	Yes (via secrets:)	No (must pass via env)
Best for	Full CI/CD pipelines, multi-job workflows	Small reusable logic, step grouping






 




