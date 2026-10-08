variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "sg_name" {
  description = "Security group name"
  type        = string
}

variable "ingress_ports" {
  description = "Ports allowed for inbound traffic"
  type        = list(number)
  default     = [22, 80]
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
