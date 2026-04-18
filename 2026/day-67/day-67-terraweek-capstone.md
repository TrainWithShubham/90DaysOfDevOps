Task 1: Learn Terraform Workspaces
Before building the project, understand workspaces: mkdir terraweek-capstone && cd terraweek-capstone and terraform init
# See current workspace
# Create new workspaces
# List all workspaces
# Switch between them
  <img width="902" height="561" alt="image" src="https://github.com/user-attachments/assets/66c210b5-9bfe-494a-8eb6-b6a50d8f82de" />
  

- What does terraform.workspace return inside a config?
  terraform.workspace returns the name of the currently selected workspace (e.g., dev, staging, prod).
  
- Where does each workspace store its state file?
  Each workspace stores its own separate state file.
  
- How is this different from using separate directories per environment?
  Workspaces = same code, different state
  Directories = separate code, separate state


Task 2: Set Up the Project Structure
  <img width="1457" height="307" alt="image" src="https://github.com/user-attachments/assets/23e3274b-ece5-4300-9253-cecfb8bb922c" />


Task 3: Build the Custom Modules
Create three focused modules:
- Module 1: modules/vpc/
- Module 2: modules/security-group/
- Module 3: modules/ec2-instance/
- Write and validate each module: terraform validate
  <img width="1013" height="498" alt="image" src="https://github.com/user-attachments/assets/44c97034-5838-470a-adc3-5e0ecba895a9" />


Task 4: Wire It All Together with Workspace-Aware Config
- In the root module, use terraform.workspace to drive environment-specific behavior: locals.tf, variables.tf, 
- main.tf -- call all three modules, passing workspace-aware names and variables.
- Environment-specific tfvars: dev.tfvars, staging.tfvars, prod.tfvars
- Notice: dev allows SSH, prod does not. Different CIDRs prevent overlap. Instance types scale up per environment.
  <img width="1461" height="271" alt="image" src="https://github.com/user-attachments/assets/b24618dd-ca14-4fc8-961a-6418ea5599f5" />


Task 5: Deploy All Three Environments
- Deploy each environment using its workspace and tfvars file: Dev, Staging, Prod
- After all three are deployed and verify
- Go to the AWS console and verify
- Verify: Are all three environments completely isolated from each other?
  <img width="1085" height="422" alt="image" src="https://github.com/user-attachments/assets/d5bc23d6-d20a-48f0-b061-d536afc4e268" />
  <img width="1286" height="127" alt="image" src="https://github.com/user-attachments/assets/5e478094-ef93-40ff-9e43-f2aa8447f1eb" />







