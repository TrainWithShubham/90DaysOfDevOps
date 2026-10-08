# Day 62 -- Terraform Lifecycle and Dependencies

## What I Learned

Today I practiced Terraform with AWS and learned how Terraform manages
resources, dependencies, state, and lifecycle rules.

## What I Created

Using Terraform, I created:

-   VPC
-   Public Subnet
-   Internet Gateway
-   Route Table
-   Route Table Association
-   Security Group
-   EC2 Instance
-   S3 Bucket

## Commands I Practiced

### Format Terraform Code

`terraform fmt`

This command formats the Terraform code and makes it clean and readable.

### Validate Configuration

`terraform validate`

I received:

**Success! The configuration is valid.**

This confirmed that my Terraform configuration was correct.

### Check the Plan

`terraform plan`

This showed me what Terraform was going to create, change, or destroy
before making changes in AWS.

### Create Infrastructure

`terraform apply`

Terraform created my AWS resources successfully.

### Check Terraform State

I used Terraform state to inspect my EC2 instance.

`terraform state show aws_instance.main`

I checked values such as:

-   Public IP
-   Instance type
-   Subnet ID

My EC2 instance used `t3.micro`.

## Terraform Dependency

I created an S3 bucket for application logs and used:

`depends_on = [aws_instance.main]`

This tells Terraform that the S3 bucket has an explicit dependency on
the EC2 instance.

## Terraform Graph

I generated a Terraform dependency graph with:

`terraform graph | dot -Tpng > graph.png`

This helped me understand how Terraform resources are connected.

## Lifecycle Rule

I practiced this lifecycle rule inside the EC2 resource:

``` hcl
lifecycle {
  create_before_destroy = true
}
```

This tells Terraform to create the replacement resource before
destroying the old resource when replacement is required.

## AMI Replacement Test

I checked available Amazon Linux AMIs using the AWS CLI.

Then I changed the AMI in the EC2 configuration.

Terraform showed:

`Plan: 1 to add, 0 to change, 1 to destroy.`

This taught me that changing the AMI can require Terraform to replace
the EC2 instance.

I did not need to apply this replacement because the goal was to
understand and verify the lifecycle behavior.

## Errors I Faced

### EC2 Instance Type Error

At first I tried to use `t2.micro`.

AWS returned an error because that instance type was not supported in
the selected Availability Zone.

I checked the available free-tier-eligible instance types and changed
the EC2 instance to:

`t3.micro`

After this change, the EC2 instance was created successfully.

### Lifecycle Block Error

I received:

`Error: Unsupported block type`

The lifecycle block was placed in the wrong location.

I moved it inside the `aws_instance` resource:

``` hcl
resource "aws_instance" "main" {
  # EC2 configuration

  lifecycle {
    create_before_destroy = true
  }
}
```

After fixing the block placement:

`terraform validate`

returned:

**Success! The configuration is valid.**

## Final Cleanup

After completing the lab, I removed the AWS resources using:

`terraform destroy`

Final result:

**Destroy complete! Resources: 8 destroyed.**

This was important because leaving cloud resources running can cause
unnecessary AWS charges.

## Screenshots

Add screenshots here for:

1.  Terraform validate success
2.  Terraform apply success
3.  AWS VPC created
4.  EC2 state/public IP
5.  Terraform lifecycle replacement plan
6.  Terraform destroy success

## Key Takeaways

-   Terraform can create and manage AWS infrastructure as code.
-   `terraform plan` lets me review changes before applying them.
-   Terraform automatically understands many resource dependencies.
-   `depends_on` can be used for an explicit dependency.
-   Terraform state keeps track of managed infrastructure.
-   `terraform graph` helps visualize resource relationships.
-   Lifecycle rules control how Terraform creates and replaces
    resources.
-   `create_before_destroy` can reduce downtime during resource
    replacement.
-   Changing an EC2 AMI can cause the instance to be replaced.
-   `terraform destroy` safely cleans up Terraform-managed lab
    resources.

## Day 62 Status

**Completed ✅**
