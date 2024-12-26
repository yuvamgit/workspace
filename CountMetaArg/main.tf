/*
data "aws_ami" "test" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "ami-id" {
  value = data.aws_ami.test.id  
  description = "AMI id used to create instances in Mumbai region."   # optonal
#  ephemeral = true            # avoiding persisting those values to state or plan files
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.test.id
  instance_type = "t2.micro"
  count = "2"

  tags = {
    Name = "Test_server-${count.index}"
  }
}

*/



resource "random_string" "random-name" {
  length  = 10
  upper   = false
  special = false
  count   = 2
  # override_special = "/@£$"    # my understand

}

resource "aws_s3_bucket" "test-bucket" {
  bucket = "jack-s3-bucket-${count.index}-${random_string.random-name[count.index].id}"
  count  = 2

  tags = {
    Name = "bucket-${count.index}"
  }
}

