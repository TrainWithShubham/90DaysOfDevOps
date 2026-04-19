# Day 67 — TerraWeek Capstone: Multi-Environment Infrastructure with Workspaces and Modules

## What We Built
One Terraform codebase that deploys 3 completely isolated environments (dev, staging, prod) using Terraform Workspaces. Each environment gets its own VPC, security group, and EC2 instance — with different sizing and different network configs.

---

## Core Concepts

### 1. Terraform Workspaces
- A workspace is a **separate state file for the same codebase**
- Same `.tf` files, different state, different resources
- `terraform.workspace` returns the current workspace name (e.g. `dev`, `staging`, `prod`)
- State is stored at: `terraform.tfstate.d/<workspace>/terraform.tfstate`

```bash
terraform workspace new dev        # create workspace
terraform workspace select dev     # switch workspace
terraform workspace show           # current workspace
terraform workspace list           # list all workspaces
terraform workspace delete dev     # delete workspace (must not be current)
```

#### Workspaces vs Separate Folders
| | Workspaces | Separate Folders |
|---|---|---|
| Codebase | One shared | Copied per environment |
| State | `tfstate.d/<workspace>/` | Each folder has own state |
| Risk | One mistake affects all | Fully isolated |
| DRY | ✅ Write once | ❌ Copy-paste drift |

---

### 2. Project File Structure (Best Practice)
```
terraweek-capstone/
├── main.tf          → module calls only
├── variables.tf     → all input variables
├── outputs.tf       → all outputs
├── providers.tf     → AWS provider config
├── locals.tf        → computed/derived values
├── data.tf          → AWS API data sources
├── dev.tfvars       → dev environment values
├── staging.tfvars   → staging values
├── prod.tfvars      → prod values
├── .gitignore       → protect state and secrets
└── modules/
    ├── vpc/
    ├── security-group/
    └── ec2-instance/
```

**Why this structure?**
- Each file has one job — easy to navigate
- `data.tf` = AWS API calls, `locals.tf` = computed values (never mix them)
- Modules are reusable building blocks
- `.gitignore` prevents state files and secrets from being committed

---

### 3. Custom Modules

#### Module = Function in Programming
- **Inputs** → variables
- **Body** → resources
- **Return** → outputs

#### VPC Module (`modules/vpc/`)
- Creates: VPC, subnet, internet gateway, route table, route table association
- Inputs: `cidr`, `public_subnet_cidr`, `environment`, `project_name`
- Outputs: `vpc_id`, `subnet_id`

#### Security Group Module (`modules/security-group/`)
- Creates: Security group with dynamic ingress rules
- Inputs: `vpc_id`, `ingress_ports`, `environment`, `project_name`
- Outputs: `sg_id`
- Key concept: `dynamic` block loops over `ingress_ports` list

```hcl
dynamic "ingress" {
  for_each = var.ingress_ports   # loops over [22, 80] or [80, 443]
  content {
    from_port   = ingress.value  # current item in loop
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

#### EC2 Instance Module (`modules/ec2-instance/`)
- Creates: EC2 instance with workspace-aware tags
- Inputs: `ami_id`, `instance_type`, `subnet_id`, `security_group_ids`, `environment`, `project_name`
- Outputs: `instance_id`, `public_ip`

---

### 4. Module Data Flow
```
vpc module              security-group module       ec2-instance module
-----------             --------------------         -------------------
outputs:                inputs:                      inputs:
  vpc_id      ─────────►  vpc_id                      
  subnet_id   ──────────────────────────────────────►  subnet_id
                                     sg_id ──────────►  security_group_ids
```

In root `main.tf`:
```hcl
subnet_id          = module.vpc.subnet_id
security_group_ids = [module.security_group.sg_id]
```

---

### 5. Workspace-Aware Configuration

#### `locals.tf`
```hcl
locals {
  environment = terraform.workspace   # returns "dev", "staging", or "prod"

  common_tags = {
    Project     = var.project_name
    Environment = local.environment
    ManagedBy   = "Terraform"
    Workspace   = terraform.workspace
  }
}
```

#### Environment-specific tfvars
| Setting | dev | staging | prod |
|---|---|---|---|
| VPC CIDR | 10.0.0.0/16 | 10.1.0.0/16 | 10.2.0.0/16 |
| Subnet | 10.0.1.0/24 | 10.1.1.0/24 | 10.2.1.0/24 |
| Instance | t3.micro | t3.small | t3.small |
| Ports | 22, 80 | 22, 80, 443 | 80, 443 |

**Why different CIDRs?** — No overlap = no peering conflicts in future

**Why no port 22 in prod?** — SSH blocked at network level = better security. Use SSM Session Manager instead.

---

### 6. Data Sources vs Locals

| | `data` block | `locals` block |
|---|---|---|
| What it does | Makes AWS API call | Computes values locally |
| Lives in | `data.tf` | `locals.tf` |
| Example | Fetch latest AMI ID | Map workspace to AMI |
| Can be nested? | No | Yes |

```hcl
# data.tf — calls AWS API
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# locals.tf — uses that value locally
locals {
  ami_map = {
    dev     = data.aws_ami.centos.id
    staging = data.aws_ami.ubuntu.id
    prod    = data.aws_ami.amazon_linux.id
  }
}
```

---

### 7. Implicit Dependencies
When one resource references another, Terraform automatically creates it first:
```hcl
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id   # implicit dependency — VPC created first
}
```

---

### 8. Deployment Commands

```bash
# Deploy an environment
terraform workspace select dev
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"

# Verify outputs
terraform output

# Destroy an environment
terraform destroy -var-file="dev.tfvars"

# Cleanup workspaces
terraform workspace select default
terraform workspace delete dev
```

---

### 9. Terraform Best Practices

1. **File structure** — separate files for providers, variables, outputs, main, locals, data
2. **State management** — always use remote backend, enable locking and versioning
3. **Variables** — never hardcode, use tfvars per environment
4. **Modules** — one concern per module, always define inputs/outputs
5. **Workspaces** — use for environment isolation, reference `terraform.workspace`
6. **Security** — `.gitignore` state and tfvars, encrypt state at rest
7. **Commands** — always run `plan` before `apply`, use `fmt` and `validate` before committing
8. **Tagging** — tag every resource with project, environment, managed-by
9. **Naming** — consistent pattern: `<project>-<environment>-<resource>`
10. **Cleanup** — always `terraform destroy` non-production environments when not in use

---

### 10. Common Errors & Fixes

| Error | Cause | Fix |
|---|---|---|
| `Reference to undeclared module` | Hyphen in module name | Use underscores: `module "security_group"` |
| `string required, but have tuple` | Wrong variable type | Change to `list(string)` |
| `Your query returned no results` | AMI not available in region | Update filter or owner ID |
| `Not eligible for Free Tier` | Wrong instance type | Use `t3.micro` in newer regions |
| Can't delete workspace | Currently on it | Switch to `default` first |

---

## TerraWeek Summary

| Day | Concepts |
|-----|----------|
| 61 | IaC, HCL, init/plan/apply/destroy, state basics |
| 62 | Providers, resources, dependencies, lifecycle |
| 63 | Variables, outputs, data sources, locals, functions |
| 64 | Remote backend, locking, import, drift |
| 65 | Custom modules, registry modules, versioning |
| 66 | EKS with modules, real-world provisioning |
| 67 | Workspaces, multi-env, capstone project |
