# Day 63 - Terraform Variables

variables in Terraform are quite important, as you need to hold values of names of instance, configs , etc.

We can create a variables.tf file which will hold all the variables.

```
variable "filename" {
default = "/home/ubuntu/terrform-tutorials/terraform-variables/demo-var.txt"
}
```

```
variable "content" {
default = "This is coming from a variable which was updated"
}
```

These variables can be accessed by var object in main.tf

## Task-01

- Create a local file using Terraform
  Hint:

```
resource "local_file" "devops" {
filename = var.filename
content = var.content
}
```

## Data Types in Terraform

## Map

```
variable "file_contents" {
type = map
default = {
"statement1" = "this is cool"
"statement2" = "this is cooler"
}
}
```

## Task-02

- Use terraform to demonstrate usage of List, Set and Object datatypes
- Put proper screenshots of the outputs

Use `terraform refresh`

To refresh the state by your configuration file, reloads the variables

# Video Course

I can imagine, Terraform can be tricky, so best to use a Free video Course for terraform [here](https://bit.ly/tws-terraform)

Happy Learning :)

[← Previous Day](../day62/README.md) | [Next Day →](../day64/README.md)
