# Day 62 - Terraform and Docker 🔥

Terraform needs to be told which provider to be used in the automation, hence we need to give the provider name with source and version.
For Docker, we can use this block of code in your main.tf

## Blocks and Resources in Terraform

## Terraform block

## Task-01

- Create a Terraform script with Blocks and Resources

```
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.21.0"
}
}
}
```

### Note: kreuzwerker/docker, is shorthand for registry.terraform.io/kreuzwerker/docker.

## Provider Block

The provider block configures the specified provider, in this case, docker. A provider is a plugin that Terraform uses to create and manage your resources.

```
provider "docker" {}
```

## Resource

Use resource blocks to define components of your infrastructure. A resource might be a physical or virtual component such as a Docker container, or it can be a logical resource such as a Heroku application.

Resource blocks have two strings before the block: the resource type and the resource name. In this example, the first resource type is docker_image and the name is Nginx.

## Task-02

- Create a resource Block for an nginx docker image

Hint:

```
resource "docker_image" "nginx" {
 name         = "nginx:latest"
 keep_locally = false
}
```

- Create a resource Block for running a docker container for nginx

```
resource "docker_container" "nginx" {
 image = docker_image.nginx.latest
 name  = "tutorial"
 ports {
   internal = 80
   external = 80
 }
}
```

Note: In case Docker is not installed

`sudo apt-get install docker.io`
`sudo docker ps`
`sudo chown $USER /var/run/docker.sock`

# Video Course

I can imagine, Terraform can be tricky, so best to use a Free video Course for terraform [here](https://bit.ly/tws-terraform)

Happy Learning :)

[← Previous Day](../day61/README.md) | [Next Day →](../day63/README.md)
