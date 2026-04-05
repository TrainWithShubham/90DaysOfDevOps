# Day 61 -- Introduction to Terraform and Your First AWS Infrastructure

## Task 1: Understand Infrastructure as Code

1. What is Infrastructure as Code (IaC)? Why does it matter in DevOps?  
Ans: Iac is the practice of writing scripts of configaration file to automatically create and mamage IT infrastructure.
It matters in devops because :  
                              1. Faster Environment setup  
                              2. Enable True Automation  
                              3. Consistency Environments  
                              4. Version Control for Infrastruture  
                              5. Reliability and human error reduced  


2. What problems does IaC solve compared to manually creating resources in the AWS console?
Ans: There are multiple issues with console like
                            1. Human Error
                            2. No Consistency across Environemnts : In this created dev, qa, prod but they are sliglty different so break in prod that issues resolved by IAC
                            3. No Version Control
                            4. Slow & Time Consuming

3. How is Terraform different from AWS CloudFormation, Ansible, and Pulumi?
Ans: Terraform is multi cloud infrastructure provisioning tool, Cloud formation is native IAC, Ansible is use mainly for configuration management, pulumi is a modern IAC tool which uses programming like python or Javascript.

4. What does it mean that Terraform is "declarative" and "cloud-agnostic"?
Ans: Terraform is declearative means everything written in a file and then created everything. Cloud-agonistic means teraaform supported multi cloud. It can be work with Aws, Azure ,Gcp and  many cloud 
provider.

## Task 2: Install Terraform and Configure AWS

<img width="1103" height="519" alt="image" src="https://github.com/user-attachments/assets/e20a8d17-d7f5-4243-a77b-7e1fe7919f1a" />

## Task 3: Your First Terraform Config -- Create an S3 Bucket  
<img width="1051" height="678" alt="image" src="https://github.com/user-attachments/assets/b682fea9-ccb0-4f36-94f9-41d493c1c477" />  
<img width="1064" height="912" alt="image" src="https://github.com/user-attachments/assets/57fc4658-e3cf-4836-b9a6-a39ebd3d265e" />  
<img width="1079" height="774" alt="image" src="https://github.com/user-attachments/assets/e5a34496-cd4c-4105-8bdb-d794713796a0" />  
<img width="868" height="658" alt="image" src="https://github.com/user-attachments/assets/761ad912-a97b-4f3b-a59d-914a41004a96" />
provider "aws" {
  region = "ap-south-1"
}
resource "aws_s3_bucket" "s3-bucket" {
  bucket = "shuvam-bhaiyas-bucket"
}  

## Task 4: Add an EC2 Instance
<img width="1423" height="606" alt="image" src="https://github.com/user-attachments/assets/55ea0cd3-add4-4515-93e5-26b2e50d8384" />  
<img width="1920" height="830" alt="image" src="https://github.com/user-attachments/assets/5cd98d3a-5b22-4d5f-8e1f-7fdeb1f8b453" />  

How does Terraform know the S3 bucket already exists and only the EC2 instance needs to be created?
Ans: Terraform has terraform.tfstate file present when we clicked terraform apply data present in terraform.tfstate from there terraform knows that it already created.

## Task 5: Understand the State File

1. terraform show : Its shows the terraform state file
2. terraform state list : it shows how many state inside statefile
3. terraform state show aws_s3_bucket.<name> : it shows detailed about aws s3 bucket from state file
4. terraform state show aws_instance.<name>: it shows detailed about aws ec2 instance

- Answer these questions in your notes:
     - What information does the state file store about each resource?  
       ans: State file store the metadata , Resource Attribute, Dependency attribute, Terraform internal data.
     - Why should you never manually edit the state file?  
       Ans: Because Terraform rely only one state file if you change the statefile it will lead Infrastructure mismatch, Resource corruption, Accidental deletion/recreation.
     - Why should the state file not be committed to Git?  
       Ans: Beacuase it contains sensitive data like access key, Password, Db connection and secrets. It can be cause team conflict. Whenever we changed this code in terraform new tf state file modified so always run the git and it will messy . That reason we couldnot change this file.

## Task 6: Modify, Plan, and Destroy
Understand the meaning of ~ + - and also destroyed the s3 and ec2.






