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
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.test.id
  instance_type = "t2.micro"
  count = "2"

  tags = {
    Name = "Test_server-${count.index}"
  }
}