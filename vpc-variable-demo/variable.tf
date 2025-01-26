variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "vpc-cidr" {
  type        = string
  default     = "10.1.0.0/24"
  description = "CIDR for VPC"
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "public-subnet-cidr" {
  type    = list(string)
  default = ["10.1.0.0/26", "10.1.0.128/26"]
}

variable "private-subnet-cidr" {
  type    = list(string)
  default = ["10.1.0.64/26", "10.1.0.192/26"]
}

variable "availability_zone" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "common-tags" {
  type = map(string)
  default = {
    "Project-Name" = "Demo"
    "Environment"  = "Dev"
  }
  description = "Common tags for demo project"
}




