#TODO
/* resource "local_file" "my_host_file" {
filename= "hosts"
 content={
  for name, instance in aws_instance.my_instance: name=> {
    public_ip=instance.public_ip
    user=var.instances[name].user

  }
}
}  */
