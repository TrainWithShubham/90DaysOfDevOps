# Day 61 - Introduction to Terraform and My First AWS Infrastructure

## What I Learned

Today I started learning Terraform and Infrastructure as Code (IaC). I
used Terraform with AWS to create an S3 bucket and an EC2 instance. I
also learned how Terraform keeps track of resources using the state
file. Finally, I modified my EC2 instance tag and destroyed the
resources using Terraform.

## Task 1 - Infrastructure as Code (IaC)

### What is Infrastructure as Code?

Infrastructure as Code means creating and managing infrastructure by
writing code instead of creating everything manually in the AWS Console.

For example, instead of manually creating an EC2 instance or S3 bucket,
I can describe them in a Terraform file and Terraform creates them for
me.

IaC is useful in DevOps because infrastructure can be repeated,
reviewed, shared, and automated.

### What problems does IaC solve?

IaC helps us create infrastructure faster, repeat the same setup, reduce
manual mistakes, review changes before applying them, and recreate
environments when needed.

### Terraform vs Other Tools

-   **Terraform:** Mainly used to provision infrastructure and works
    with many cloud providers.
-   **AWS CloudFormation:** Infrastructure as Code mainly for AWS.
-   **Ansible:** Mainly used for configuration management and
    automation.
-   **Pulumi:** Lets us define infrastructure using programming
    languages.

### Declarative and cloud-agnostic

Terraform is **declarative** because I describe the infrastructure I
want, and Terraform decides what actions are needed.

Terraform is **cloud-agnostic** because it can work with different
providers such as AWS, Azure, and Google Cloud.

## Task 2 - Terraform and AWS CLI Setup

I verified Terraform:

``` bash
terraform --version
```

My version was:

``` text
Terraform v1.15.8
on linux_amd64
```

I verified AWS CLI with:

``` bash
aws --version
aws sts get-caller-identity
```

The AWS identity command returned my IAM identity, confirming that my
AWS credentials were working.

## Task 3 - Create an S3 Bucket

I created my project directory:

``` bash
mkdir terraform-basics
cd terraform-basics
```

My `main.tf` contained the AWS provider and S3 bucket:

``` hcl
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ca-central-1"
}

resource "aws_s3_bucket" "day61_bucket_asma" {
  bucket = "asma-terraweek-day61-2026"
}
```

I ran:

``` bash
terraform fmt
terraform init
terraform plan
terraform apply
```

`terraform init` downloaded the AWS provider. In my lab, Terraform
installed `hashicorp/aws v6.60.0`.

The `.terraform/` directory contains downloaded provider files that
Terraform needs to work with AWS.

Terraform also created `.terraform.lock.hcl`, which records the selected
provider versions.

The S3 bucket was created successfully.

## Task 4 - Create an EC2 Instance

I found an Amazon Linux AMI for my AWS region, `ca-central-1`, and added
an EC2 resource:

``` hcl
resource "aws_instance" "day61_ec2" {
  ami           = "ami-0f82f408f5558e47b"
  instance_type = "t2.micro"

  tags = {
    Name = "TerraWeek-Day1"
  }
}
```

Then I ran:

``` bash
terraform fmt
terraform plan
terraform apply
```

Terraform showed:

``` text
Plan: 1 to add, 0 to change, 0 to destroy.
```

Only the EC2 instance needed to be created because Terraform already
knew about the S3 bucket from its state.

## Task 5 - Understanding Terraform State

Terraform uses `terraform.tfstate` to keep track of the resources it
manages.

I practiced:

``` bash
terraform show
terraform state list
terraform state show aws_s3_bucket.day61_bucket_asma
terraform state show aws_instance.day61_ec2
```

After creating both resources, `terraform state list` showed:

``` text
aws_instance.day61_ec2
aws_s3_bucket.day61_bucket_asma
```

The state stores information such as resource IDs, names, ARNs, region,
tags, network information, and other resource attributes.

I should not manually edit the state file because Terraform depends on
it to understand the real infrastructure.

State files should not normally be committed to a public Git repository
because they may contain infrastructure details or sensitive values.

## Task 6 - Modify the EC2 Instance

I changed the EC2 Name tag from:

``` text
TerraWeek-Day1
```

to:

``` text
TerraWeek-Modified
```

Then I ran:

``` bash
terraform plan
```

Terraform showed:

``` text
Plan: 0 to add, 1 to change, 0 to destroy.
```

It also showed `~ update in-place`, meaning Terraform could change the
tag without replacing the EC2 instance.

I ran:

``` bash
terraform apply
```

The result was:

``` text
Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
```

I verified the EC2 tag with AWS CLI and confirmed:

``` text
Name    TerraWeek-Modified
```

### Terraform plan symbols

-   `+` = create a resource
-   `~` = modify an existing resource
-   `-` = destroy a resource

## Destroying the Infrastructure

Finally, I ran:

``` bash
terraform destroy
```

Terraform showed:

``` text
Plan: 0 to add, 0 to change, 2 to destroy.
```

After I entered `yes`, Terraform destroyed the S3 bucket and EC2
instance.

``` text
Destroy complete! Resources: 2 destroyed.
```

## Terraform Commands I Practiced

  Command                  What it does
  ------------------------ -------------------------------------------------
  `terraform init`         Initializes the project and downloads providers
  `terraform fmt`          Formats Terraform code
  `terraform validate`     Checks the Terraform configuration
  `terraform plan`         Previews infrastructure changes
  `terraform apply`        Creates or changes infrastructure
  `terraform show`         Shows the current state in readable form
  `terraform state list`   Lists resources Terraform manages
  `terraform state show`   Shows details for one managed resource
  `terraform destroy`      Removes Terraform-managed resources

## Screenshots

I will add my screenshots here before pushing to GitHub.

### S3 Bucket Created

![S3 Apply](./screenshots/terraform-s3-apply.png)

### EC2 Instance Created

![EC2 Apply](./screenshots/terraform-ec2-apply.png)

### EC2 Tag Modified

![Terraform Modify](./screenshots/terraform-modify.png)

### Resources Destroyed

![Terraform Destroy](./screenshots/terraform-destroy.png)

## `.gitignore`

I should add these local Terraform files to `.gitignore`:

``` gitignore
.terraform/
*.tfstate
*.tfstate.*
```

I can keep `.terraform.lock.hcl` in Git so the provider dependency
selections remain consistent.

## My Day 61 Takeaway

Today I learned the basic Terraform workflow:

**Write configuration -\> Init -\> Plan -\> Apply -\> Check State -\>
Modify -\> Apply -\> Destroy**

The most important thing I learned is that Terraform remembers the
resources it manages through its state file. When I added EC2 after
creating the S3 bucket, Terraform knew the bucket already existed and
only created the EC2 instance.

I also learned that Terraform can update some resources in place without
destroying and recreating them.

**Day 61 completed!**
