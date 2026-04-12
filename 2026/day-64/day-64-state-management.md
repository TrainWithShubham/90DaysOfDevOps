# Day 64 — Terraform State Management and Remote Backends

## What is Terraform State?

The state file (`terraform.tfstate`) is the single source of truth in Terraform. It maps your `.tf` configuration to real-world cloud resources. Without it, Terraform has no memory of what it has created.

---

## Task 1 — Inspecting State

~~~bash
terraform show                             # Full human-readable state
terraform state list                       # All tracked resources
terraform state show aws_instance.<name>   # All attributes of a resource
terraform state show aws_vpc.<name>
~~~

**Key observations:**
- State stores far more attributes than what you define (auto-assigned IDs, ARNs, DNS names, etc.)
- The `serial` number inside `terraform.tfstate` increments on every change — it is Terraform's version counter for the state file.

---

## Task 2 — S3 Remote Backend Setup

### Why remote state?
Local state files are risky — one deleted file and Terraform loses all context.
Remote state in S3 gives you: persistence, shared access, encryption, and versioning.

### Step 1: Create backend infrastructure (AWS CLI)

~~~bash
# Create S3 bucket
aws s3api create-bucket \
  --bucket terraweek-state-<yourname> \
  --region ap-south-1 \
  --create-bucket-configuration LocationConstraint=ap-south-1

# Enable versioning (recover previous state if needed)
aws s3api put-bucket-versioning \
  --bucket terraweek-state-<yourname> \
  --versioning-configuration Status=Enabled

# Create DynamoDB table for state locking
aws dynamodb create-table \
  --table-name terraweek-state-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region ap-south-1
~~~

### Step 2: Configure backend in `main.tf`

~~~hcl
terraform {
  backend "s3" {
    bucket         = "terraweek-state-<yourname>"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraweek-state-lock"
    encrypt        = true
  }
}
~~~

### Step 3: Migrate state

~~~bash
terraform init   # Terraform prompts: "Copy existing state to new backend?" → Yes
terraform plan   # Should show: No changes (migration successful)
~~~

**Verification:** Check S3 bucket — you should see `dev/terraform.tfstate`.
Local `terraform.tfstate` becomes empty after migration.

---

## Task 3 — State Locking with DynamoDB

State locking prevents concurrent `terraform apply` runs from corrupting state.

**How to test:**
1. Terminal 1: `terraform apply` (wait at confirmation prompt)
2. Terminal 2: `terraform plan`
3. Terminal 2 shows a **lock error** with a Lock ID — proving locking works

**Why locking is critical in team environments:**
Without locking, two engineers running apply simultaneously can write conflicting state, leading to resource duplication or destruction.

~~~bash
# Only use when you are 100% sure no operation is running
terraform force-unlock <LOCK_ID>
~~~

---

## Task 4 — Importing Existing Resources

Not everything is created by Terraform. `terraform import` brings existing AWS resources under Terraform management.

### Steps

~~~bash
# 1. Manually create a bucket in AWS Console: terraweek-import-test-<yourname>

# 2. Write a minimal resource block in your .tf file
resource "aws_s3_bucket" "imported" {
  bucket = "terraweek-import-test-<yourname>"
}

# 3. Import the resource
terraform import aws_s3_bucket.imported terraweek-import-test-<yourname>

# 4. Verify
terraform plan        # Should show: No changes
terraform state list  # Imported bucket appears alongside other resources
~~~

**`terraform import` vs creating from scratch:**

| Aspect | `terraform import` | Create from scratch |
|---|---|---|
| Resource exists in AWS | Yes (pre-existing) | No (Terraform creates it) |
| State entry | Added manually via import | Added automatically on apply |
| Risk | Config must match reality exactly | Terraform manages from day 1 |
| Use case | Adopt unmanaged resources | Greenfield infrastructure |

---

## Task 5 — State Surgery: mv and rm

### Rename a resource in state

~~~bash
terraform state list
terraform state mv aws_s3_bucket.imported aws_s3_bucket.logs_bucket
# Update the resource name in your .tf file to match
terraform plan   # Should show: No changes
~~~

**When to use `state mv`:**
- Refactoring resource names without destroying/recreating
- Moving resources between modules

### Remove a resource from state (without destroying in AWS)

~~~bash
terraform state rm aws_s3_bucket.logs_bucket
terraform plan   # Terraform no longer tracks it, but it still exists in AWS
~~~

**When to use `state rm`:**
- Handing a resource off to another team/config
- Intentionally excluding a resource from Terraform management

### Re-import to bring it back

~~~bash
terraform import aws_s3_bucket.logs_bucket terraweek-import-test-<yourname>
~~~

---

## Task 6 — Simulating and Fixing State Drift

**State drift** happens when infrastructure is changed outside Terraform (via console, CLI, or another tool).

### Simulate drift

1. Apply your full config (clean state)
2. In AWS Console: manually change EC2 instance Name tag to `"ManuallyChanged"`
3. Run `terraform plan` → Terraform detects the diff

### Fix drift

~~~bash
# Option A: Force reality back to match config (reconcile)
terraform apply

# Option B: Accept the drift — update .tf to match the manual change

# After applying Option A:
terraform plan   # Shows: No changes. Drift resolved.
~~~

### How teams prevent drift in production
- Restrict AWS Console/CLI access via IAM (make Terraform the only change mechanism)
- Use CI/CD pipelines for all infrastructure changes (no manual applies)
- Use `terraform apply -refresh-only` periodically to detect drift early

---

## Key Commands Reference

| Command | Purpose |
|---|---|
| `terraform state list` | List all tracked resources |
| `terraform state show <resource>` | Show all attributes of a resource |
| `terraform state mv <old> <new>` | Rename resource in state |
| `terraform state rm <resource>` | Remove from state (not from AWS) |
| `terraform import <resource> <id>` | Import existing AWS resource into state |
| `terraform force-unlock <LOCK_ID>` | Release a stale state lock (use with caution) |
| `terraform apply -refresh-only` | Update state to match real infra, no changes applied |
| `terraform init -migrate-state` | Explicitly trigger state migration to new backend |

---

## Local State vs Remote State

~~~
Local State                          Remote State (S3 + DynamoDB)
─────────────────────────────────    ──────────────────────────────────────
terraform.tfstate (on disk)          s3://bucket/dev/terraform.tfstate
No locking                           DynamoDB table handles locking
Single user only                     Team-safe, concurrent access managed
Lost if file deleted                 Versioned, recoverable
Not encrypted                        encrypt = true in backend block
~~~

---

## Summary

- **Remote backend** = state stored in S3, safe from accidental deletion
- **DynamoDB locking** = prevents concurrent state corruption in team environments
- **`terraform import`** = adopt pre-existing resources without recreating them
- **State surgery** (`mv`, `rm`) = restructure state without touching real infrastructure
- **Drift** = reality diverging from config; fixed with `terraform apply` or config update

---

*Day 64 of #90DaysOfDevOps | #TerraWeek | #TrainWithShubham*
