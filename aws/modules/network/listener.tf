##PUBLIC ELB
##LISTENER FRONT 80
#resource "aws_lb_listener" "front_end_80" {
#  load_balancer_arn = aws_lb.public.arn
#  port              = "80"
#  protocol          = "HTTP"
#
#  default_action {
#    type = "redirect"
#
#    redirect {
#      port        = "443"
#      protocol    = "HTTPS"
#      status_code = "HTTP_301"
#    }
#  }
#}
#
##LISTENER FRONT 443
#resource "aws_lb_listener" "front_end_443" {
#  load_balancer_arn = aws_lb.public.arn
#  port              = "443"
#  protocol          = "HTTPS"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
#  certificate_arn   = aws_acm_certificate_validation.e2_bespinglobal_com.certificate_arn
#
#  default_action {
#    type = "fixed-response"
#
#    fixed_response {
#      content_type = "text/plain"
#      status_code  = "404"
#    }
#  }
#}
#
##LISTENER BACK 8109
## SVC-SL
#resource "aws_lb_listener" "service_sl" {
#  load_balancer_arn = aws_lb.private.arn
#  port              = "8109"
#  protocol          = "HTTP"
#
#  default_action {
#    type = "forward"
#    target_group_arn = aws_lb_target_group.service_sl_01.arn
#  }
#}
#
##LISTENER BACK 8110
## SVC-WORKER
#resource "aws_lb_listener" "service_worker" {
#  load_balancer_arn = aws_lb.private.arn
#  port              = "8110"
#  protocol          = "HTTP"
#
#  default_action {
#    type = "forward"
#    target_group_arn = aws_lb_target_group.service_worker_01.arn
#  }
#}
#
##LISTENER BACK 8111
## SVC-ADMIN
#resource "aws_lb_listener" "service_admin" {
#  load_balancer_arn = aws_lb.private.arn
#  port              = "8111"
#  protocol          = "HTTP"
#
#  default_action {
#    type = "forward"
#    target_group_arn = aws_lb_target_group.service_admin_01.arn
#  }
#}
