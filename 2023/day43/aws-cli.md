Here are some commonly used AWS CLI commands for Amazon S3:

`aws s3 ls` - This command lists all of the S3 buckets in your AWS account.

`aws s3 mb s3://bucket-name` - This command creates a new S3 bucket with the specified name.

`aws s3 rb s3://bucket-name` - This command deletes the specified S3 bucket.

`aws s3 cp file.txt s3://bucket-name` - This command uploads a file to an S3 bucket.

`aws s3 cp s3://bucket-name/file.txt .` - This command downloads a file from an S3 bucket to your local file system.

`aws s3 sync local-folder s3://bucket-name` - This command syncs the contents of a local folder with an S3 bucket.

`aws s3 ls s3://bucket-name` - This command lists the objects in an S3 bucket.

`aws s3 rm s3://bucket-name/file.txt` - This command deletes an object from an S3 bucket.

`aws s3 presign s3://bucket-name/file.txt` - This command generates a pre-signed URL for an S3 object, which can be used to grant temporary access to the object.

`aws s3api list-buckets` - This command retrieves a list of all S3 buckets in your AWS account, using the S3 API.
