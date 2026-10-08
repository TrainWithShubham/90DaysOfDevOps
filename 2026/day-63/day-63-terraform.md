# Day 63 -- Terraform Variables, Outputs, Data Sources and Locals

## Overview

Today I practiced Terraform by creating AWS infrastructure and making
the configuration more reusable.

## What I Practiced

-   Terraform variables and `terraform.tfvars`
-   Command-line variable overrides
-   Outputs and JSON outputs
-   AWS data sources
-   Locals and common tags
-   `terraform fmt`, `validate`, `plan`, `apply`, state, and `destroy`

## AWS Resources Created

-   VPC
-   Public Subnet
-   Internet Gateway
-   Route Table
-   Route Table Association
-   Security Group
-   EC2 Instance
-   S3 Bucket

## Terraform Variables

I created `variables.tf` so values do not need to be hardcoded in
`main.tf`.

Variables included: - `region` - `vpc_cidr` - `subnet_cidr` -
`instance_type` - `project_name` - `environment` - `allowed_ports` -
`extra_tags`

This makes the configuration easier to reuse.

## Variable Values

I practiced using `terraform.tfvars` and also overriding a value from
the command line:

``` bash
terraform plan -var="instance_type=t2.nano"
```

This showed me that Terraform can receive variable values from different
places.

## Terraform Outputs

I created outputs for: - EC2 instance ID - EC2 public IP - EC2 public
DNS - Security Group ID - Subnet ID - VPC ID

Commands used:

``` bash
terraform output
terraform output -json
```

Outputs are useful for getting important information after resources are
created.

## Data Sources

I used AWS data sources to read information instead of hardcoding
everything.

I used: - `data.aws_ami.amazon_linux` -
`data.aws_availability_zones.available`

I learned that a data source reads existing information. It does not
create a resource.

## Locals and Common Tags

I used locals to make resource names and tags consistent.

Common tags included:

``` text
Environment = dev
ManagedBy   = Terraform
Project     = terraweek
```

Terraform updated 7 existing resources in place:

``` text
Plan: 0 to add, 7 to change, 0 to destroy.
```

After applying:

``` text
Apply complete! Resources: 0 added, 7 changed, 0 destroyed.
```

## Validation and Planning

I used:

``` bash
terraform fmt
terraform validate
terraform plan
```

Validation returned:

``` text
Success! The configuration is valid.
```

At final verification, Terraform returned:

``` text
No changes. Your infrastructure matches the configuration.
```

This confirmed that my configuration, Terraform state, and AWS
infrastructure matched.

## Terraform State

I checked managed resources using:

``` bash
terraform state list
```

The state contained the AWS resources and data sources used in the lab.

## Problems I Faced

### 1. Unsupported block type

I accidentally wrote `variablle` instead of `variable`. I corrected the
spelling and validated again.

### 2. Missing AWS provider

Terraform reported a missing provider. I fixed it with:

``` bash
terraform init
```

### 3. EC2 Availability Zone problem

The requested EC2 instance type was not supported in the selected
Availability Zone. I changed to a supported Availability Zone.

### 4. Subnet CIDR conflict

AWS reported that `10.0.1.0/24` conflicted with another subnet while the
subnet was being replaced. After fixing the subnet situation, Terraform
successfully created the infrastructure.

These errors helped me practice reading Terraform and AWS error messages
and troubleshooting step by step.

## Cleanup

Because this was a practice lab, I cleaned up the AWS resources:

``` bash
terraform destroy
```

Terraform showed:

``` text
Plan: 0 to add, 0 to change, 8 to destroy.
```

Final result:

``` text
Destroy complete! Resources: 8 destroyed.
```

I then ran:

``` bash
terraform state list
```

No resources remained in the state.

## Key Takeaways

-   Variables make Terraform reusable.
-   `.tfvars` keeps values separate from configuration.
-   Command-line values can override defaults.
-   Outputs expose useful resource information.
-   Data sources read existing AWS information.
-   Locals reduce repetition and improve naming.
-   Tags help organize AWS resources.
-   Always run `terraform validate` and review `terraform plan`.
-   Terraform state tracks managed infrastructure.
-   Clean up practice resources with `terraform destroy`.

## Day 63 Status

**Completed successfully ✅**
