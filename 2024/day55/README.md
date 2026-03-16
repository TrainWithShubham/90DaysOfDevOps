# Day 55: Understanding Configuration Management with Ansible

## What's this Ansible?

Ansible is an open-source automation tool, or platform, used for IT tasks such as configuration management, application deployment, intraservice orchestration, and provisioning

# Task-01

- Installation of Ansible on AWS EC2 (Master Node)
  `sudo apt-add-repository ppa:ansible/ansible` `sudo apt update`
  `sudo apt install ansible`

# Task-02

- read more about Hosts file
  `sudo nano /etc/ansible/hosts ansible-inventory --list -y`

# Task-03

- Setup 2 more EC2 instances with same Private keys as the previous instance (Node)
- Copy the private key to master server where Ansible is setup
- Try a ping command using ansible to the Nodes.

Write a blog on this topic with screenshots in the most creative way and post it on linkedIn :)

happy learning...

[← Previous Day](../day54/README.md) | [Next Day →](../day56/README.md)
