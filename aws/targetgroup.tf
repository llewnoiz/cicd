#APP-SL
resource "aws_lb_target_group" "app_sl_01" {
  name        = "tg-app-sl-01"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    enabled = true
    protocol = "HTTP"
    path = "/actuator/health"
    matcher = "200"
    interval = 30
    healthy_threshold  = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "tg-app-sl-01"
    MN = "devPart"
  }
}

resource "aws_lb_target_group" "app_sl_02" {
  name        = "tg-app-sl-02"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    enabled = true
    protocol = "HTTP"
    path = "/actuator/health"
    matcher = "200"
    interval = 30
    healthy_threshold  = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "tg-app-sl-02"
    MN = "devPart"
  }
}
