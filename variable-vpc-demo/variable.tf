variable "aws-region" {
    type = string
    default = "ap-south-1a"
}

variable "aws-vpc-cidr" {
   type = string
   default = "10.1.0.0/24"
   description = "CIDR for VPC"
}

variable "public-subnet-cidr" {
    type = list(string)
    default = [ "10.1.0.0/26", "10.1.0.128/26" ]
}

variable "private-subnet-cidr" {
    type = list(string)
    default = [ "10.1.0.64/26", "10.1.0.192/26" ] 
}





