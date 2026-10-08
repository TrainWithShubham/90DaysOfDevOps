# Day 64 --- Terraform State Management and Remote Backends

## Goal

Learn how Terraform state works, why remote state is important, how
state locking protects teams, how to import existing AWS resources, how
to use state commands, and how Terraform detects infrastructure drift.

------------------------------------------------------------------------

## 1. Why Terraform State Is Important

Terraform state is the map between my Terraform code and the real
resources in AWS.

Example:

``` text
aws_instance.main
        ↓
Real EC2 instance in AWS
        ↓
i-043a2341a057e18a3
```

Terraform needs state so it remembers which real AWS resource belongs to
each Terraform resource.

When I run `terraform plan`, Terraform uses my configuration, state
information, and refreshed information from AWS to determine what needs
to change.

### Simple interview answer

**Terraform state keeps track of the infrastructure Terraform manages
and maps Terraform resource addresses to real cloud resources.**

------------------------------------------------------------------------

## 2. Task 1 --- Inspecting State

I reused my Day 63 Terraform configuration.

Useful commands:

``` bash
terraform show
terraform state list
terraform state show aws_instance.main
terraform state show aws_vpc.main
```

`terraform show` displays the current state in readable form.

`terraform state list` lists the addresses Terraform knows about.

My state included resources/data sources such as:

``` text
data.aws_ami.amazon_linux
data.aws_availability_zones.available
aws_instance.main
aws_internet_gateway.main
aws_route_table.public
aws_route_table_association.public
aws_s3_bucket.logs
aws_security_group.main
aws_subnet.public
aws_vpc.main
```

`terraform state show aws_instance.main` shows many EC2 attributes,
including values that AWS/provider calculated rather than values I
manually typed in the resource block.

Examples include instance ID, AMI, instance type, subnet, security
groups, IP information, ARN, tags, and other computed attributes.

------------------------------------------------------------------------

## 3. State Serial Number

I checked:

``` bash
grep '"serial"' terraform.tfstate
```

My lab showed:

``` text
"serial": 9
```

The serial is a revision counter for Terraform state. It changes as
Terraform writes newer state snapshots.

**Easy memory:** `serial = state revision number`.

------------------------------------------------------------------------

## 4. Why Local State Is Risky

A local state file normally exists as:

``` text
terraform.tfstate
```

Keeping important team state only on one laptop is risky because the
file can be lost, team members can end up with different copies, and
collaboration becomes difficult.

A remote backend gives the team a shared state location.

``` text
LOCAL

Developer
   |
terraform.tfstate


REMOTE

Developer 1 ----Developer 2 -----+----> Remote Backend ----> State
CI/CD -----------/
```

------------------------------------------------------------------------

## 5. Task 2 --- S3 Remote Backend

I created an S3 bucket:

``` text
terraweek-state-asma-2026
```

Region:

``` text
ca-central-1
```

I enabled S3 versioning.

### Why S3?

S3 provides remote storage for the Terraform state.

### Why versioning?

Versioning keeps previous object versions, which can help with recovery
if a state object is accidentally changed or deleted.

**Easy memory:**\
`S3 = remote state storage`\
`Versioning = previous state versions/recovery`

------------------------------------------------------------------------

## 6. State Locking

For the lab I created the DynamoDB table:

``` text
terraweek-state-lock
```

with:

``` text
LockID
```

The table reached:

``` text
ACTIVE
```

State locking prevents two Terraform operations from writing to the same
state at the same time.

``` text
Engineer A ---> gets lock ---> Terraform operation
Engineer B ---> blocked until lock is available
```

This is critical in team environments because concurrent state writes
can cause conflicts or corrupt state.

------------------------------------------------------------------------

## 7. Migrating State

I configured the S3 backend and ran:

``` bash
terraform init -migrate-state
```

Terraform asked:

``` text
Do you want to copy existing state to the new backend?
```

I entered:

``` text
yes
```

Terraform successfully configured the S3 backend.

Then I ran:

``` bash
terraform plan
```

Result:

``` text
No changes. Your infrastructure matches the configuration.
```

This confirmed that the migration preserved Terraform's knowledge of my
infrastructure.

------------------------------------------------------------------------

## 8. Deprecation Warning Seen in My Lab

My Terraform version displayed:

``` text
Warning: Deprecated Parameter

The parameter "dynamodb_table" is deprecated.
Use parameter "use_lockfile" instead.
```

This is useful interview knowledge.

The exercise demonstrated DynamoDB-based locking, while my installed
Terraform version warned that this backend parameter is deprecated and
recommended `use_lockfile`.

------------------------------------------------------------------------

## 9. Task 3 --- Testing State Locking

I opened two terminals in the same Terraform project.

One Terraform operation held the state lock. In the second terminal I
ran another Terraform command.

Terraform returned:

``` text
Error: Error acquiring the state lock
```

The output also contained:

``` text
ConditionalCheckFailedException:
The conditional request failed
```

and displayed a Lock ID.

This proved the state locking mechanism was working.

### Why locking matters

Without locking, two engineers could try to modify the same state
simultaneously. Locking allows only one state-writing operation at a
time.

### force-unlock

``` bash
terraform force-unlock <LOCK_ID>
```

Use this only for a stale lock and only after confirming that no
legitimate Terraform operation is still running.

------------------------------------------------------------------------

## 10. Task 4 --- Import Existing Resource

Sometimes an AWS resource already exists before Terraform starts
managing it.

I created the S3 bucket:

``` text
terraweek-import-test-asma-2026
```

Then I imported it:

``` bash
terraform import   -var="project_name=terraweek"   aws_s3_bucket.imported   terraweek-import-test-asma-2026
```

Terraform returned:

``` text
Import successful!
```

Afterward:

``` bash
terraform plan -var="project_name=terraweek"
```

returned:

``` text
No changes.
```

### Import vs create

**Create from scratch:**

``` text
Terraform code
     ↓
terraform apply
     ↓
Terraform creates AWS resource
```

**Import:**

``` text
Existing AWS resource
     ↓
terraform import
     ↓
Terraform associates it with a state address
```

Import is useful when a company already has manually created
infrastructure that now needs to be managed through Terraform.

------------------------------------------------------------------------

## 11. Task 5 --- State Surgery

I practiced:

``` bash
terraform state mv
terraform state rm
terraform import
```

### terraform state mv

I moved:

``` text
aws_s3_bucket.imported
```

to:

``` text
aws_s3_bucket.logs_bucket
```

Command:

``` bash
terraform state mv   aws_s3_bucket.imported   aws_s3_bucket.logs_bucket
```

I updated my Terraform resource name to match.

**Purpose:** move/rename a Terraform state address without recreating
the real resource.

Typical use: refactoring or renaming Terraform resources.

### terraform state rm

I ran:

``` bash
terraform state rm aws_s3_bucket.logs_bucket
```

This removed the resource from Terraform state but did **not** directly
delete the real S3 bucket.

**Easy memory:**
`state rm = Terraform forgets the object; AWS object remains.`

Then I re-imported the bucket so Terraform managed it again.

------------------------------------------------------------------------

## 12. Task 6 --- State Drift

Drift happens when real infrastructure is changed outside the intended
Terraform workflow.

My Terraform configuration expected the EC2 Name tag to be:

``` text
terraweek-dev-server
```

I manually changed it to:

``` text
ManuallyChanged
```

Then I ran:

``` bash
terraform plan -var="project_name=terraweek"
```

Terraform detected:

``` text
"ManuallyChanged" -> "terraweek-dev-server"
```

and showed:

``` text
Plan: 0 to add, 1 to change, 0 to destroy.
```

That was a real example of drift.

------------------------------------------------------------------------

## 13. Fixing Drift

There are two general choices:

**Option A:** Keep Terraform configuration as the desired truth and
apply it so AWS returns to that desired configuration.

**Option B:** If the manual change was intentional and approved, update
the Terraform configuration accordingly.

For my lab I chose Option A.

Terraform showed:

``` text
Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
```

I ran another plan and got:

``` text
No changes. Your infrastructure matches the configuration.
```

Drift was resolved.

### How teams reduce drift

Teams commonly restrict unnecessary console changes, manage
infrastructure through Terraform, use pull requests/code reviews,
control IAM access, and run infrastructure changes through CI/CD.

------------------------------------------------------------------------

## 14. Refresh / Refresh-Only

A refresh updates Terraform's knowledge using information from real
infrastructure.

A modern explicit workflow is:

``` bash
terraform apply -refresh-only
```

A refresh-only operation updates state to reflect remote changes without
performing the normal infrastructure reconciliation of a regular apply.

------------------------------------------------------------------------

## 15. Final Cleanup

After the lab I destroyed the temporary Terraform-managed
infrastructure.

Terraform returned:

``` text
Destroy complete! Resources: 9 destroyed.
```

I also deleted the DynamoDB locking table.

AWS showed:

``` text
TableStatus: DELETING
```

------------------------------------------------------------------------

## 16. S3 Versioning Cleanup Lesson

When I tried to delete the backend bucket with:

``` bash
aws s3 rb s3://terraweek-state-asma-2026 --force
```

AWS returned:

``` text
BucketNotEmpty
```

This happened because versioning was enabled. Removing the current
object was not enough; historical versions/delete markers still existed.

After removing the versions and delete marker, I deleted the bucket
successfully:

``` text
remove_bucket: terraweek-state-asma-2026
```

This was a useful practical lesson about how S3 versioning preserves
historical objects.

------------------------------------------------------------------------

## 17. Important Commands

  -----------------------------------------------------------------------
  Command                             Purpose
  ----------------------------------- -----------------------------------
  `terraform show`                    Show state in readable form

  `terraform state list`              List objects/addresses in state

  `terraform state show <address>`    Inspect one state object

  `terraform init -migrate-state`     Initialize backend and migrate
                                      state

  `terraform import`                  Associate an existing resource with
                                      Terraform state

  `terraform state mv`                Move/rename a state address

  `terraform state rm`                Remove an object from state without
                                      directly destroying it

  `terraform force-unlock`            Remove a stale lock

  `terraform apply -refresh-only`     Refresh recorded state without
                                      normal reconciliation

  `terraform plan`                    Preview differences/actions

  `terraform apply`                   Reconcile infrastructure with
                                      desired configuration

  `terraform destroy`                 Destroy Terraform-managed resources
  -----------------------------------------------------------------------

------------------------------------------------------------------------

# Interview Questions

## What is Terraform state?

Terraform state keeps Terraform's record of managed infrastructure and
maps Terraform resource addresses to real cloud objects.

## Why use remote state?

It gives teams a shared state location and is safer for collaboration
than separate local state files.

## Why use S3 versioning?

It preserves previous state object versions and can help with recovery.

## What is state locking?

It prevents concurrent Terraform operations from writing to the same
state.

## What happens if another operation already has the lock?

Terraform returns a state-lock error instead of allowing unsafe
concurrent state modification.

## What is terraform import?

It associates an already-existing infrastructure resource with a
Terraform resource address/state.

## Does terraform state rm destroy AWS infrastructure?

No. It removes the object from Terraform state; it does not directly
destroy the real resource.

## Why use terraform state mv?

To move or rename an existing state address during refactoring without
unnecessarily recreating the real infrastructure.

## What is state drift?

It is a difference between the intended Terraform configuration and the
real infrastructure, often caused by out-of-band/manual changes.

## How did I test drift?

I changed my EC2 Name tag to `ManuallyChanged`. Terraform plan detected
it and proposed restoring `terraweek-dev-server`.

## What is force-unlock?

It manually removes a stale Terraform state lock. It should only be used
after confirming no active operation owns the lock.

## What does state serial mean?

It is a revision counter for Terraform state snapshots.

------------------------------------------------------------------------

# My Day 64 Lab Flow

``` text
Reuse Day 63 infrastructure
        ↓
Inspect Terraform state
        ↓
Check serial number
        ↓
Create S3 backend bucket
        ↓
Enable S3 versioning
        ↓
Create DynamoDB lock table
        ↓
Configure remote backend
        ↓
terraform init -migrate-state
        ↓
Copy existing state to S3
        ↓
terraform plan → No changes
        ↓
Test locking using two terminals
        ↓
Error acquiring state lock
        ↓
Create/import existing S3 bucket
        ↓
Import successful
        ↓
terraform plan → No changes
        ↓
terraform state mv
        ↓
terraform state rm
        ↓
Re-import bucket
        ↓
Change EC2 Name manually
        ↓
terraform plan detects drift
        ↓
terraform apply fixes drift
        ↓
terraform plan → No changes
        ↓
terraform destroy
        ↓
9 resources destroyed
        ↓
Delete DynamoDB table
        ↓
Remove S3 versions/delete marker
        ↓
Delete backend S3 bucket
```

# Five Things to Remember Before an Interview

``` text
STATE  = Terraform's map/record of managed infrastructure
S3     = Remote state storage
LOCK   = Prevent concurrent state writes
IMPORT = Bring an existing resource under Terraform management
DRIFT  = Real infrastructure differs from desired Terraform configuration
```

## Day 64 Completed ✅

I successfully practiced Terraform state inspection, remote S3 state,
versioning, state migration, locking, importing existing infrastructure,
`state mv`, `state rm`, re-importing, drift detection, drift correction,
and complete AWS cleanup.
