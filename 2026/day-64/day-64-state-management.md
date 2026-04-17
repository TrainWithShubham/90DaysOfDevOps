Task 1: Inspect Your Current State
- How many resources does Terraform track?
  Terraform tracks all resources defined in the configuration that have been successfully applied. In this setup, it tracks resources like VPC, Subnet, Internet Gateway, Route Table, Route Table Association, Security Group, and EC2 instance — typically around 6–7 resources depending on the configuration.
  
- What attributes does the state store for an EC2 instance? (hint: way more than what you defined)
  The Terraform state stores many more attributes than what we define in the configuration. For an EC2 instance, it includes details such as instance ID, AMI ID, instance type, public and private IP addresses, public DNS, subnet ID, VPC ID, security group IDs, availability zone, key name, tags, root block device details, and current instance state (running/stopped).
    
- Open terraform.tfstate in an editor -- find the serial number. What does it represent?
  The serial number represents the version of the state file. It increments every time Terraform updates the state, helping Terraform track changes and detect conflicts during operations.


Task 2: Set Up S3 Remote Backend
Storing state locally is dangerous -- one deleted file and you lose everything. Time to move it to S3.
- First, create the backend infrastructure (do this manually or in a separate Terraform config):
- Add the backend block to your Terraform config:
- Run terraform init
<img width="878" height="565" alt="image" src="https://github.com/user-attachments/assets/811ae381-974f-4ced-a40f-b7edc8c586e6" />

Task 3: Test State Locking
- What is the error message?
  Terraform throws an "Error acquiring the state lock" with a Lock ID, indicating that another operation is already using the state file.

- Why is locking critical?
  State locking prevents multiple users from modifying the same infrastructure at the same time. Without locking, concurrent terraform apply operations could overwrite the state file, leading to resource duplication, deletion, or infrastructure corruption. It ensures consistency and safety in team environments.


Task 4: Import an Existing Resource
Not everything starts with Terraform. Sometimes resources already exist in AWS and you need to bring them under Terraform management.
- Manually create an S3 bucket in the AWS console -- name it terraweek-import-test-<yourname>
- Write a resource "aws_s3_bucket" block in your config for this bucket (just the bucket name, nothing else)
- Import it terraform import aws_s3_bucket.imported terraweek-import-test-<yourname>
- Run terraform plan:
  - If you see "No changes" -- the import was perfect
  - If you see changes -- your config does not match reality. Update your config to match, then plan again until you get "No changes"
- Run terraform state list -- the imported bucket should now appear alongside your other resources
- Document: What is the difference between terraform import and creating a resource from scratch?
  terraform import brings an existing resource created outside Terraform into Terraform state without creating it again, whereas creating a resource from scratch using terraform apply provisions a new resource and tracks it in the state from the beginning.
<img width="1303" height="370" alt="image" src="https://github.com/user-attachments/assets/7342d107-de1e-43fe-92ed-f00be4878695" />


Task 5: State Surgery -- mv and rm
Sometimes you need to rename a resource or remove it from state without destroying it in AWS.
- Rename a resource in state: terraform state list                              # Note the current resource names
- terraform state mv aws_s3_bucket.imported aws_s3_bucket.logs_bucket
- Update your .tf file to match the new name. Run terraform plan -- it should show no changes.
- Remove a resource from state (without destroying it):terraform state rm aws_s3_bucket.logs_bucket
- Run terraform plan -- Terraform no longer knows about the bucket, but it still exists in AWS.
- Re-import it to bring it back: terraform import aws_s3_bucket.logs_bucket terraweek-import-test-<yourname>
- Document: When would you use state mv in a real project? When would you use state rm?
<img width="1322" height="320" alt="image" src="https://github.com/user-attachments/assets/e28054cc-7074-4873-8cb4-419d07030b0d" />


Task 6: Simulate and Fix State Drift
State drift happens when someone changes infrastructure outside of Terraform -- through the AWS console, CLI, or another tool.
- Apply your full config so everything is in sync
- Go to the AWS console and manually:
    - Change the Name tag of your EC2 instance to "ManuallyChanged"
    - Change the instance type if it's stopped (or add a new tag)
- Run: terraform plan
- You should see a diff -- Terraform detects that reality no longer matches the desired state.
- You have two choices:
  - Option A: Run terraform apply to force reality back to match your config (reconcile)
  - Option B: Update your .tf files to match the manual change (accept the drift)
  - Choose Option A -- apply and verify the tags are restored.
- Run terraform plan again -- it should show "No changes." Drift resolved.
- Document: How do teams prevent state drift in production? (hint: restrict console access, use CI/CD for all changes)
<img width="920" height="487" alt="image" src="https://github.com/user-attachments/assets/3b5079f6-200d-4801-84da-8bdb7ae0cf90" />




