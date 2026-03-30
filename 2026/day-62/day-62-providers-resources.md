# Day 62 – Terraform Providers, Resources and Dependencies

## Providers in Terraform

A provider is a plugin that allows Terraform to interact with a cloud platform or service. Without a provider, Terraform has no way to talk to AWS, Azure, GCP, or any other platform.

### providers.tf

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
~~~

---

## Version Constraints

| Constraint | Meaning |
|---|---|
| `~> 5.0` | Any version >= 5.0 and < 6.0 (patch and minor updates allowed) |
| `>= 5.0` | Any version 5.0 or higher including 6.0, 7.0 etc |
| `= 5.0.0` | Exactly version 5.0.0 — nothing else |

> `~> 5.0` is the recommended approach — allows bug fixes and minor updates but prevents breaking changes from a major version bump.

---

## The Lock File — .terraform.lock.hcl

Created when `terraform init` runs. It locks the exact provider version that was downloaded so every team member and every pipeline uses the same version — even if a newer version is released.

> Always commit `.terraform.lock.hcl` to Git. Never commit `.terraform/` or `*.tfstate`.

---

## Building a VPC from Scratch — main.tf

~~~hcl
# VPC — the isolated network
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "TerraWeek-VPC"
  }
}

# Subnet — a segment inside the VPC
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id       # Implicit dependency on VPC
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "TerraWeek-Public-Subnet"
  }
}

# Internet Gateway — allows traffic in and out of the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id                        # Implicit dependency on VPC

  tags = {
    Name = "TerraWeek-IGW"
  }
}

# Route Table — defines where traffic should go
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id                        # Implicit dependency on VPC

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id      # Implicit dependency on IGW
  }

  tags = {
    Name = "TerraWeek-RT"
  }
}

# Route Table Association — links route table to subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id           # Implicit dependency on subnet
  route_table_id = aws_route_table.public_rt.id  # Implicit dependency on route table
}

# Security Group — controls inbound and outbound traffic
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id                        # Implicit dependency on VPC

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

  tags = {
    Name = "TerraWeek-SG"
  }
}

# EC2 Instance — placed inside the subnet with the security group
resource "aws_instance" "main" {
  ami                         = "ami-0f5ee92e2d63afc18"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id          # Implicit dependency
  vpc_security_group_ids      = [aws_security_group.web_sg.id] # Implicit dependency
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "TerraWeek-Server"
  }
}

# S3 Bucket — for application logs
# No direct reference to EC2 but must be created after it
resource "aws_s3_bucket" "app_logs" {
  bucket = "shiv-terraweek-app-logs-2026"

  depends_on = [aws_instance.main]               # Explicit dependency

  tags = {
    Name      = "TerraWeek-Logs"
    ManagedBy = "Terraform"
  }
}
~~~

---

## Implicit vs Explicit Dependencies

### Implicit Dependencies
When one resource references an attribute of another resource, Terraform automatically detects the dependency and creates resources in the correct order.

~~~hcl
# subnet references vpc — Terraform knows VPC must be created first
vpc_id = aws_vpc.main.id
~~~

Terraform reads these references and builds a dependency graph internally. You do not need to declare the order manually.

### Explicit Dependencies — depends_on
When there is no direct attribute reference between resources but one still depends on the other, you use `depends_on` to tell Terraform explicitly.

~~~hcl
depends_on = [aws_instance.main]
~~~

**Real world examples of when to use depends_on:**

→ An S3 bucket that stores application logs must exist only after the application server is running — but the bucket config has no direct reference to the EC2 instance

→ An IAM role policy must be fully attached before an EC2 instance launches and tries to assume that role — even if the instance resource does not directly reference the policy

---

## How Terraform Determines Creation Order

Terraform builds a **dependency graph** from all resource references in your config. It then creates resources in parallel where possible and in sequence where dependencies exist.

~~~
VPC
 ├── Subnet
 ├── Internet Gateway
 │    └── Route Table
 │         └── Route Table Association (needs Subnet + Route Table)
 └── Security Group
      └── EC2 Instance (needs Subnet + Security Group)
           └── S3 Bucket (explicit depends_on)
~~~

> If you tried to create a Subnet before the VPC existed in AWS, the API call would fail — there would be no VPC ID to attach it to. Terraform prevents this by resolving dependencies before executing.

---

## Visualizing the Dependency Graph

~~~bash
# Generate graph in DOT format
terraform graph

# Generate and save as PNG (requires Graphviz installed)
terraform graph | dot -Tpng > graph.png

# Install Graphviz on Ubuntu
sudo apt install graphviz -y
~~~

> If Graphviz is not available, copy the output of `terraform graph` and paste it into webgraphviz.com to visualize it.

---

## Lifecycle Rules

The `lifecycle` block controls how Terraform handles resource replacement.

| Argument | What it does | When to use |
|---|---|---|
| `create_before_destroy` | Creates the new resource before destroying the old one | EC2, load balancers — avoid downtime during replacement |
| `prevent_destroy` | Blocks `terraform destroy` from deleting the resource | Databases, S3 buckets — protect critical data |
| `ignore_changes` | Ignores changes to specified attributes | When an external process modifies a resource (e.g. autoscaling changes instance count) |

~~~hcl
lifecycle {
  create_before_destroy = true
}

lifecycle {
  prevent_destroy = true
}

lifecycle {
  ignore_changes = [tags, instance_type]
}
~~~

---

## CIDR Quick Reference

| CIDR | IPs Available | Use |
|---|---|---|
| `10.0.0.0/16` | 65,536 | VPC — large range |
| `10.0.1.0/24` | 256 | Subnet — smaller segment |

---

## Destroy Order

Terraform destroys resources in **reverse dependency order** — the opposite of creation order.

~~~
S3 Bucket → EC2 Instance → Security Group → Route Table Association
→ Route Table → Internet Gateway → Subnet → VPC
~~~

> The VPC is always the last to be destroyed because everything else depends on it.

---

## Useful Commands

~~~bash
terraform init                  # Download provider plugins
terraform validate              # Check for syntax errors
terraform fmt                   # Auto-format HCL files
terraform plan                  # Preview changes
terraform apply                 # Apply changes
terraform destroy               # Destroy all resources
terraform graph                 # Output dependency graph in DOT format
terraform state list            # List all tracked resources
terraform state show <resource> # Show details of a specific resource
~~~

---

## Key Takeaways

→ A **provider** is the plugin that connects Terraform to a cloud platform — without it, no API calls can be made
→ **Version constraints** like `~> 5.0` allow safe minor updates while preventing breaking major version changes
→ **Implicit dependencies** are automatically detected when one resource references another's attribute
→ **Explicit dependencies** via `depends_on` are used when no direct reference exists but order still matters
→ Terraform builds a **dependency graph** and resolves creation order automatically — you define what, Terraform figures out when
→ **Lifecycle rules** give fine-grained control over how resources are replaced, protected, or updated
→ Terraform always **destroys in reverse dependency order** — children before parents
