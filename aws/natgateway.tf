resource "aws_eip" "back_2a" {
  vpc   = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "back_2a" {
  allocation_id = aws_eip.back_2a.id
  subnet_id     = aws_subnet.front_2a.id

  tags = {
    Name = "devPart_natgw_back_2a"
    MN = "devPart"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_eip" "back_2c" {
  vpc   = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "back_2c" {
  allocation_id = aws_eip.back_2c.id
  subnet_id     = aws_subnet.front_2c.id

  tags = {
    Name = "devPart_natgw_back_2c"
    MN = "devPart"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gateway]
}

