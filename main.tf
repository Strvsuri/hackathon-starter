# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 3.21" # Optional but recommended in production
    }
  }
}

# Provider Block
provider "aws" {
  profile = "default" # AWS Credentials Profile configured on local desktop terminal  $HOME/.aws/credentials
  region  = "us-east-1"
}

# Resource Block
resource "aws_instance" "my-ec2" {
  ami                         = "${var.instance-ami}"
  instance_type               = "${var.instance-type}"
  associate_public_ip_address = true
  key_name                    = "${var.instance-key-name != "" ? var.instance-key-name : ""}"
  subnet_id                   = "${aws_subnet.subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
  tags = {
    Name = "${var.instance-tag-name}"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = "vpc-0ecbe74ef4008e3aa"
  cidr_block = "${var.subnet-cidr-block}"

  tags = {
    Name = "${var.subnet-tag-name}"
  }
}

resource "aws_security_group" "sg" {
  name   = "${var.sg-tag-name}"
  vpc_id = "vpc-0ecbe74ef4008e3aa"

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "22"
    to_port     = "22"
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "80"
    to_port     = "80"
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "27017"
    to_port     = "27017"
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "8080"
    to_port     = "8080"
  }

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    to_port     = "0"
  }

  tags = {
    Name = "${var.sg-tag-name}"
  }
}
