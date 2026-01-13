# Day 66 - Terraform Hands-on Project - Build Your Own AWS Infrastructure with Ease using Infrastructure as Code (IaC) Techniques(Interview Questions) ☁️

Welcome back to your Terraform journey.

In the previous tasks, you have learned about the basics of Terraform, its configuration file, and creating an EC2 instance using Terraform. Today, we will explore more about Terraform and create multiple resources.

## Task:

- Create a VPC (Virtual Private Cloud) with CIDR block 10.0.0.0/16
- Create a public subnet with CIDR block 10.0.1.0/24 in the above VPC.
- Create a private subnet with CIDR block 10.0.2.0/24 in the above VPC.
- Create an Internet Gateway (IGW) and attach it to the VPC.
- Create a route table for the public subnet and associate it with the public subnet. This route table should have a route to the Internet Gateway.
- Launch an EC2 instance in the public subnet with the following details:
- AMI: ami-0557a15b87f6559cf
- Instance type: t2.micro
- Security group: Allow SSH access from anywhere
- User data: Use a shell script to install Apache and host a simple website
- Create an Elastic IP and associate it with the EC2 instance.
- Open the website URL in a browser to verify that the website is hosted successfully.

#### This Terraform hands-on task is designed to test your proficiency in using Terraform for Infrastructure as Code (IaC) on AWS. You will be tasked with creating a VPC, subnets, an internet gateway, and launching an EC2 instance with a web server running on it. This task will showcase your skills in automating infrastructure deployment using Terraform. It's a popular interview question for companies looking for candidates with hands-on experience in Terraform. That's it for today.

Happy Terraforming:)

[← Previous Day](../day65/README.md) | [Next Day →](../day67/README.md)
