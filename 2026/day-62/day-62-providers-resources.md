Task 1: Explore the AWS Provider
- Create a new project directory: terraform-aws-infra
- Write a providers.tf file:
  - Define the terraform block with required_providers pinning the AWS provider to version ~> 5.0
  - Define the provider "aws" block with your region
- Run terraform init and check the output -- what version was installed?
  <img width="985" height="442" alt="image" src="https://github.com/user-attachments/assets/25c112f0-ea43-4038-9d03-7cf40cb0d3e6" />

- Document: What does ~> 5.0 mean? How is it different from >= 5.0 and = 5.0.0?
  - It means Terraform can use any version starting from 5.0 up to (but not including) 6.0, allowing safe minor and patch updates.
  - ~> 5.0 allows safe updates within version 5.x
  - >= 5.0 allows any higher version, including major upgrades (riskier)
  - = 5.0.0 locks to exactly one version with no updates

 
Task 2: Build a VPC from Scratch
- Create a main.tf and define these resources one by one:
- aws_vpc -- CIDR block 10.0.0.0/16, tag it "TerraWeek-VPC"
- aws_subnet -- CIDR block 10.0.1.0/24, reference the VPC ID from step 1, enable public IP on launch, tag it "TerraWeek-Public-Subnet"
- aws_internet_gateway -- attach it to the VPC
- aws_route_table -- create it in the VPC, add a route for 0.0.0.0/0 pointing to the internet gateway
- aws_route_table_association -- associate the route table with the subnet
- Run terraform plan -- you should see 5 resources to create.
- Verify: Apply and check the AWS VPC console. Can you see all five resources connected?
  <img width="1141" height="316" alt="image" src="https://github.com/user-attachments/assets/a35edf54-6977-4297-b1ed-a8f630527cdc" />
  <img width="1467" height="482" alt="image" src="https://github.com/user-attachments/assets/7b7ed002-6d36-40f0-905b-5b5aeabdafc5" />


Task 3: Understand Implicit Dependencies
- How does Terraform know to create the VPC before the subnet?
  Terraform builds a dependency graph by analyzing references in the code. When a resource (like subnet) references another resource's attribute (like VPC ID), Terraform automatically understands the order and creates the VPC before the subnet.

- What would happen if you tried to create the subnet before the VPC existed?
  If Terraform tried to create the subnet before the VPC existed, AWS would return an error because the subnet requires a valid VPC ID. The operation would fail with a "VPC not found" or similar error.
  
- Find all implicit dependencies in your config and list them
    - aws_subnet.public_subnet → depends on → aws_vpc.main_vpc
    - aws_internet_gateway.igw → depends on → aws_vpc.main_vpc
    - aws_route_table.public_rt → depends on → aws_vpc.main_vpc
    - aws_route_table.public_rt → depends on → aws_internet_gateway.igw
    - aws_route_table_association.public_assoc → depends on → aws_subnet.public_subnet
    - aws_route_table_association.public_assoc → depends on → aws_route_table.public_rt

Task 4: Add a Security Group and EC2 Instance
Add to your config:
- aws_security_group in the VPC:
  - Ingress rule: allow SSH (port 22) from 0.0.0.0/0
  - Ingress rule: allow HTTP (port 80) from 0.0.0.0/0
  - Egress rule: allow all outbound traffic
  - Tag: "TerraWeek-SG"

- aws_instance in the subnet:
  - Use Amazon Linux 2 AMI for your region
  - Instance type: t2.micro
  - Associate the security group
  - Set associate_public_ip_address = true
  - Tag: "TerraWeek-Server"
<img width="965" height="182" alt="image" src="https://github.com/user-attachments/assets/1c72923c-544e-4c17-8e4d-dee8eb489094" />


Task 5: Explicit Dependencies with depends_on
Sometimes Terraform cannot detect a dependency automatically.
 - Add a second aws_s3_bucket resource for application logs
 - Add depends_on = [aws_instance.main] to the S3 bucket -- even though there is no direct reference, you want the bucket created only after the instance
 - Run terraform plan and observe the order
   
- Now visualize the entire dependency tree: terraform graph | dot -Tpng > graph.png
- If you don't have dot (Graphviz) installed, use: terraform graph
- and paste the output into an online Graphviz viewer.
  <img width="1852" height="600" alt="image" src="https://github.com/user-attachments/assets/5b9876d3-4269-4988-afae-1a348c893373" />
  
- Document: When would you use depends_on in real projects? Give two examples.
  We use depends_on when Terraform cannot automatically detect a dependency between resources, but you still need to enforce a specific creation order.
  Example 1: When an EC2 instance must be fully created and configured before creating an S3 bucket used for application logs or backups.
  Example 2: When an application server depends on a database being fully created and initialized, but there is no direct reference in the Terraform code.

Task 6: Lifecycle Rules and Destroy
  <img width="1027" height="495" alt="image" src="https://github.com/user-attachments/assets/5272710b-998c-467e-9ed6-b72ffc7caff0" />





