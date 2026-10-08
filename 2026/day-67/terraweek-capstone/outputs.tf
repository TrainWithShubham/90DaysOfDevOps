output "environment" {
  value = local.environment
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "instance_id" {
  value = module.ec2_instance.instance_id
}

output "public_ip" {
  value = module.ec2_instance.public_ip
}
