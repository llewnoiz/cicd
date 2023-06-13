#PUBLIC ELB

#ELB
resource "aws_lb" "alb" {

  for_each = {for lb in var.loadBalance: lb.name => lb }


  name               = "${var.aws.csp_prefix}-${each.value.name}-lb"
  internal           = each.value.internal
  load_balancer_type = each.value.type
  security_groups    = [for sg in each.value.securityGroup : aws_security_group.securityGroup[sg].id ]
  subnets            = [for sub in each.value.subnets : aws_subnet.subnets[sub].id ]
  idle_timeout       = 300

  tags = {
    Name = "${var.aws.csp_prefix}-lb"
    Group = "${var.aws.csp_prefix}-network"
  }
}
