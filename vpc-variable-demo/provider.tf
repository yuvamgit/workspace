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
