terraform {
  backend "s3" {
    bucket         = "terraweek-state-asma-2026"
    key            = "dev/terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "terraweek-state-lock"
    encrypt        = true
  }
}
