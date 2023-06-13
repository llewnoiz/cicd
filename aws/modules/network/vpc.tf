#VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.aws.csp_prefix}-vpc"
    Group = "${var.aws.csp_prefix}-network"
  }
}

