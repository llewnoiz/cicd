#APP-SL
resource "aws_lb_target_group" "targetGroup" {

  for_each = { for tg in var.targetGroups: tg.name => tg }
  name        = each.value.name
  target_type = each.value.type
  port        = each.value.port
  protocol    = each.value.protocol
  vpc_id      = aws_vpc.vpc.id

  health_check {
    enabled = each.value.health.enabled
    protocol = each.value.health.protocol
    path = each.value.health.path
    matcher = each.value.health.matcher
    interval = each.value.health.interval
    healthy_threshold  = each.value.health.healthy_threshold
    unhealthy_threshold = each.value.health.unhealthy_threshold
  }

  tags = {
    Name = "${var.aws.csp_prefix}-${each.value.name}-tg"
    Group = "${var.aws.csp_prefix}-network"
  }
}
