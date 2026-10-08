variable "aws_region" {
  description = "Aws region fo Ansible"
  type        = string
  default     = "ca-central-1"
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_names" {
  description = "Names of EC2 instances maanged by Ansible"
  type        = list(string)


  default = [
  "web-server", "app-server", "db-server"]
}
variable "key_name" {
  description = "AWS key pair namr for SSH"
  type        = string
}
