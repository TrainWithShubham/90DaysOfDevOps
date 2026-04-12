# Day 65 — Terraform Modules: Build Reusable Infrastructure

## What are Terraform Modules?

A Terraform module is simply a directory containing `.tf` files. Every Terraform project is itself a module — called the **root module**. When you create sub-folders with their own `.tf` files and call them from root, those become **child modules**.

Think of modules as functions in programming — write once, call many times with different inputs.

---

## Module Structure

~~~
terraform-modules/
  main.tf                        # Root module — calls child modules
  variables.tf                   # Root inputs
  outputs.tf                     # Root outputs
  providers.tf                   # Provider + version config
  modules/
    ec2-instance/
      main.tf                    # EC2 resource definition
      variables.tf               # Module inputs
      outputs.tf                 # Module outputs
    security-group/
      main.tf                    # Security group resource definition
      variables.tf               # Module inputs
      outputs.tf                 # Module outputs
~~~

**Root module vs Child module:**
- Root module = where you run `terraform apply`. The orchestrator.
- Child module = a sub-folder called by the root. Receives inputs, returns outputs.

---

## Task 1 — Create the Structure

~~~bash
mkdir -p terraform-modules/modules/ec2-instance
mkdir -p terraform-modules/modules/security-group

touch terraform-modules/main.tf
touch terraform-modules/variables.tf
touch terraform-modules/outputs.tf
touch terraform-modules/providers.tf

touch terraform-modules/modules/ec2-instance/main.tf
touch terraform-modules/modules/ec2-instance/variables.tf
touch terraform-modules/modules/ec2-instance/outputs.tf

touch terraform-modules/modules/security-group/main.tf
touch terraform-modules/modules/security-group/variables.tf
touch terraform-modules/modules/security-group/outputs.tf

# Verify
find terraform-modules -type f | sort
~~~

---

## Task 2 — Custom EC2 Module

### `modules/ec2-instance/variables.tf`

~~~hcl
variable "ami_id" {
  description = "AMI ID for EC2 Instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID where EC2 Instance will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "List of Security group IDs to attach to EC2 Instance"
  type        = list(string)
}

variable "instance_name" {
  description = "Name tag for EC2 instance"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to EC2 Instance"
  type        = map(string)
  default     = {}
}
~~~

### `modules/ec2-instance/main.tf`

~~~hcl
resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  tags = merge(
    { Name = var.instance_name },
    var.tags
  )
}
~~~

**Why `"this"` as resource name?**
Convention for the primary resource inside a focused module. Callers never reference it directly — they use module outputs. `"this"` signals "this is the main resource this module manages."

**Why `merge()`?**
Combines two maps into one. Example:
~~~
merge({ Name = "terraweek-web" }, { Env = "dev", Project = "terraweek" })
# Result: { Name = "terraweek-web", Env = "dev", Project = "terraweek" }
~~~

**Why `vpc_security_group_ids` not `security_groups`?**
`vpc_security_group_ids` is for VPC-based instances (all modern AWS). `security_groups` is deprecated EC2-Classic.

### `modules/ec2-instance/outputs.tf`

~~~hcl
output "instance_id" {
  description = "ID of the EC2 Instance"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.this.public_ip
}

output "public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.this.public_dns
}

output "private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.this.private_ip
}
~~~

---

## Task 3 — Custom Security Group Module

### `modules/security-group/variables.tf`

~~~hcl
variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "sg_name" {
  description = "Name of the security group"
  type        = string
}

variable "ingress_ports" {
  description = "List of ports to allow inbound traffic"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "tags" {
  description = "Additional tags to apply to Security Group"
  type        = map(string)
  default     = {}
}
~~~

### `modules/security-group/main.tf`

~~~hcl
resource "aws_security_group" "this" {
  name        = var.sg_name
  description = "Security group managed by Terraform"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    { Name = var.sg_name },
    var.tags
  )
}
~~~

**How `dynamic` block works:**
~~~
dynamic "ingress"              → generate ingress {} blocks dynamically
  for_each = var.ingress_ports → loop over [22, 80, 443]
  content {}                   → body of each generated block
    ingress.value              → current item in the loop
~~~

For `ingress_ports = [22, 80, 443]`, Terraform generates 3 separate ingress rules automatically. Without `dynamic`, you'd hardcode one block per port — making the module non-reusable.

**Why `protocol = "-1"` for egress?**
`-1` means all protocols. Combined with `from_port = 0` and `to_port = 0` — allow all outbound traffic.

### `modules/security-group/outputs.tf`

~~~hcl
output "sg_id" {
  description = "ID of the security group"
  value       = aws_security_group.this.id
}
~~~

---

## Task 4 — Root Module

### `providers.tf`

~~~hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "project_name" {
  description = "Project name used for tagging"
  type        = string
  default     = "terraweek"
}

variable "environment" {
  description = "Environment name used for tagging"
  type        = string
  default     = "dev"
}
~~~

### `main.tf`

~~~hcl
locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Fetch latest AMIs dynamically — never hardcode AMI IDs
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]   # Canonical's AWS account ID
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "centos" {
  most_recent = true
  owners      = ["125523088429"]   # CentOS official AWS account ID
  filter {
    name   = "name"
    values = ["CentOS Stream 9*x86_64*"]
  }
}

# Fetch AZs dynamically — region-agnostic
data "aws_availability_zones" "available" {
  state = "available"
}

# Registry module — VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name                    = "${var.project_name}-vpc"
  cidr                    = "10.0.0.0/16"
  azs                     = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets          = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  enable_nat_gateway      = false
  enable_dns_hostnames    = true
  map_public_ip_on_launch = true

  tags = local.common_tags
}

# Custom module — Security Group
module "web_sg" {
  source        = "./modules/security-group"
  vpc_id        = module.vpc.vpc_id
  sg_name       = "${var.project_name}-web-sg"
  ingress_ports = [22, 80, 443]
  tags          = local.common_tags
}

# Custom module — EC2 (called 3 times, different OS each time)
module "web_server" {
  source             = "./modules/ec2-instance"
  ami_id             = data.aws_ami.ubuntu.id
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "${var.project_name}-web-ubuntu"
  tags               = local.common_tags
}

module "api_server" {
  source             = "./modules/ec2-instance"
  ami_id             = data.aws_ami.amazon_linux.id
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnets[1]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "${var.project_name}-api-amazon"
  tags               = local.common_tags
}

module "app_server" {
  source             = "./modules/ec2-instance"
  ami_id             = data.aws_ami.centos.id
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnets[2]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "${var.project_name}-app-centos"
  tags               = local.common_tags
}
~~~

### `outputs.tf`

~~~hcl
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "web_server_public_ip" {
  description = "Public IP of the web server (Ubuntu)"
  value       = module.web_server.public_ip
}

output "api_server_public_ip" {
  description = "Public IP of the API server (Amazon Linux)"
  value       = module.api_server.public_ip
}

output "app_server_public_ip" {
  description = "Public IP of the app server (CentOS)"
  value       = module.app_server.public_ip
}

output "security_group_id" {
  description = "ID of the web security group"
  value       = module.web_sg.sg_id
}
~~~

---

## Task 5 — Registry Module vs Custom Module

| Aspect | Local Module | Registry Module |
|---|---|---|
| Source | `"./modules/security-group"` | `"terraform-aws-modules/vpc/aws"` |
| Version pin | Not needed | Required (`version = "~> 5.0"`) |
| Downloaded to | Already on disk | `.terraform/modules/` |
| Maintained by | You | Community / HashiCorp |
| Resources created | What you write | Can be 14+ from 10 lines |

**VPC module created 14 resources from ~10 lines of HCL:**
`aws_vpc`, `aws_subnet` ×3, `aws_internet_gateway`, `aws_route_table`, `aws_route`, `aws_route_table_association` ×3, `aws_default_network_acl`, `aws_default_route_table`, `aws_default_security_group`

---

## Task 6 — Module Versioning

~~~hcl
version = "5.1.0"          # Exact version — locked
version = "~> 5.0"         # Any 5.x — never 6.0 (pessimistic constraint)
version = ">= 5.0, < 6.0"  # Explicit range
~~~

~~~bash
terraform init -upgrade    # Check for newer versions
terraform state list       # See module prefixes in state
~~~

**State list shows module namespacing:**
~~~
module.api_server.aws_instance.this
module.app_server.aws_instance.this
module.vpc.aws_internet_gateway.this[0]
module.vpc.aws_subnet.public[0]
module.vpc.aws_vpc.this[0]
module.web_server.aws_instance.this
module.web_sg.aws_security_group.this
~~~

---

## Key Concepts

### locals vs variables

| | `locals` | `variables` |
|---|---|---|
| Overridable from outside | ❌ No | ✅ Yes |
| Appears in plan prompts | ❌ No | ✅ Yes |
| Use for | Internal computed values | Caller-controlled inputs |
| Example | `common_tags` | `region`, `instance_type` |

### AMI owner IDs — important reference

| OS | Owner |
|---|---|
| Amazon Linux | `"amazon"` |
| Ubuntu (Canonical) | `"099720109477"` |
| CentOS Stream | `"125523088429"` |
| RHEL | Paid — not publicly available |

### Why not hardcode AMI IDs?
AMI IDs are region-specific and change when vendors release updates. Always use `data "aws_ami"` with filters to fetch the latest valid AMI at plan time.

---

## Module Best Practices

1. **Always pin versions** for registry modules — prevents surprise breaking changes
2. **Keep modules focused** — one concern per module (EC2 module does EC2, SG module does SG)
3. **Use variables for everything** — hardcode nothing inside a module
4. **Always define outputs** — callers need to reference your resources
5. **Use `"this"`** as resource name for the primary resource in a module
6. **Add `map_public_ip_on_launch = true`** in VPC module if instances need public IPs
7. **Use `data` sources for AMIs** — never hardcode AMI IDs

---

## Troubleshooting Encountered

**`InvalidUserID.Malformed: Invalid user id: "ubuntu"`**
AWS only accepts numeric account IDs or `"amazon"` / `"aws-marketplace"` aliases. Fix: use Canonical's account ID `"099720109477"`.

**`terraform taint`**
Used to force recreation of existing instances after `map_public_ip_on_launch` was enabled — existing instances don't retroactively get public IPs, only newly created ones do.

---

*Day 65 of #90DaysOfDevOps | #TerraWeek | #TrainWithShubham*
