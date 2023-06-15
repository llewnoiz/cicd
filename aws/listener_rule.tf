#APP-SL

resource "aws_lb_listener_rule" "app_sl_01" {
    
  listener_arn = aws_lb_listener.front_end_443.arn
  # priority     = 102

  action  {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_sl_01.arn
  }

  condition {
    host_header {
      values = ["e2.bespinglobal.com"]
    }
  }
}

#APP-ADMIN
resource "aws_lb_listener_rule" "app_admin_01" {
    
  listener_arn = aws_lb_listener.front_end_443.arn
  # priority     = 103

  action  {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_admin_01.arn
  }

  condition {
    host_header {
      values = ["admin.e2.bespinglobal.com"]
    }
  }
}