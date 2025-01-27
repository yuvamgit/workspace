vpc-cidr = "10.2.0.0/16"
public-subnet-cidr = [ "10.2.0.0/19", "10.2.32.0/19", "10.2.64.0/19" ]
private-subnet-cidr = [ "10.2.96.0/19", "10.2.128.0/19", "10.2.160.0/19" ]
availability_zone = [ "ap-south-1a", "ap-south-1b", "ap-south-1c" ]
enable_dns_support = true

common-tags = {
  "ProjectName" = "Demo",
  "Environment" = "Production"
}