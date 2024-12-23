# Terrafrom settings

terraform {
  required_version = "~>1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.82.2"
    }
  }
}

# aws provider configuration

provider "aws" {
  region  = "ap-south-1"
  profile = "terraform_profile"
}

provider "aws" {
  profile = "terraform_profile"
  region  = "ap-southeast-1"
  alias   = "singapore"
}