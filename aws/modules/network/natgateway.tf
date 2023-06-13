resource "aws_eip" "eips" {

  for_each = { for natgateway in var.natgateways: natgateway.name => natgateway }

  vpc   = each.value.eip

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.aws.csp_prefix}-eip-${each.value.name}"
    Group = "${var.aws.csp_prefix}-network"
  }
}

resource "aws_nat_gateway" "natgateway" {

  for_each = { for natgateway in var.natgateways: natgateway.name => natgateway }

  allocation_id = aws_eip.eips[each.key].id
  subnet_id     = aws_subnet.subnets[each.value.connected].id

  tags = {
    Name = "${var.aws.csp_prefix}-nat-gateway-${each.value.name}"
    Group = "${var.aws.csp_prefix}-network"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gateway]
}

