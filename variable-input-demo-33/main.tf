variable "amiid" {
  type        = string
  description = "amiid for ap-south-1[Mumbai] instances"
  default     = "ami-0fd05997b4dff7aac"
    validation {
     condition     = length(var.amiid) > 4 && substr(var.amiid, 0, 4) == "ami-"
     error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "ec2count" {
  type        = number
  description = "number of ec2 instaces"
  default     = 1
}


variable "az" {
  type = string
  default = "ap-south-1a"
  description = "AWS availability zone"
    validation {
      condition = contains(["ap-south-1a", "ap-south-1b", "ap-south-1c"], var.az)
      error_message = "Pleas specify correct availability zone from ap-south-1a or ap-south-1b"
    } 
}

variable "instancetype" {
  type = string
  default = "t2.medium"
  description = "Ec2 instance type"
}

resource "aws_instance" "demo-server" {
  ami               = var.amiid
  instance_type     = var.instancetype
  count             = var.ec2count
  availability_zone = var.az
  tags = {
    Name = "demo-server"
  }
}



/*

variable "ec2count" {     # this block used to get count in terraform plan/apply prompt.
}                         # very useful when there is no default value 

*/