resource "aws_vpc" "demo-vpc" {
  cidr_block           = var.vpc-cidr
  enable_dns_support   = true
  enable_dns_hostnames = var.enable_dns_support
  tags                 = merge(var.common-tags, { "Name" = "demo-vpc" })
}

resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.demo-vpc.id
  count             = length(var.public-subnet-cidr)
  availability_zone = element(var.availability_zone, count.index)
  cidr_block        = element(var.public-subnet-cidr, count.index)

  tags = merge(var.common-tags,
  { "Name" = "demo-vpc-public-subnet-${count.index + 1}" })
}

resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.demo-vpc.id
  count             = length(var.private-subnet-cidr)
  availability_zone = element(var.availability_zone, count.index)
  cidr_block        = element(var.private-subnet-cidr, count.index)

  tags = merge(var.common-tags,
  { "Name" = "demo-vpc-private-subnet-${count.index + 1}" })
}

resource "aws_internet_gateway" "demo-vpc-igw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags   = merge(var.common-tags, { "Name" = "demo-vpc-igw" })
}

resource "aws_route_table" "pub-subnet-rt" {
  vpc_id = aws_vpc.demo-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-vpc-igw.id
  }
  tags = merge(var.common-tags, { "Name" = "demo-vpc-pub-sub-rt" })
}

resource "aws_route_table_association" "pub-sub-to-rt" {
  count          = length(var.public-subnet-cidr)
  subnet_id      = element(aws_subnet.public-subnet[*].id, count.index)
  route_table_id = aws_route_table.pub-subnet-rt.id
}

resource "aws_eip" "nat-gw-eip" {
  count = length(var.public-subnet-cidr)
  tags = merge(var.common-tags,
  { "Name" = "demo-vpc-eip-for-nat-gw-${count.index + 1}" })
}

resource "aws_nat_gateway" "nat-gw" {
  count         = length(var.public-subnet-cidr)
  allocation_id = element(aws_eip.nat-gw-eip[*].id, count.index)
  subnet_id     = element(aws_subnet.public-subnet[*].id, count.index)
  tags = merge(var.common-tags,
  { "Name" = "demo-vpc-nat-gw-${count.index + 1}" })
}

resource "aws_route_table" "pri-subnet-rt" {
  vpc_id = aws_vpc.demo-vpc.id
  count  = length(var.private-subnet-cidr)
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat-gw[*].id, count.index)
  }
  tags = merge(var.common-tags,
  { "Name" = "demo-vpc-pri-sub-rt-${count.index + 1}" })
}

resource "aws_route_table_association" "rt-nat-gw-association" {
  count          = length(var.private-subnet-cidr)
  subnet_id      = element(aws_subnet.private-subnet[*].id, count.index)
  route_table_id = element(aws_route_table.pri-subnet-rt[*].id, count.index)
}












