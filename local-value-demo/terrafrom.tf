terraform {
  required_version = "~>1.9"
  required_providers {
    aws = {
      version = "~> 5.82.2"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "terraform_profile"
  region  = "ap-south-1"
}

locals {
  server_micro      = "t2.micro"
  availability_zone = "ap-south-1a"
  server_medium     = "t2.medium"
  tags = {
    Name        = "Demo"
    Environment = "Dev"
    Managed-By  = "Terraform"
    Team        = "Devops"
  }
}

resource "aws_instance" "demo" {
  ami               = "ami-0fd05997b4dff7aac"
  instance_type     = local.server_micro
  availability_zone = local.availability_zone

  tags = local.tags
}