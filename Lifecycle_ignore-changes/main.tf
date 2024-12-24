resource "aws_instance" "app-server" {
  ami               = "ami-0fd05997b4dff7aac"
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "Dev-server"
  }

  lifecycle {
    ignore_changes = [
      tags,
      #      instance_type,
      #      availability_zone

    ]
  }

}