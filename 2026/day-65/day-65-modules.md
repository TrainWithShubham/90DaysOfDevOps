# Day 65 -- Terraform Modules: Build Reusable Infrastructure

## What I Learned

Today I learned how Terraform **modules** help organize and reuse
infrastructure code.

Instead of keeping every resource in one large `main.tf`, I separated
reusable resources into modules. I built my own EC2 and Security Group
modules and also used a public VPC module from the Terraform Registry.

A module feels similar to a function in programming: define it once,
pass different inputs, and reuse it.

------------------------------------------------------------------------

## 1. Module Structure

I created this project structure:

``` text
day-65/
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
└── modules/
    ├── ec2-instance/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── security-group/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

### Root Module vs Child Module

-   **Root module** -- the Terraform configuration where I run commands
    such as `terraform plan` and `terraform apply`.
-   **Child module** -- a reusable module called by the root module,
    such as my EC2 or Security Group module.

------------------------------------------------------------------------

## 2. Custom EC2 Module

I created a reusable EC2 module in:

``` text
modules/ec2-instance/
```

### variables.tf

``` hcl
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs"
  type        = list(string)
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
```

### main.tf

``` hcl
resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true

  tags = merge(
    var.tags,
    {
      Name = var.instance_name
    }
  )
}
```

### outputs.tf

``` hcl
output "instance_id" {
  value = aws_instance.this.id
}

output "public_ip" {
  value = aws_instance.this.public_ip
}

output "private_ip" {
  value = aws_instance.this.private_ip
}
```

I called the same EC2 module twice to create two different servers:

-   `terraweek-web`
-   `terraweek-api`

This showed me that I do not need to copy the EC2 resource code every
time.

------------------------------------------------------------------------

## 3. Custom Security Group Module

I also created:

``` text
modules/security-group/
```

The module accepts a list of ports and uses a Terraform `dynamic` block
to create ingress rules.

For this lab I used:

``` hcl
ingress_ports = [22, 80, 443]
```

The important concept was that a `dynamic` block can generate repeated
nested blocks from a collection instead of writing each ingress rule
manually.

The Security Group output was then passed into both EC2 module calls:

``` hcl
security_group_ids = [module.web_sg.sg_id]
```

So both servers shared the same Security Group.

------------------------------------------------------------------------

## 4. Reusing the EC2 Module

The root module called the same child module twice with different names:

``` hcl
module "web_server" {
  source = "./modules/ec2-instance"

  ami_id             = data.aws_ami.amazon_linux.id
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraweek-web"
  tags               = local.common_tags
}

module "api_server" {
  source = "./modules/ec2-instance"

  ami_id             = data.aws_ami.amazon_linux.id
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraweek-api"
  tags               = local.common_tags
}
```

After fixing the lab issues, Terraform successfully created both
instances and returned public IP addresses.

``` text
api_server_ip = "99.79.123.227"
web_server_ip = "15.223.68.171"
```

------------------------------------------------------------------------

## 5. Terraform Registry VPC Module

Instead of continuing with my hand-written VPC resources from the
earlier lab, I replaced them with the public AWS VPC module:

``` hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "terraweek-vpc"
  cidr = "10.0.0.0/16"

  azs = [
    "ca-central-1a",
    "ca-central-1b"
  ]

  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnets = [
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]

  enable_nat_gateway   = false
  enable_dns_hostnames = true

  tags = local.common_tags
}
```

The Registry module created much more networking infrastructure
automatically than my simple hand-written VPC configuration, including
public/private subnets, route tables, route-table associations, Internet
Gateway, and related VPC resources.

I also learned that Terraform downloads Registry modules under:

``` text
.terraform/modules/
```

I verified it with:

``` bash
ls .terraform/modules
```

and saw:

``` text
modules.json  vpc
```

------------------------------------------------------------------------

## 6. Terraform State with Modules

I ran:

``` bash
terraform state list
```

The state showed module-specific addresses such as:

``` text
module.api_server.aws_instance.this
module.web_server.aws_instance.this
module.web_sg.aws_security_group.this
module.vpc.aws_vpc.this[0]
module.vpc.aws_subnet.public[0]
module.vpc.aws_subnet.public[1]
module.vpc.aws_subnet.private[0]
module.vpc.aws_subnet.private[1]
```

This helped me understand that Terraform keeps track of which module
owns each resource.

------------------------------------------------------------------------

## 7. Real Troubleshooting During the Lab

This lab included several problems that helped me understand Terraform
better.

### Duplicate VPC Module

I accidentally had two blocks named:

``` hcl
module "vpc"
```

Terraform returned:

``` text
Error: Duplicate module call
```

I removed the duplicate and kept only one Registry VPC module.

### Old VPC References

After moving to the Registry module, the configuration still contained
old hand-written networking resources and references.

I removed the old VPC, subnet, Internet Gateway, route table, and
route-table association configuration and updated module references to:

``` hcl
module.vpc.vpc_id
module.vpc.public_subnets[0]
```

### EC2 Instance Type / Availability Zone Problem

Initially I used:

``` text
t2.micro
```

AWS returned an error because `t2.micro` was not supported in the
selected `ca-central-1d` Availability Zone.

I changed the instance type to:

``` text
t3.micro
```

and used the VPC module with:

``` text
ca-central-1a
ca-central-1b
```

The instances were then created successfully.

### Public IP Output Was Empty

The first successful deployment showed:

``` text
api_server_ip = ""
web_server_ip = ""
```

I added:

``` hcl
associate_public_ip_address = true
```

to my EC2 module.

Terraform replaced both EC2 instances, and the new instances received
public IP addresses.

This was a useful example of seeing how a configuration change can cause
Terraform to replace existing infrastructure.

------------------------------------------------------------------------

## 8. Hand-Written VPC vs Registry Module

### Hand-Written VPC

In my earlier Terraform work, I manually defined resources such as:

-   VPC
-   subnet
-   Internet Gateway
-   route table
-   route-table association

This gave me direct control, but required more Terraform code.

### Registry VPC Module

For Day 65, I supplied the VPC configuration as module inputs, and the
module created the required networking resources internally.

During the Registry-module deployment, Terraform reported:

``` text
Apply complete! Resources: 20 added, 0 changed, 8 destroyed.
```

This showed me how much infrastructure a reusable module can manage
behind a relatively small module call.

------------------------------------------------------------------------

## 9. Module Best Practices

Five module practices I learned:

1.  Pin Registry module versions so upgrades are controlled.
2.  Keep each custom module focused on one responsibility.
3.  Use variables so the module can be reused with different
    configurations.
4.  Define outputs so other modules can use important resource values.
5.  Add documentation such as a `README.md` so other engineers
    understand how to use the module.

------------------------------------------------------------------------

## 10. Commands Practiced

``` bash
terraform fmt -recursive
terraform init
terraform init -upgrade
terraform validate
terraform plan
terraform apply
terraform state list
ls .terraform/modules
terraform destroy
```

------------------------------------------------------------------------

## Final Cleanup

After completing and verifying the lab, I destroyed the AWS
infrastructure:

``` bash
terraform destroy
```

Final result:

``` text
Destroy complete! Resources: 20 destroyed.
```

This ensured the temporary lab infrastructure was removed after testing.

------------------------------------------------------------------------

## My Main Takeaway

Before this lab, I was writing Terraform resources directly in the root
configuration.

Now I understand how to package infrastructure into reusable modules,
pass values into modules through variables, expose values through
outputs, connect modules together, call the same module multiple times,
and use an existing Registry module instead of rebuilding common
infrastructure.

The troubleshooting was also useful because I had to fix duplicate
module definitions, old resource references, an unsupported EC2 instance
type/Availability Zone combination, and missing public IPs before the
final deployment worked.
