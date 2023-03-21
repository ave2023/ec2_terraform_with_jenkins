terraform {
  required_version = ">=0.14"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }

  }
}


provider "aws" {
  region     = "us-west-2"
  profile = "arn:aws:iam::300250510459:user/common"
}
resource "aws_security_group" "vault_sg_jenkins" {
  name        = "vault_sg_test"
  description = "Allow ports for jenkins and Vault"
  ingress {
    from_port   = 8000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
resource "aws_instance" "my-ec2" {
  ami                    = "ami-00cf8fcabcdf3e0b7"
  instance_type          = "t2.large"
  vpc_security_group_ids = [aws_security_group.vault_sg_jenkins.id]

  tags = {
    "Name" = "Vault_Jenkins"
  }

}
