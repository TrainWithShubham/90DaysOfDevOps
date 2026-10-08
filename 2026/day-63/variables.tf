variable "region" {
  description = "AWS region"
  type        = string
  default     = "ca-central-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Subnet CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "allowed_ports" {
  description = "Allowed ports"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "extra_tags" {
  description = "Extra resource tags"
  type        = map(string)
  default     = {}
}
variable "internet_cidr" {
  description = "CIDR block for internet access"
  type        = string
  default     = "0.0.0.0/0"
}
