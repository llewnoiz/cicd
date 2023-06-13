output "netowork" {
  value = {
    "subnet": [
      for subnet in var.subnets: { "${subnet.name}": { "id": aws_subnet.subnets[subnet.name].id, "cidr": aws_subnet.subnets[subnet.name].cidr_block } }
    ],
    "vpc": {
      "id": aws_vpc.vpc.id,
      "cidr": aws_vpc.vpc.cidr_block
    },
    "targetGroup": [
      for tg in var.targetGroups: { "${tg.name}" : { "id": aws_lb_target_group.targetGroup[tg.name].id, "arn": aws_lb_target_group.targetGroup[tg.name].arn, "port":aws_lb_target_group.targetGroup[tg.name].port } }
    ]
    "elb": [
      for lb in var.loadBalance: { "${lb.name}" : { "id": aws_lb.alb[lb.name].id, "arn": aws_lb.alb[lb.name].arn, "dns": aws_lb.alb[lb.name].dns_name, "security": aws_lb.alb[lb.name].security_groups,}}
    ],
    "securityGroup": [
      for security in var.securityGroup: { "${security.name}": { "id": aws_security_group.securityGroup[security.name].id, "ingress": aws_security_group.securityGroup[security.name].ingress, "egress": aws_security_group.securityGroup[security.name].egress } }
    ]
  }
}