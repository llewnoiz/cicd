
#security group inline 만 처리시 dependency cycle 문제 발생, 서로 참조하는 상황에서 제약 사항생기기때문 , rule 필요
# json 통해 추후 변경

#ALB-PUBLIC-SEC
resource "aws_security_group_rule" "vpc_to_public_loadbalance_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.public_loadbalance.id}"
  cidr_blocks = [ "0.0.0.0/0"]
  description = "HTTP"
  
  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "vpc_to_public_loadbalance_443" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.public_loadbalance.id}"
  cidr_blocks = [ "0.0.0.0/0"]
  description = "HTTPS"

  lifecycle { create_before_destroy = true }
}

# resource "aws_security_group_rule" "nat2a_to_public_loadbalance" {
#   type                     = "ingress"
#   from_port                = 443
#   to_port                  = 443
#   protocol                 = "TCP"
#   security_group_id        = "${aws_security_group.public_loadbalance.id}"
#   cidr_blocks = [ "${aws_nat_gateway.back_2a.public_ip}/32"]
#   description = "${aws_nat_gateway.back_2a.tags.Name} : ${aws_nat_gateway.back_2a.public_ip}/32"
 
#   lifecycle { create_before_destroy = true }
# }

# resource "aws_security_group_rule" "nat2c_to_public_loadbalance" {
#   type                     = "ingress"
#   from_port                = 443
#   to_port                  = 443
#   protocol                 = "TCP"
#   security_group_id        = "${aws_security_group.public_loadbalance.id}"
#   cidr_blocks = [ "${aws_nat_gateway.back_2c.public_ip}/32"]
#   description = "${aws_nat_gateway.back_2c.tags.Name} : ${aws_nat_gateway.back_2c.public_ip}/32"
 
#   lifecycle { create_before_destroy = true }
# }

#ALB-PRIVATE-SEC


# VPC LINK to private_loadbalance

resource "aws_security_group_rule" "vpc_link_to_private_loadbalance" {
  type                     = "ingress"
  from_port                = 8101
  to_port                  = 8113
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.private_loadbalance.id}"
  cidr_blocks = ["${aws_vpc.vpc.cidr_block}"]
  description = "${aws_security_group.service_worker.name}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "service_worker_to_private_loadbalance" {
  type                     = "ingress"
  from_port                = 8101
  to_port                  = 8113
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.private_loadbalance.id}"
  source_security_group_id = "${aws_security_group.service_worker.id}"
  description = "${aws_security_group.service_worker.name}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "service_admin_to_private_loadbalance" {
  type                     = "ingress"
  from_port                = 8101
  to_port                  = 8113
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.private_loadbalance.id}"
  source_security_group_id = "${aws_security_group.service_admin.id}"
  description = "${aws_security_group.service_admin.name}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "service_sl_to_private_loadbalance" {
  type                     = "ingress"
  from_port                = 8101
  to_port                  = 8113
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.private_loadbalance.id}"
  source_security_group_id = "${aws_security_group.service_sl.id}"
  description = "${aws_security_group.service_sl.name}"

  lifecycle { create_before_destroy = true }
}


#DOCMENTDB-SEC
resource "aws_security_group_rule" "service_worker_to_documentdb" {

  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.documentdb.id}"
  source_security_group_id = "${aws_security_group.service_worker.id}"
  description = "${aws_security_group.service_worker.name}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "service_admin_to_documentdb" {

  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.documentdb.id}"
  source_security_group_id = "${aws_security_group.service_admin.id}"
  description = "${aws_security_group.service_admin.name}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "service_sl_to_documentdb" {

  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.documentdb.id}"
  source_security_group_id = "${aws_security_group.service_sl.id}"
  description = "${aws_security_group.service_sl.name}"

  lifecycle { create_before_destroy = true }
}


resource "aws_security_group_rule" "devpart_bastion" {

  type                     = "ingress"
  from_port                = 20002
  to_port                  = 20002
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.devpart_bastion.id}"
  # source_security_group_id = "${aws_security_group.devpart_bastion.id}"
  prefix_list_ids = [aws_ec2_managed_prefix_list.vpc_list.id]
  description = "${aws_security_group.devpart_bastion.name}"

  lifecycle { create_before_destroy = true }
}


resource "aws_security_group_rule" "devpart_bastion_to_documentdb" {

  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.documentdb.id}"
  source_security_group_id = "${aws_security_group.devpart_bastion.id}"
  description = "${aws_security_group.devpart_bastion.name}"

  lifecycle { create_before_destroy = true }
}

#EFS


#WORKER-SEC

resource "aws_security_group_rule" "service_worker_to_private_loadbalance_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.service_worker.id}"
  source_security_group_id = "${aws_security_group.private_loadbalance.id}"
  description = "${aws_security_group.private_loadbalance.name}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "service_worker_to_private_loadbalance_8110" {
  type                     = "ingress"
  from_port                = 8110
  to_port                  = 8110
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.service_worker.id}"
  source_security_group_id = "${aws_security_group.private_loadbalance.id}"
  description = "${aws_security_group.private_loadbalance.name}"
  
  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "service_worker_to_private_loadbalance_2049" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.service_worker.id}"  
  # source_security_group_id = "${aws_security_group.private_loadbalance.id}"
  cidr_blocks = ["0.0.0.0/0"]
  description = "NFS MOUNT"
  
  lifecycle { create_before_destroy = true }
}



#SVC-SL
resource "aws_security_group_rule" "service_sl_to_private_loadbalance_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.service_sl.id}"
  source_security_group_id = "${aws_security_group.private_loadbalance.id}"
  description = "${aws_security_group.private_loadbalance.name}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "service_sl_to_private_loadbalance_8109" {
  type                     = "ingress"
  from_port                = 8109
  to_port                  = 8109
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.service_sl.id}"
  source_security_group_id = "${aws_security_group.private_loadbalance.id}"
  description = "${aws_security_group.private_loadbalance.name}"
  
  lifecycle { create_before_destroy = true }
}

#SVC-ADMIN
resource "aws_security_group_rule" "service_admin_to_private_loadbalance_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.service_admin.id}"
  source_security_group_id = "${aws_security_group.private_loadbalance.id}"
  description = "${aws_security_group.private_loadbalance.name}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "service_admin_to_private_loadbalance_8111" {
  type                     = "ingress"
  from_port                = 8111
  to_port                  = 8111
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.service_admin.id}"
  source_security_group_id = "${aws_security_group.private_loadbalance.id}"
  description = "${aws_security_group.private_loadbalance.name}"

  lifecycle { create_before_destroy = true }
}

#APP-SL
resource "aws_security_group_rule" "app_sl_to_public_loadbalance_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.app_sl.id}"
  source_security_group_id = "${aws_security_group.public_loadbalance.id}"
  description = "${aws_security_group.public_loadbalance.name}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "app_sl_to_public_loadbalance_8084" {
  type                     = "ingress"
  from_port                = 8084
  to_port                  = 8084
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.app_sl.id}"
  source_security_group_id = "${aws_security_group.public_loadbalance.id}"
  description = "${aws_security_group.public_loadbalance.name}"

  lifecycle { create_before_destroy = true }
}

#APP-ADMIN
resource "aws_security_group_rule" "app_admin_to_public_loadbalance_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.app_admin.id}"
  source_security_group_id = "${aws_security_group.public_loadbalance.id}"
  description = "${aws_security_group.public_loadbalance.name}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "app_admin_to_public_loadbalance_8085" {
  type                     = "ingress"
  from_port                = 8085
  to_port                  = 8085
  protocol                 = "TCP"
  security_group_id        = "${aws_security_group.app_admin.id}"
  source_security_group_id = "${aws_security_group.public_loadbalance.id}"
  description = "${aws_security_group.public_loadbalance.name}"

  lifecycle { create_before_destroy = true }
}