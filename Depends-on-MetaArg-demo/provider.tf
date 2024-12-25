# Terrafrom settings

terraform {
  required_version = "~>1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.82.2"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  region  = "ap-south-1"
  profile = "terraform_profile"
}