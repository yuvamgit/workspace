variable "amiid" {
  type        = string
  description = "amiid for ap-south-1 instances"
  default     = "ami-0fd05997b4dff7aac"
}

variable "ec2count" {
  type        = number
  description = "number of ec2 instaces"
  default     = 1
}

resource "aws_instance" "demo-server" {
  ami               = var.amiid
  instance_type     = "t2.micro"
  count             = var.ec2count
  availability_zone = "ap-south-1a"
  tags = {
    Name = "demo-server"
  }
}