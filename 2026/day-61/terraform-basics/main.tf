terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region = "ca-central-1"
}
resource "aws_s3_bucket" "day61_bucket_asma" {
  bucket = "asma-terraweek-day61-2026"
}
resource "aws_instance" "day61_ec2" {
  ami           = "ami-0f82f408f5558e47b"
  instance_type = "t2.micro"

  tags = {
    Name = "TerraWeek-Modified"
  }
}
