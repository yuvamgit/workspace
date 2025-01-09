terraform {
  required_version = "~>1.9"
  required_providers {
    aws = {
      version = "~> 5.82.2"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "terraform_profile"
  region  = "ap-south-1"
}

resource "aws_vpc" "demo-vpc" {
  cidr_block           = "192.168.0.0/24"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_subnet" "public-subnet-1a" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = "192.168.0.0/26"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1a"
  }
}

resource "aws_subnet" "private-subnet-1a" {
  vpc_id            = aws_vpc.demo-vpc.id
  cidr_block        = "192.168.0.64/26"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "private-subnet-1a"
  }
}

resource "aws_subnet" "public-subnet-1b" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = "192.168.0.128/26"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1b"
  }
}

resource "aws_subnet" "private-subnet-1b" {
  vpc_id            = aws_vpc.demo-vpc.id
  cidr_block        = "192.168.0.192/26"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "private-subnet-1b"
  }
}

# Intergateway for both Availability Zone
resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "demo-vpc-igw"
  }
}

resource "aws_route_table" "igw-rt" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }

  tags = {
    Name = "demo-vpc-igw-rt"
  }
}

resource "aws_route_table_association" "rt-to-public-subnet-1a" {
  subnet_id      = aws_subnet.public-subnet-1a.id
  route_table_id = aws_route_table.igw-rt.id
}

resource "aws_route_table_association" "rt-to-public-subnet-1b" {
  subnet_id      = aws_subnet.public-subnet-1b.id
  route_table_id = aws_route_table.igw-rt.id
}

################    Part two  ################

resource "aws_eip" "eip-nat-1a" {
  domain = "vpc" # (Optional) Indicates if this EIP is for use in VPC

  tags = {
    Name = "Eip-NatGateway-1a"
  }
}

resource "aws_nat_gateway" "nat-gw-1a" {
  allocation_id = aws_eip.eip-nat-1a.id
  subnet_id     = aws_subnet.public-subnet-1a.id

  tags = {
    Name = "demo-vpc-nat-gw-1a"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.demo-igw]
}

resource "aws_eip" "eip-nat-1b" {
  domain = "vpc" # (Optional) Indicates if this EIP is for use in VPC

  tags = {
    Name = "Eip-NatGateway-1b"
  }
}

resource "aws_nat_gateway" "nat-gw-1b" {
  allocation_id = aws_eip.eip-nat-1b.id
  subnet_id     = aws_subnet.public-subnet-1b.id

  tags = {
    Name = "demo-vpc-nat-gw-1b"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.demo-igw]
}

resource "aws_route_table" "pri-rt-for-nat-1a" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-1a.id
  }

  tags = {
    Name = "demo-vpc-pri-rt-for-nat-1a"
  }
}

resource "aws_route_table_association" "nat-to-private-subnet-1a" {
  subnet_id      = aws_subnet.private-subnet-1a.id
  route_table_id = aws_route_table.pri-rt-for-nat-1a.id
}


resource "aws_route_table" "pri-rt-for-nat-1b" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-1b.id
  }

  tags = {
    Name = "demo-vpc-pri-rt-for-nat-1b"
  }
}

resource "aws_route_table_association" "nat-to-private-subnet-1b" {
  subnet_id      = aws_subnet.private-subnet-1b.id
  route_table_id = aws_route_table.pri-rt-for-nat-1b.id
}
