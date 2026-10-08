variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "ingress_ports" {
  description = "Allowed inbound ports"
  type        = list(number)
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}
