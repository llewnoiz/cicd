
resource "aws_security_group_rule" "cidr_blocks" {
  for_each = {for rule in var.securityGroupRuleByCidr : rule.name => rule}

  type                     = each.value.type
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  security_group_id        = aws_security_group.securityGroup[each.value.security_group_id].id
  cidr_blocks = each.value.cidr_blocks
  description = "${each.value.security_group_id}: ${each.value.from_port} to ${each.value.to_port}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "source_security_group_id" {

  for_each = {for rule in var.securityGroupRuleById : rule.name => rule}

  type                     = each.value.type
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  security_group_id        = aws_security_group.securityGroup[each.value.security_group_id].id
  source_security_group_id = aws_security_group.securityGroup[each.value.source_security_group_id].id
  description = "${each.value.security_group_id} to ${each.value.source_security_group_id}"

  lifecycle { create_before_destroy = true }
}
