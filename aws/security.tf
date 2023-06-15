#ALB-PUBLIC-SEC
resource "aws_security_group" "public_loadbalance" {
  name        = "devPart-public-loadbalance-security"
  description = "public-loadbalance security"
  vpc_id      = aws_vpc.vpc.id
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "devPart-public-loadbalance"
    MN = "devPart"
  }
}

#ALB-PRIVATE-SEC
resource "aws_security_group" "private_loadbalance" {
  name        = "devPart-private-loadbalance-security"
  description = "private-loadbalance-security"
  vpc_id      = aws_vpc.vpc.id
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "devPart-private-loadbalance-security"
    MN = "devPart"
  }
}

#DOCMENTDB-SEC
resource "aws_security_group" "documentdb" {
  name        = "devPart-documentdb-security"
  description = "documentdb security"
  vpc_id      = aws_vpc.vpc.id
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "devPart-documentdb-security"
    MN = "devPart"
  }
}

#WORKER-SEC
resource "aws_security_group" "service_worker" {
  name        = "devPart-service_worker-security"
  description = "servie-worker-security"
  vpc_id      = aws_vpc.vpc.id
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "devPart-servie-worker-security"
    MN = "devPart"
  }
}

#SVC-SL
resource "aws_security_group" "service_sl" {
  name        = "devPart-service-sl-security"
  description = "devPart-service-sl-security"
  vpc_id      = aws_vpc.vpc.id
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "devPart-service-sl-security"
    MN = "devPart"
  }
}

#SVC-ADMIN
resource "aws_security_group" "service_admin" {
  name        = "devPart-service-admin-security"
  description = "devPart-service-admin-security"
  vpc_id      = aws_vpc.vpc.id
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "devPart-service-admin-security"
    MN = "devPart"
  }
}

#APP-SL
resource "aws_security_group" "app_sl" {
  name        = "devPart-app-sl-security"
  description = "devPart-app-sl-security"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "devPart-app-sl-security"
    MN = "devPart"
  }
}

#APP-ADMIN
resource "aws_security_group" "app_admin" {
  name        = "devPart-app-admin-security"
  description = "devPart-app-admin-security"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devPart-app-admin-security"
    MN = "devPart"
  }
}

#EFS
resource "aws_security_group" "provision_efs" {
  name        = "devPart-provision-efs-security"
  description = "devPart-provision-efs-security"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devPart-provision-efs-security"
    MN = "devPart"
  }
}


resource "aws_security_group" "devpart_bastion" {
  name        = "devPart-bastion-security"
  description = "devPart-bastion-security"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devPart-bastion-security"
    MN = "devPart"
  }
}