# Day 65: Terraform Modules - Build Reusable Infrastructure

## Task 1: Custom Module Directory Structure
A Terraform module is a package of `.tf` files. The root module calls child modules.
```text
terraform-modules-project/
├── main.tf                    # Root module -- calls child modules
├── variables.tf               # Root variables
├── outputs.tf                 # Root outputs
├── providers.tf               # Provider config
└── modules/
    ├── ec2-instance/          # Child Module (EC2)
    │   ├── main.tf            
    │   ├── variables.tf       
    │   └── outputs.tf         
    └── security-group/        # Child Module (SG)
        ├── main.tf            
        ├── variables.tf       
        └── outputs.tf         
```
*(Reference: [task-01-module-structure.png](screenshots/task-01-module-structure.png))*

## Task 2: Custom EC2 Module Code

**`variables.tf` (Inputs)**
```hcl
variable "instance_name" { type = string }
variable "environment" { type = string, default = "dev" }
variable "ami_id" { type = string }
variable "instance_type" { type = string, default = "t2.micro" }
variable "subnet_id" { type = string }
variable "security_group_ids" { type = list(string) }
variable "tags" { type = map(string), default = {} }
```

**`main.tf` (Resource definition)**
```hcl
resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  tags = merge(
    { Name = "${var.environment}-${var.instance_name}" },
    var.tags,
  )
}
```
*(Reference: [task-02-ec2-module.png](screenshots/task-02-ec2-module.png))*

## Task 3: Custom Security Group Module (Dynamic Blocks)

**`main.tf` (Dynamic Ingress Block)**
```hcl
resource "aws_security_group" "this" {
  name   = var.sg_name
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```
*(Reference: [task-03-sg-module.png](screenshots/task-03-sg-module.png))*

## Task 4: Root main.tf (Calling Modules with for_each)
```hcl
# Custom EC2 Module (Deployed twice using for_each)
module "servers" {
  source             = "./modules/ec2-instance"
  for_each           = toset(["web-server", "api-server"])
  instance_name      = each.key
  ami_id             = data.aws_ami.amazon_linux.id
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = [module.web_sg.sg_id]
}
```
*(Reference: [task-04-apply-modules.png](screenshots/task-04-apply-modules.png))*

## Task 5: Hand-written VPC vs Registry Module Comparison
When building the VPC manually in Day 62, it took ~6 resources and 50+ lines of code to create a basic network. 
By switching to the official `terraform-aws-modules/vpc/aws` registry module, a single block of code generated **17 networking resources** (Route tables, ACLs, associations, IGW, etc.) in the background flawlessly. The registry module was downloaded into `.terraform/modules/vpc`.

*(Reference: [task-05-registry-module.png](screenshots/task-05-registry-module.png))*

## 6. Five Module Best Practices
1. **Always pin versions for registry modules:** Use pessimistic constraints (e.g., `~> 5.0`) or Git tags to prevent sudden breaking changes when publishers update their code.
2. **Keep modules focused:** A module should do one thing well (e.g., just an EC2 instance, or just an RDS cluster). Do not build "mega-modules" that do everything.
3. **Use variables for everything, hardcode nothing:** Pass dynamic IDs (like VPC or Subnet IDs) from the root module so the child module can be reused across different AWS accounts and regions.
4. **Always define outputs:** Expose resource IDs and IPs in `outputs.tf` so that other modules (or the root module) can consume them (Modular Composition).
5. **Add a README.md:** Always document your custom module so other engineers in your team know what inputs are required and what outputs are returned.
