resource "aws_instance" "sing-server" {
  ami           = "ami-0995922d49dc9a17d"
  instance_type = "t2.micro"
  provider      = aws.singapore

  tags = {
    Name = "Sing_server"
  }
}