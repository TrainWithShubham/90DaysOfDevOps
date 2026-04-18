Task 1: Extract Variables
Create a variables.tf file with input variables for:
- region (string, default: your preferred region)
- vpc_cidr (string, default: "10.0.0.0/16")
- subnet_cidr (string, default: "10.0.1.0/24")
- instance_type (string, default: "t2.micro")
- project_name (string, no default -- force the user to provide it)
- environment (string, default: "dev")
- allowed_ports (list of numbers, default: [22, 80, 443])
- extra_tags (map of strings, default: {})
- Replace every hardcoded value in main.tf with var.<name> references
Run terraform plan -- it should prompt you for project_name since it has no default
Document: What are the five variable types in Terraform? (string, number, bool, list, map)
  Terraform supports five main variable types: string (for text values), number (for numeric values), bool (for true/false values), list (for ordered collections of values), and map (for key-value pairs).
<img width="632" height="227" alt="image" src="https://github.com/user-attachments/assets/29c65b8e-0f70-4875-bdde-33a276fd5165" />

Task 2: Variable Files and Precedence
Write the variable precedence order from lowest to highest priority.
  1. Default values in variables.tf
  2. Environment variables (TF_VAR_*)
  3. terraform.tfvars (auto-loaded)
  4. *.tfvars files passed with -var-file
  5. CLI variables (-var)

Task 3: Add Outputs
Create an outputs.tf file with outputs for:
- vpc_id -- the VPC ID
- subnet_id -- the public subnet ID
- instance_id -- the EC2 instance ID
- instance_public_ip -- the public IP of the EC2 instance
- instance_public_dns -- the public DNS name
- security_group_id -- the security group ID
Apply your config and verify the outputs are printed at the end:
<img width="1122" height="491" alt="image" src="https://github.com/user-attachments/assets/204de653-9f23-4e13-8ae6-a4c68383c98e" />
<img width="953" height="485" alt="image" src="https://github.com/user-attachments/assets/7401e3d4-2c19-4ece-b8fd-cfc06a0257bc" />


Task 4: Use Data Sources
Stop hardcoding the AMI ID. Use a data source to fetch it dynamically.
- Add a data "aws_ami" block that:
  - Filters for Amazon Linux 2 images
  - Filters for hvm virtualization and gp2 root device
  - Uses owners = ["amazon"]
  - Sets most_recent = true
- Replace the hardcoded AMI in your aws_instance with data.aws_ami.amazon_linux.id
- Add a data "aws_availability_zones" block to fetch available AZs in your region
- Use the first AZ in your subnet: data.aws_availability_zones.available.names[0]
- Apply and verify -- your config now works in any region without changing the AMI.
Document: What is the difference between a resource and a data source?
  A resource is used to create and manage infrastructure in Terraform, such as EC2 instances or VPCs. A data source is used to fetch and read existing information from the provider, such as the latest AMI or available availability zones, without creating anything.
<img width="1128" height="681" alt="image" src="https://github.com/user-attachments/assets/6c56f392-71cb-44fd-887c-3c7aed51ee7a" />


Task 5: Use Locals for Dynamic Values
- Add a locals block
- Replace all Name tags with local.name_prefix:
  - VPC: "${local.name_prefix}-vpc"
  - Subnet: "${local.name_prefix}-subnet"
  - Instance: "${local.name_prefix}-server"
- Merge common tags with resource-specific tags:
- Apply and check the tags in the AWS console -- every resource should have consistent tagging.
<img width="1542" height="658" alt="image" src="https://github.com/user-attachments/assets/f8918645-7a3c-4afb-a8ef-7f6126fad0cd" />

Task 6: Built-in Functions and Conditional Expressions
- Practice these in terraform console: String functions, Collection functions, Networking function
- Document: Pick five functions you find most useful and explain what each does.
  <img width="637" height="425" alt="63 6" src="https://github.com/user-attachments/assets/1b68e0a6-e2ba-4764-b7fb-ab303ed136be" />







