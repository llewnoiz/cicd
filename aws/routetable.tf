resource "aws_default_route_table" "default" {
  default_route_table_id = aws_route_table.front.id
  # default_route_table_id = aws_vpc.vpc.default_route_table_id
  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_internet_gateway.internet_gateway.id
  # }
  
  timeouts {
     create = "5m"
   }

  tags = {
    Name = "default route tables devPart_route_table_front"
    MN = "devPart"
  }
}

resource "aws_main_route_table_association" "default" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_default_route_table.default.id
}

# resource "aws_route_table_association" "front_2a" {
#   subnet_id      = aws_subnet.front_2a.id
#   route_table_id = aws_route_table.front.id
# }

# resource "aws_route_table_association" "front_2c" {
#   subnet_id      = aws_subnet.front_2c.id
#   route_table_id = aws_route_table.front.id
# }


resource "aws_route_table" "front" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "devPart_route_table_front"
    MN = "devPart"
  }
}

resource "aws_route_table" "back_2a" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "devPart_route_table_back_2a"
    MN = "devPart"
  }
}

resource "aws_route_table" "back_2c" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "devPart_route_table_back_2c"
    MN = "devPart"
  }
}


resource "aws_route_table_association" "front_2a" {
  subnet_id      = aws_subnet.front_2a.id
  route_table_id = aws_route_table.front.id
}

resource "aws_route_table_association" "front_2c" {
  subnet_id      = aws_subnet.front_2c.id
  route_table_id = aws_route_table.front.id
}

resource "aws_route_table_association" "back_2a" {
  subnet_id      = aws_subnet.back_2a.id
  route_table_id = aws_route_table.back_2a.id
}

resource "aws_route_table_association" "back_2c" {
  subnet_id      = aws_subnet.back_2c.id
  route_table_id = aws_route_table.back_2c.id
}

resource "aws_route" "front" {
  route_table_id              = aws_route_table.front.id
  destination_cidr_block      = "0.0.0.0/0"
  gateway_id                  = aws_internet_gateway.internet_gateway.id
}

resource "aws_route" "back_2a" {
  route_table_id              = aws_route_table.back_2a.id
  destination_cidr_block      = "0.0.0.0/0"
  nat_gateway_id              = aws_nat_gateway.back_2a.id
}

resource "aws_route" "back_2c" {
  route_table_id              = aws_route_table.back_2c.id
  destination_cidr_block      = "0.0.0.0/0"
  nat_gateway_id              = aws_nat_gateway.back_2c.id
}