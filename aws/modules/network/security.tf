#data "aws_vpc" "selected" {
#  filter {
#    name   = "tag:Name"
#    values = ["${var.csl_pre}-vpc"]
#  }
#}

resource "aws_security_group" "securityGroup" {

  for_each = {for security in var.securityGroup: security.name => security }

  name        = "${each.value.name}-sg"
  description = "${each.value.name}-security"
#  vpc_id      = data.aws_vpc.selected.id
  vpc_id      = aws_vpc.vpc.id
  egress {
    from_port        = each.value.egress.from_port
    to_port          = each.value.egress.to_port
    protocol         = each.value.egress.protocol
    cidr_blocks      = each.value.egress.cidr_blocks
  }
  tags = {
    Name = "${var.aws.csp_prefix}-${each.value.name}-sg"
    Group = "${var.aws.csp_prefix}-security"
  }
}
