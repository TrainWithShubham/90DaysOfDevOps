Task 1: Understand Module Structure
- A Terraform module is just a directory with .tf files. Create this structure:
- Create all the directories and empty files. This is the standard layout every Terraform project follows.
- Document: What is the difference between a "root module" and a "child module"?
  The root module is the main working directory where Terraform commands are executed and it orchestrates the overall infrastructure. A child module is a reusable component defined in a separate directory that is called by the root module to create specific resources like EC2 instances or security groups.
  <img width="1152" height="332" alt="image" src="https://github.com/user-attachments/assets/9d04ae43-56cb-4c48-94a4-7780b68e09bb" />

Task 2: Build a Custom EC2 Module
- Create modules/ec2-instance/: variables.tf -- define inputs:
- main.tf -- define the resource: aws_instance using all the variables
- outputs.tf -- expose: instance_id, public_ip, private_ip
<img width="1187" height="215" alt="image" src="https://github.com/user-attachments/assets/1128d7b4-cc5d-4a02-9c93-7a311116932d" />

Task 3: Build a Custom Security Group Module
Create modules/security-group/:
- variables.tf -- define inputs:
- main.tf -- define the resource:
- outputs.tf -- expose: sg_id
This is your first time using a dynamic block -- it loops over a list to generate repeated nested blocks.
<img width="1181" height="201" alt="image" src="https://github.com/user-attachments/assets/e9f296a4-325f-49d3-ae58-8e574ab4eb82" />


Task 4: Call Your Modules from Root
In the root main.tf, wire everything together:
- Create a VPC and subnet directly (or reuse your Day 62 config)
- Call the security group module:
- Call the EC2 module -- deploy two instances with different names using the same module:
- Add root outputs that reference module outputs:
- Apply: terraform init, terraform plan and terraform apply
- Verify: Two EC2 instances running, same security group, different names. Check the AWS console.
  <img width="788" height="185" alt="image" src="https://github.com/user-attachments/assets/cda7b293-ad71-46d7-aea9-2b840f67b9c5" />


Task 5: Use a Public Registry Module
Instead of building your own VPC from scratch, use the official module from the Terraform Registry.
- Replace your hand-written VPC resources
- Update your EC2 and SG module calls to reference module.vpc.vpc_id and module.vpc.public_subnets[0]
- Run terraform init, terraform plan, terraform apply,
- Compare: how many resources did the VPC module create vs your hand-written VPC from Day 62?
- Document: Where does Terraform download registry modules to? Check .terraform/modules/.
  <img width="801" height="193" alt="image" src="https://github.com/user-attachments/assets/78fdeafe-db4f-4651-a943-14723cde0671" />


Task 6: Module Versioning and Best Practices
- Pin your registry module version explicitly:
  - version = "5.1.0" -- exact version
  - version = "~> 5.0" -- any 5.x version
  - version = ">= 5.0, < 6.0" -- range
- Run terraform init -upgrade to check for newer versions
- Check the state to see how modules appear:
- Destroy everything: terraform destroy
- Document: Write down five module best practices:
- Always pin versions for registry modules
  - Keep modules focused -- one concern per module
  - Use variables for everything, hardcode nothing
  - Always define outputs so callers can reference resources
<img width="585" height="537" alt="image" src="https://github.com/user-attachments/assets/23c061c3-e654-424f-91ed-014cf12f10ab" />









