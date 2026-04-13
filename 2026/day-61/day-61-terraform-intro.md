Task 1: Understand Infrastructure as Code
- What is Infrastructure as Code (IaC)? Why does it matter in DevOps?
  Infrastructure as Code (IaC) is the managing and provisioning of IT infrastructure (servers, networks, databases) using machine-readable definition files rather than manual configuration.
  IaC is important because
  - Consistency — same setup every time
  - Automation — no manual work
  - Version control — track changes using Git
  - Faster deployments — spin up infra in minutes
  - Collaboration — teams can review infra like code
    
- What problems does IaC solve compared to manually creating resources in the AWS console?
  Before automation when we have application and wanted to deploy on server then we need to 
    •	setup servers, 
    •	configure networking 
    •	Install and configure necessary software like DB or language like java, .net
  We do all these thing to prepare the server in order to make our application able to run on servers. 
  And all these thing would be done manually by system administrator. So we have high resource cost, more effort and time and more chance for human error.  And after that you have maintenance cost.  
  To overcome this issue and to automate this process Infrastructure as Code came into picture. IaC helps to automate all these task end to end instead of doing manually by using different tools like ansible, Terraform, puppet etc.

- How is Terraform different from AWS CloudFormation, Ansible, and Pulumi?
  Terraform is a declarative, cloud-agnostic tool that works across multiple providers, while AWS CloudFormation is AWS-specific. Ansible is mainly used for configuration (imperative), and Pulumi uses programming languages instead of Terraform’s HCL for defining infrastructure.
  
- What does it mean that Terraform is "declarative" and "cloud-agnostic"?
  Terraform being declarative means you define the desired end state of your infrastructure (what you want), and Terraform figures out how to create and manage it. Being cloud-agnostic means it works across multiple cloud providers (like AWS, Azure, GCP), so you’re not tied to a single platform.
  

Task 2: Install Terraform and Configure AWS
- Install Terraform and Verify
- Install and configure the AWS CLI
- Verify AWS access
  <img width="1400" height="471" alt="61 2" src="https://github.com/user-attachments/assets/2f124fd1-d98b-4ce7-98fa-447ee05b0018" />
  

Task 3: Your First Terraform Config -- Create an S3 Bucket
- Create a project directory and write your first Terraform config:
  - mkdir terraform-basics && cd terraform-basics
  - Create a file called main.tf with:
- A terraform block with required_providers specifying the aws provider
- A provider "aws" block with your region
- A resource "aws_s3_bucket" that creates a bucket with a globally unique name
- Run the Terraform lifecycle:
  - terraform init      # Download the AWS provider
  - terraform plan      # Preview what will be created
  - terraform apply     # Create the bucket (type 'yes' to confirm)
- Go to the AWS S3 console and verify your bucket exists.
<img width="1040" height="487" alt="image" src="https://github.com/user-attachments/assets/f735a806-1180-4abd-84e0-2c07e23cf568" />


Task 4: Add an EC2 Instance
- In the same main.tf, add a resource "aws_instance" using AMI ami-0f5ee92e2d63afc18 (Amazon Linux 2 in ap-south-1 -- use the correct AMI for your region)
- Set instance type to t2.micro and add a tag: Name = "TerraWeek-Day1"
- Go to the AWS EC2 console and verify your instance is running with the correct name tag.
- <img width="898" height="263" alt="image" src="https://github.com/user-attachments/assets/10a71326-5b16-4744-9d1a-1d7f0749282a" />





