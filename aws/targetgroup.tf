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

# resource "aws_lb_target_group_attachment" "app_sl_01" {
#   target_group_arn = aws_lb_target_group.app_sl_01.arn
#   target_id        = aws_lb.public.arn
#   port             = 8084
# }

# resource "aws_lb_target_group_attachment" "app_sl_02" {
#   target_group_arn = aws_lb_target_group.app_sl_01.arn
#   target_id        = aws_lb.public.arn
#   port             = 8084
# }

#APP-ADMIN
resource "aws_lb_target_group" "app_admin_01" {
  name        = "tg-app-admin-01"
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
    Name = "tg-app-admin-01"
    MN = "devPart"
  }
}

resource "aws_lb_target_group" "app_admin_02" {
  name        = "tg-app-admin-02"
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
    Name = "tg-app-admin-02"
    MN = "devPart"
  }
}

# resource "aws_lb_target_group_attachment" "app_admin_01" {
#   target_group_arn = aws_lb_target_group.app_admin_01.arn
#   target_id        = aws_lb.public.arn
#   port             = 8085
# }

# resource "aws_lb_target_group_attachment" "app_admin_02" {
#   target_group_arn = aws_lb_target_group.app_admin_02.arn
#   target_id        = aws_lb.public.arn
#   port             = 8085
# }
#SVC-SL
resource "aws_lb_target_group" "service_sl_01" {
  name        = "tg-service-sl-01"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    enabled = true
    protocol = "HTTP"
    path = "/service/actuator/health"
    matcher = "200"
    interval = 30
    healthy_threshold  = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "tg-service-sl-01"
    MN = "devPart"
  }
}

resource "aws_lb_target_group" "service_sl_02" {
  name        = "tg-service-sl-02"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    enabled = true
    protocol = "HTTP"
    path = "/service/actuator/health"
    matcher = "200"
    interval = 30
    healthy_threshold  = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "tg-service-sl-02"
    MN = "devPart"
  }
}

# resource "aws_lb_target_group_attachment" "service_sl_01" {
#   target_group_arn = aws_lb_target_group.service_sl_01.arn
#   target_id        = aws_lb.private.arn
#   port             = 8109
# }

# resource "aws_lb_target_group_attachment" "service_sl_02" {
#   target_group_arn = aws_lb_target_group.service_sl_02.arn
#   target_id        = aws_lb.private.arn
#   port             = 8109
# }


#SVC-ADMIN
resource "aws_lb_target_group" "service_admin_01" {
  name        = "tg-service-admin-01"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
 
  health_check {
    enabled = true
    protocol = "HTTP"
    path = "/admin/actuator/health"
    matcher = "200"
    interval = 30
    healthy_threshold  = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "tg-service-admin-01"
    MN = "devPart"
  }
}

resource "aws_lb_target_group" "service_admin_02" {
  name        = "tg-service-admin-02"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    enabled = true
    protocol = "HTTP"
    path = "/admin/actuator/health"
    matcher = "200"
    interval = 30
    healthy_threshold  = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "tg-service-admin-02"
    MN = "devPart"
  }
}

# resource "aws_lb_target_group_attachment" "service_admin_01" {
#   target_group_arn = aws_lb_target_group.service_admin_01.arn
#   target_id        = aws_lb.private.arn
#   port             = 8111
# }

# resource "aws_lb_target_group_attachment" "service_admin_02" {
#   target_group_arn = aws_lb_target_group.service_admin_02.arn
#   target_id        = aws_lb.private.arn
#   port             = 8111
# }


#WORKER
resource "aws_lb_target_group" "service_worker_01" {
  name        = "tg-service-worker-01"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    enabled = true
    protocol = "HTTP"
    path = "/worker/actuator/health"
    matcher = "200"
    interval = 30
    healthy_threshold  = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "tg-service-worker-01"
    MN = "devPart"
  }
}

resource "aws_lb_target_group" "service_worker_02" {
  name        = "tg-service-worker-02"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    enabled = true
    protocol = "HTTP"
    path = "/worker/actuator/health"
    matcher = "200"
    interval = 30
    healthy_threshold  = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "tg-service-worker-02"
    MN = "devPart"
  }
}

# resource "aws_lb_target_group_attachment" "service_worker_01" {
#   target_group_arn = aws_lb_target_group.service_worker_01.arn
#   target_id        = aws_lb.private.arn
#   port             = 8110
# }

# resource "aws_lb_target_group_attachment" "service_worker_02" {
#   target_group_arn = aws_lb_target_group.service_worker_02.arn
#   target_id        = aws_lb.private.arn
#   port             = 8110
# }