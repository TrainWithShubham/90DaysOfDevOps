# Create the main VPC
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = merge(
    local.common_tags,
    var.extra_tags,
    {
      Name = "${local.name_prefix}-vpc"
    }
  )
}
# Create a public subnet inside the VPC
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true


  tags = merge(
    local.common_tags,
    var.extra_tags,
    {
      Name = "${local.name_prefix}-subnet"
    }
  )
}
# Create an Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, var.extra_tags, {
    Name = "${local.name_prefix}-igw"
  })
}
# Create a route table for internet access
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.internet_cidr
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(local.common_tags, var.extra_tags, {
    Name = "${local.name_prefix}-route-table"
  })
}
# Associate the public subnet with the public route table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
# Security Group for the EC2 server
resource "aws_security_group" "main" {
  name        = "TerraWeek-SG"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.allowed_ports

    content {
      description = "Allow port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.internet_cidr]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.internet_cidr]
  }

  tags = merge(local.common_tags, var.extra_tags, {
    Name = "${local.name_prefix}-sg"
  })
}
# Create EC2 instance in the public subnet
resource "aws_instance" "main" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.main.id]
  associate_public_ip_address = true
  tags = merge(
    local.common_tags,
    var.extra_tags,
    {
      Name     = "${local.name_prefix}-server"
      TestLock = "true"
    }
  )
}
# S3 bucket for application logs
resource "aws_s3_bucket" "logs" {
  bucket_prefix = "terraweek-app-logs-"

  depends_on = [aws_instance.main]

  tags = merge(local.common_tags, var.extra_tags, {
    Name = "${local.name_prefix}-logs"
  })
}
resource "aws_s3_bucket" "logs_bucket" {
  bucket = "terraweek-import-test-asma-2026"
}
