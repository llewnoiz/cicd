#VPC
resource "aws_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"

  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "devPart_vpc"
    MN = "devPart"
  }
}


resource "aws_ec2_managed_prefix_list" "vpc_list" {
  name           = "All VPC CIDR-s"
  address_family = "IPv4"
  max_entries    = 50

  entry {
    cidr        = "58.142.5.4/32"
    description = "bespin"
  }

  entry {
    cidr        = "58.142.5.252/32"
    description = "bespin"
  }

  entry {
    cidr        = "58.151.93.17/32"
    description = "bespin"
  }

  entry {
    cidr        = "58.151.93.2/32"
    description = "bespin"
  }
  entry {
    cidr        = "175.117.6.99/32"
    description = "bespin"
  }
  entry {
    cidr        = "122.43.118.86/32"
    description = "bespin"
  }



  tags = {
    Name = "devPart_vpc_prefix_list"
    MN = "devPart"
  }
}
# VPC OUPUT
output "vpc_id" {
    description = "vpc id"
    value = aws_vpc.vpc.id
}

output "vpc_name" {
    description = "vpc name"
    value = aws_vpc.vpc.tags.Name
}

output "vpc_cidr" {
    description = "vpc cidr"
    value = aws_vpc.vpc.cidr_block
}


