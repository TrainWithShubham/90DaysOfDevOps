# Day 61 – Introduction to Terraform and Your First AWS Infrastructure

## What is Infrastructure as Code (IaC)?

IaC is the practice of managing and provisioning infrastructure — servers, databases, networks, and load balancers — using code instead of doing it manually through a console or UI.

In DevOps it matters because:

→ **Repeatability** — the same infrastructure can be created multiple times with identical configuration across environments
→ **Speed** — automated infrastructure creation reduces time to market
→ **Versioning** — infrastructure code lives in Git with full history and rollback capability
→ **Review before apply** — changes can be inspected before being applied, catching human errors early
→ **Automation** — the entire infrastructure lifecycle can be plugged into a CI/CD pipeline

---

## Problems IaC Solves vs Manual Console Work

→ **Inconsistency** — two people following the same steps manually produce slightly different results. IaC gives identical output every time.

→ **No tracking** — the AWS console has no history of who changed what and when. IaC changes go through Git — every change has a commit, author, and timestamp.

→ **Poor scalability** — creating 20 EC2 instances manually is slow and error-prone. With IaC you change one number and run the code.

→ **Weak recoverability** — if infrastructure breaks and was created manually, rebuilding depends on memory. With IaC, the code is the documentation — run it again and infrastructure is restored exactly as it was.

→ **Environment drift** — manually created dev, staging, and prod environments drift apart over time. IaC ensures all environments are created from the same code.

---

## Terraform vs Other IaC Tools

→ **CloudFormation** — AWS-only. Works well within AWS but cannot provision resources outside it. Terraform is cloud-agnostic and works across any provider.

→ **Ansible** — a configuration management tool. It installs software, manages files, and configures servers that already exist. Terraform provisions the infrastructure itself. Terraform creates the server, Ansible configures what runs on it. They are often used together.

→ **Pulumi** — closest to Terraform in purpose. Both provision infrastructure as code. Pulumi uses real programming languages like Python, TypeScript, or Go. Terraform uses HCL (HashiCorp Configuration Language) which is simpler but less flexible for complex logic.

---

## Declarative and Cloud-Agnostic

**Declarative** — you define the end state you want, not the steps to get there. You do not say "first create a VPC, then a subnet, then attach a gateway." You declare what you need and Terraform figures out the correct order and steps on its own. The opposite is imperative (like shell scripts) where every step is written in sequence manually.

**Cloud-agnostic** — Terraform is not tied to any single cloud provider. The same workflow of write → plan → apply works on AWS, Azure, GCP, or any other provider. You simply swap the provider block and the mental model stays the same.

---

## Installation

~~~bash
# Linux (amd64)
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y

# Verify
terraform version
~~~

---

## AWS CLI Configuration

~~~bash
aws configure
# Enter: Access Key ID, Secret Access Key, region (ap-south-1), output format (json)

# Verify AWS access
aws sts get-caller-identity
~~~

---

## Terraform Configuration — main.tf

~~~hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "shiv-devops-terraform-practice-2026"

  tags = {
    Name        = "shiv-devops-terraform-practice-2026"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"

  tags = {
    Name      = "TerraWeek-Day1"
    ManagedBy = "Terraform"
  }
}
~~~

---

## Terraform Core Commands

~~~bash
terraform init        # Download provider plugins into .terraform/ directory
terraform validate    # Check for syntax errors without connecting to AWS
terraform fmt         # Auto-format .tf files
terraform plan        # Preview what will be created, changed, or destroyed
terraform apply       # Apply the changes (type yes to confirm)
terraform destroy     # Destroy all resources managed by Terraform
~~~

---

## The .terraform/ Directory

Created when `terraform init` is run. Contains:

→ **providers/** — provider plugin binaries are downloaded here. The AWS provider binary that talks to the AWS API lives in this folder.

> Always add `.terraform/` to `.gitignore` — it contains large binaries and is machine-specific. Anyone cloning the repo just runs `terraform init` to get it fresh.

---

## How Terraform Knows What Already Exists

Terraform uses the **state file** (`terraform.tfstate`) to track every resource it has created. When you run `terraform plan`, it compares:

~~~
main.tf (desired state)  vs  terraform.tfstate (current state)
~~~

If the S3 bucket already exists in state, Terraform knows not to recreate it. Only the EC2 instance (new in main.tf, not in state) shows as `1 to add`.

---

## Terraform State File

~~~bash
terraform show                               # Human-readable view of current state
terraform state list                         # List all resources Terraform manages
terraform state show aws_s3_bucket.my_bucket # Detailed view of S3 bucket
terraform state show aws_instance.my_ec2     # Detailed view of EC2 instance
~~~

**What the state file stores:**
The complete metadata of every resource — resource ID, ARN, AMI, region, security groups, tags, and every attribute returned by the provider after creation. It is Terraform's memory of what exists in the real world.

**Why never manually edit the state file:**
The state file is Terraform's source of truth. Manual edits cause Terraform's understanding to drift from reality — leading to incorrect plan decisions, accidental resource recreation, or destructive actions on the next apply. Always use `terraform state` commands instead.

**Why not commit the state file to Git:**
The state file contains sensitive data — passwords, SSH keys, secret tokens returned by providers after resource creation. Store state remotely using S3 + DynamoDB locking instead.

---

## Plan Symbols Explained

| Symbol | Meaning |
|---|---|
| `+` | Resource will be created |
| `-` | Resource will be destroyed |
| `~` | Resource will be updated in-place |
| `-/+` | Resource will be destroyed and recreated |

Tag changes are in-place updates (`~`) — no destroy and recreate needed.

---

## .gitignore for Terraform

~~~
.terraform/
*.tfstate
*.tfstate.backup
.terraform.lock.hcl
~~~

---

## Key Takeaways

→ Terraform provisions infrastructure using declarative HCL — you define the end state, Terraform figures out the steps
→ `terraform init` downloads provider plugins, `plan` previews changes, `apply` creates resources, `destroy` removes them
→ The state file is Terraform's source of truth — never edit it manually, never commit it to Git
→ Terraform only changes what is different between `main.tf` and the current state — existing resources are not touched
→ `terraform destroy` removes everything Terraform manages in one command — powerful and irreversible
→ Always run `terraform fmt` and `terraform validate` before committing code
