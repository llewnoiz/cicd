resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.aws.csp_prefix}-internet-gateway"
    Group = "${var.aws.csp_prefix}-network"
  }
}
