#SUBNET
resource "aws_subnet" "front_2a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.0.0/27"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "devPart-192.168.0.0-27-front-2a"
  }
}


resource "aws_subnet" "front_2c" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.0.32/27"

  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "devPart-192.168.0.32-27-front-2c"
    MN = "devPart"
  }
}

resource "aws_subnet" "back_2a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.0.64/27"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "devPart-192.168.0.64-27-back-2a"
    MN = "devPart"
  }
}

resource "aws_subnet" "back_2c" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.0.96/27"

  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "devPart-192.168.0.96-27-back-2c"
    MN = "devPart"
  }
}


#SUBNET OUPUT

output "front_2a" {
    description = "front_2a"
    value = { 
        "id": "${aws_subnet.front_2a.id}" , 
        "cidr": "${aws_subnet.front_2a.cidr_block}",
        "zone": "${aws_subnet.front_2a.availability_zone}",
        "vpc": "${aws_subnet.front_2a.vpc_id}" 
    }
}

output "front_2c" {
    description = "front_2c"
    value = { 
            "id": "${aws_subnet.front_2c.id}" , 
            "cidr": "${aws_subnet.front_2c.cidr_block}",
            "zone": "${aws_subnet.front_2c.availability_zone}",
            "vpc": "${aws_subnet.front_2c.vpc_id}" 
        }
}

output "back_2a" {
    description = "back_2a"
    value = { 
            "id": "${aws_subnet.back_2a.id}" , 
            "cidr": "${aws_subnet.back_2a.cidr_block}",
            "zone": "${aws_subnet.back_2a.availability_zone}",
            "vpc": "${aws_subnet.back_2a.vpc_id}" 
        }
}

output "back_2c" {
    description = "back_2c"
    value = { 
            "id": "${aws_subnet.back_2c.id}" , 
            "cidr": "${aws_subnet.back_2c.cidr_block}",
            "zone": "${aws_subnet.back_2c.availability_zone}",
            "vpc": "${aws_subnet.back_2c.vpc_id}" 
        }
}
