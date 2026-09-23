variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  type        = string
  default     = "us-west-2"
}

variable "instances" {
  description = "Map of instance names to AMI IDs, SSH users, and OS family"

  type = map(object({
    ami           = string
    user          = string
    os_family     = string
    instance_type = string
  }))

  # default value for instances
  default = {

    "control-node" = {
      ami           = "ami-0d76b909de1a0595d" # Ubuntu Server 24.04 LTS
      user          = "ubuntu"
      os_family     = "ubuntu"
      instance_type = "t3.micro"
    }

    "web-server" = {
      ami           = "ami-043ab4148b7bb33e9" # Amazon Linux
      user          = "ec2-user"
      os_family     = "amazon"
      instance_type = "t3.micro"
    }

    "app-server" = {
      ami           = "ami-04c7815cd1d6c8fa4" # RHEL 9
      user          = "ec2-user"
      os_family     = "redhat"
      instance_type = "t3.micro"
    }
     "db-server" = {
      ami           = "ami-04c7815cd1d6c8fa4" # RHEL 9
      user          = "ec2-user"
      os_family     = "redhat"
      instance_type = "t3.micro"
    }
  }
}
