resource "aws_instance" "dev-server" {
  ami           = "ami-0fd05997b4dff7aac"
  instance_type = "t2.micro"

  tags = {
    Name        = "server"
    Environment = "Dev"
  }

  depends_on = [
    aws_s3_bucket.s3-bucket
  ]
}

resource "aws_s3_bucket" "s3-bucket" {
  bucket = "my-s3-bucket-${random_string.s3-bucket.id}"

  tags = {
    Environment = "Dev"
  }
}

resource "random_string" "s3-bucket" {
  length  = 15
  upper   = false
  special = false
}