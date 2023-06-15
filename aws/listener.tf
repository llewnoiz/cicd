#PUBLIC ELB
#LISTENER FRONT 80
resource "aws_lb_listener" "front_end_80" {
  load_balancer_arn = aws_lb.public.arn
  port              = "8084"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app_sl_01.arn
  }
}
