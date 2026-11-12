# Day 62: Terraform Providers, Resources and Dependencies

## Challenge Tasks

### Task 1: Explore the AWS Provider
- **Terraform Block & Provider Setup:** Created `providers.tf` specifying the `hashicorp/aws` provider.
- **Version Installed:** After running `terraform init`, version `v5.100.0` of the AWS provider was successfully installed.
- **The Lock File (`.terraform.lock.hcl`):** This file records the exact provider versions and their cryptographic hashes (`h1:` and `zh:`). It ensures that execution environments are strictly synchronized across different machines and team members.

**Q: What does `~> 5.0` mean? How is it different from `>= 5.0` and `= 5.0.0`?**
- **`~> 5.0` (Pessimistic Constraint Operator):** Allows only minor and patch updates within the 5.x release branch (e.g., `5.100.0`), but explicitly prevents upgrading to a major release like `6.0` which could introduce breaking changes.
- **`>= 5.0`:** Allows any version greater than or equal to 5.0, including major releases like `6.0` or `7.0`, which is highly risky for production infrastructure.
- **`= 5.0.0`:** Locks the provider to one exact, strict version. This prevents the adoption of necessary security patches or non-breaking bug fixes.

### Task 2: Build a VPC from Scratch
Created the core networking stack in `main.tf` using dynamic variables rather than hardcoded strings.

- **VPC:** `10.0.0.0/16` (ID: `vpc-04951540add890021`)
- **Public Subnet:** `10.0.1.0/24` (ID: `subnet-089cf6673598b4152`)
- **Components attached:** Internet Gateway (`igw-0b09cf6c372be1e22`), Route Table (`rtb-0812810c428136fb7`), and Route Table Association (`rtbassoc-0d1399c62de99a108`).
- **Result:** `Apply complete! Resources: 5 added, 0 changed, 0 destroyed.`

### Task 3: Understand Implicit Dependencies

**Q: How does Terraform know to create the VPC before the subnet?**
Terraform evaluates configuration files and builds a local dependency graph dynamically. Because the `aws_subnet` resource explicitly references the ID of the VPC (`vpc_id = aws_vpc.main.id`), Terraform intelligently maps this reference as an "implicit dependency" and guarantees the VPC is fully provisioned before initializing the subnet creation.

**Q: What would happen if you tried to create the subnet before the VPC existed?**
The operation would fail. The AWS API requires a valid VPC ID as a required parameter to instantiate a subnet. Terraform’s internal logic prevents this by respecting the dependency graph order.

**Implicit Dependencies found in config:**
1.  `aws_subnet.public` depends on `aws_vpc.main`
2.  `aws_internet_gateway.igw` depends on `aws_vpc.main`
3.  `aws_route_table.public_rt` depends on `aws_vpc.main` and `aws_internet_gateway.igw`
4.  `aws_route_table_association.public_assoc` depends on `aws_subnet.public` and `aws_route_table.public_rt`

### Task 4: Add a Security Group and EC2 Instance
Deployed a Security Group to allow SSH (22) and HTTP (80) inbound traffic, and provisioned a `t2.micro` EC2 instance attached to the public subnet.

- **EC2 Instance ID:** `i-0bf570c580aefca8a`
- **Output Verified:** `server_public_ip = "13.201.36.6"`
- **Result:** `Apply complete! Resources: 2 added, 0 changed, 0 destroyed.`

### Task 5: Explicit Dependencies with depends_on
Added an `aws_s3_bucket` (`terraweek-logs-vpc-04951540add890021`) and forced it to wait for the EC2 instance using the `depends_on = [aws_instance.web]` argument.

**Q: When would you use `depends_on` in real projects? Give two examples.**
1.  **Application Initialization:** An EC2 instance might run a user-data startup script that downloads configuration files directly from an S3 bucket. The bucket (and its objects) must be fully provisioned before the EC2 instance boots.
2.  **Database Integration:** A stateless web server deployment should only trigger after the backend relational database (RDS) is completely initialized, available, and accepting connections.

### Task 6: Lifecycle Rules and Destroy
Modified the EC2 instance AMI to force a resource replacement and added a lifecycle block.

**Q: What are the three lifecycle arguments and when would you use each?**
1.  **`create_before_destroy = true`:** Modifies Terraform's default (destroy-then-create) behavior. It provisions the replacement resource first, updates dependencies, and then destroys the old one. Crucial for **Zero-Downtime Deployments**.
2.  **`prevent_destroy = true`:** Rejects any execution plan that attempts to destroy the resource. Used strictly for critical infrastructure (e.g., Production Databases) to prevent accidental data loss.
3.  **`ignore_changes = [...]`:** Instructs Terraform to ignore differences between the state file and the actual cloud environment for specific attributes (e.g., `tags`). Used when attributes are managed by external automation or mutated manually in the console.

**Teardown Verified:** 
Successfully executed `terraform destroy`. Verified that destruction followed the reverse dependency order (S3 -> EC2 -> Route Tables -> Subnet -> VPC).
- [Insert task-06-destroy.png here] - Terminal output showing `Destroy complete!`.

---

## The Complete `main.tf`

```hcl
locals {
  common_tags = {
    Project     = "TerraWeek"
    Environment = var.environment
  }
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = merge(local.common_tags, { Name = "TerraWeek-VPC-${var.environment}" })
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = var.enable_public_ip
  tags                    = merge(local.common_tags, { Name = "TerraWeek-Public-Subnet" })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(local.common_tags, { Name = "TerraWeek-IGW" })
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(local.common_tags, { Name = "TerraWeek-Public-RT" })
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "web_sg" {
  name        = "TerraWeek-SG"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.common_tags, { Name = "TerraWeek-SG" })
}

resource "aws_instance" "web" {
  ami                         = "ami-0287a05f0ef0e9d9a"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  tags                        = merge(local.common_tags, { Name = "TerraWeek-Server" })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket" "app_logs" {
  bucket     = "terraweek-logs-${aws_vpc.main.id}"
  depends_on = [aws_instance.web]
  tags       = merge(local.common_tags, { Name = "TerraWeek-Logs-Bucket" })
}
```
