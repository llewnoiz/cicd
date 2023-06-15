#PUBLIC ELB

#ELB
resource "aws_lb" "public" {
  name               = "public-loadbalance"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_loadbalance.id]
  subnets            = ["${aws_subnet.front_2c.id}","${aws_subnet.front_2a.id}"]
  idle_timeout       = 300

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.bucket
#     prefix  = "devPart_public_loadbalance"
#     enabled = true
#   }

  tags = {
    Name = "devPart_public_loadbalance"
    MN = "devPart"
  }
}

#INTERNAL ELB

#ELB
resource "aws_lb" "private" {
  name               = "private-loadbalance"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.private_loadbalance.id]
  subnets            = ["${aws_subnet.back_2c.id}","${aws_subnet.back_2a.id}"]
  idle_timeout       = 300

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.bucket
#     prefix  = "devPart_private_loadbalance"
#     enabled = true
#   }

  tags = {
    Name = "devPart_private_loadbalance"
    MN = "devPart"
  }
}
