resource "aws_route_table" "main_tables" {

  for_each = {for router in var.routetables: router.name => router if router.main == true }
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.aws.csp_prefix}-${each.value.name}-rt"
    Group = "${var.aws.csp_prefix}-network"
  }
}

resource "aws_route" "main_routes" {
  for_each = {for router in var.routetables: router.name => router if router.main == true }
  route_table_id              = aws_route_table.main_tables[each.value.name].id
  destination_cidr_block      = each.value.cidr_block
  gateway_id                  = aws_internet_gateway.internet_gateway.id

  depends_on = [
    aws_internet_gateway.internet_gateway,
    aws_route_table.main_tables
  ]
}

resource "aws_route_table" "sub_tables" {

  for_each = {for router in var.routetables: router.name => router if router.main != true }
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.aws.csp_prefix}-${each.value.name}-rt"
    Group = "${var.aws.csp_prefix}-network"
  }
}

resource "aws_route" "sub_routes" {
  for_each = {for router in var.routetables: router.name => router if router.main != true }
  route_table_id              = aws_route_table.sub_tables[each.value.name].id
  destination_cidr_block      = "0.0.0.0/0"
  nat_gateway_id              = aws_nat_gateway.natgateway[each.value.name].id

  depends_on = [
    aws_nat_gateway.natgateway,
    aws_route_table.sub_tables
  ]
}



resource "aws_default_route_table" "default" {

  for_each = {for router in var.routetables: router.name => router if router.main == true }

  default_route_table_id = aws_route_table.main_tables[each.value.name].id

  tags = {
    Name = "${var.aws.csp_prefix}-${each.value.name}-default-rt"
    Group = "${var.aws.csp_prefix}-network"
  }

  depends_on = [
    aws_route_table.main_tables
  ]
}
#
resource "aws_main_route_table_association" "default" {

  for_each = {for router in var.routetables: router.name => router if router.main == true }

  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_default_route_table.default[each.value.name].id

  depends_on = [
    aws_default_route_table.default
  ]
}

resource "aws_route_table_association" "routeWithSubnet" {

  for_each = {for router in var.routeWithSubnet: router.subnet => router }

  subnet_id      = aws_subnet.subnets[each.value.subnet].id
  route_table_id = each.value.main == false ?  aws_route_table.sub_tables[each.value.router].id : aws_route_table.main_tables[each.value.router].id
}

