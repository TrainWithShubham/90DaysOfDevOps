# Day 69 - Meta-Arguments in Terraform

When you define a resource block in Terraform, by default, this specifies one resource that will be created. To manage several of the same resources, you can use either count or for_each, which removes the need to write a separate block of code for each one. Using these options reduces overhead and makes your code neater.

count is what is known as a ‘meta-argument’ defined by the Terraform language. Meta-arguments help achieve certain requirements within the resource block.

## Count

The count meta-argument accepts a whole number and creates the number of instances of the resource specified.

When each instance is created, it has its own distinct infrastructure object associated with it, so each can be managed separately. When the configuration is applied, each object can be created, destroyed, or updated as appropriate.

eg.

```

terraform {

required_providers {

aws = {

source = "hashicorp/aws"

version = "~> 4.16"

}

}

required_version = ">= 1.2.0"

}



provider "aws" {

region = "us-east-1"

}



resource "aws_instance" "server" {

count = 4



ami = "ami-08c40ec9ead489470"

instance_type = "t2.micro"



tags = {

Name = "Server ${count.index}"

}

}



```

## for_each

Like the count argument, the for_each meta-argument creates multiple instances of a module or resource block. However, instead of specifying the number of resources, the for_each meta-argument accepts a map or a set of strings. This is useful when multiple resources are required that have different values. Consider our Active directory groups example, with each group requiring a different owner.

```

terraform {

required_providers {

aws = {

source = "hashicorp/aws"

version = "~> 4.16"

}

}

required_version = ">= 1.2.0"

}



provider "aws" {

region = "us-east-1"

}



locals {

ami_ids = toset([

"ami-0b0dcb5067f052a63",

"ami-08c40ec9ead489470",

])

}



resource "aws_instance" "server" {

for_each = local.ami_ids



ami = each.key

instance_type = "t2.micro"

tags = {

Name = "Server ${each.key}"

}

}



Multiple key value iteration

locals {

ami_ids = {

"linux" :"ami-0b0dcb5067f052a63",

"ubuntu": "ami-08c40ec9ead489470",

}

}



resource "aws_instance" "server" {

for_each = local.ami_ids



ami = each.value

instance_type = "t2.micro"



tags = {

Name = "Server ${each.key}"

}

}

```

## Task-01

- Create the above Infrastructure as code and demonstrate the use of Count and for_each.
- Write about meta-arguments and its use in Terraform.

Happy learning :)

[← Previous Day](../day68/README.md) | [Next Day →](../day70/README.md)
