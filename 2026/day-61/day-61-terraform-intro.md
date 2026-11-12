# Day 61: Introduction to Terraform and Your First AWS Infrastructure

## Challenge Tasks

### Task 1: Understand Infrastructure as Code
**1. What is Infrastructure as Code (IaC)? Why does it matter in DevOps?**
Infrastructure as Code (IaC) is the process of managing and provisioning computing infrastructure through machine-readable definition files, rather than interactive configuration tools or physical hardware setup. In DevOps, it matters because it enables automation, infrastructure version control, consistency across environments, and faster deployment cycles.

**2. What problems does IaC solve compared to manually creating resources in the AWS console?**
Manual creation (ClickOps) leads to human errors, configuration drift (inconsistencies between staging and production), and lack of auditability. IaC solves this by providing a single source of truth, enabling automated testing, and allowing teams to reliably recreate environments in minutes.

**3. How is Terraform different from AWS CloudFormation, Ansible, and Pulumi?**
- **CloudFormation:** Strictly tied to AWS, whereas Terraform is cloud-agnostic.
- **Ansible:** Primarily a configuration management tool (configuring OS/software inside a server), whereas Terraform is an infrastructure provisioning tool (creating the server itself).
- **Pulumi:** Uses general-purpose programming languages (Python, Go), whereas Terraform uses its own declarative HashiCorp Configuration Language (HCL).

**4. What does it mean that Terraform is "declarative" and "cloud-agnostic"?**
- **Declarative:** You define the desired end-state of your infrastructure, and Terraform determines the logic and steps to achieve it.
- **Cloud-Agnostic:** Using a unified workflow, Terraform can manage resources across multiple cloud providers (AWS, Azure, GCP) via different provider plugins.

### Task 2: Install Terraform and Configure AWS
- **Terraform Installation:** Installed latest Terraform via Homebrew on macOS (`v1.15.x`).
- **AWS CLI:** Installed AWS CLI v2 via package installer and configured IAM User credentials (`terraform-admin`) for the `ap-south-1` region.
- Verified connection using `aws sts get-caller-identity`.

### Task 3: Your First Terraform Config -- Create an S3 Bucket
Created `main.tf` and defined the AWS provider and an `aws_s3_bucket` resource.
- **Bucket Name:** `terraweek-rashid-khan-2026-unique-bucket`
- **Commands Executed:** `terraform init`, `terraform plan`, `terraform apply`

**Q: What did terraform init download? What does the .terraform/ directory contain?**
**Answer:** The `terraform init` command downloaded the AWS provider plugin (specifically `hashicorp/aws v5.100.0`) required to interact with AWS APIs. The `.terraform/` directory contains these downloaded provider binaries and modules, acting as a local cache for the project.

### Task 4: Add an EC2 Instance
Added an `aws_instance` block to `main.tf`.
- **AMI:** `ami-0f5ee92e2d63afc18` (Amazon Linux 2)
- **Instance Type:** `t2.micro`
- **Tag:** `Name = "TerraWeek-Day1"`

**Q: How does Terraform know the S3 bucket already exists and only the EC2 instance needs to be created?**
**Answer:** Terraform tracks the real-world infrastructure in its state file (`terraform.tfstate`). During `terraform plan`, it compared the local code against this state file and the actual AWS environment. It recognized the S3 bucket was already present in the state and unmodified in the code, so it only planned the creation of the newly added EC2 instance.

### Task 5: Understand the State File
Inspected the state file using CLI commands: `terraform show`, `terraform state list`, and `terraform state show`.

**1. What information does the state file store about each resource?**
It stores a complete map of the resources deployed, including metadata, unique cloud identifiers (like the EC2 Instance ID `i-0f47a1c3aa7951a19`), private/public IP addresses, and resource dependencies.

**2. Why should you never manually edit the state file?**
The state file is a strictly formatted JSON file. Manually editing it can corrupt the JSON structure or break the synchronization between Terraform and AWS, causing Terraform to lose track of resources, create duplicates, or fail execution.

**3. Why should the state file not be committed to Git?**
The state file stores infrastructure data in plain text, which can include highly sensitive information like database passwords, API tokens, and private keys. Committing this to a Git repository exposes your cloud environment to severe security risks.

### Task 6: Modify, Plan, and Destroy
Modified the EC2 instance tag from `TerraWeek-Day1` to `TerraWeek-Modified`.

**Q: What do the ~, +, and - symbols mean in terraform plan?**
- `+` means Create (resource will be added).
- `-` means Destroy (resource will be removed).
- `~` means Update in-place (resource properties will be modified without recreation).
- `-/+` means Replace (resource will be destroyed and recreated).

**Q: Is this an in-place update or a destroy-and-recreate?**
**Answer:** Because only a tag was changed, it was an **in-place update** (`~`).

Finally, executed `terraform destroy` to tear down all resources safely.

---

## Documentation Summary

- **IaC Explanation:** Infrastructure as Code (IaC) replaces manual configuration with machine-readable definition files. It allows developers to version-control infrastructure, automate deployments, and eliminate configuration drift, providing a consistent, auditable, and scalable cloud environment.
- **Execution Screenshots:**
  - [Insert Screenshot: `terraform apply` creating S3 and EC2]
  - [Insert Screenshot: S3 and EC2 visible in AWS Console]
- **Command Reference:**
  - `terraform init`: Initializes the directory and downloads providers.
  - `terraform plan`: Shows the execution plan of changes to be made.
  - `terraform apply`: Applies the changes to reach the desired state.
  - `terraform destroy`: Deletes all managed infrastructure.
  - `terraform show`: Displays a human-readable view of the current state.
  - `terraform state list`: Lists all resources currently tracked by Terraform.
- **State File Importance:** The state file maps the configuration to the real world. It optimizes performance by preventing unnecessary API calls and tracks dependencies, but must be secured remotely (not in Git) to protect sensitive data.
