#SUBNET
resource "aws_subnet" subnets{

  for_each = { for subnet in var.subnets: subnet.name => subnet }

  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value.cidr

  availability_zone = "${var.aws.region}${each.value.zone}"

  tags = {
    Name = "${var.aws.csp_prefix}-sub-${each.value.cidr}-${each.value.name}"
    Group = "${var.aws.csp_prefix}-network"
  }
}

