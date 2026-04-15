output "instance_details" {
  description = "Public IPs and SSH users for each instance"
  value = {
    for name, instance in aws_instance.my_instance : name => {
      public_ip  = instance.public_ip
      public_dns = instance.public_dns
      ssh_user   = var.instances[name].user
      os_family  = var.instances[name].os_family
    }
  }
}