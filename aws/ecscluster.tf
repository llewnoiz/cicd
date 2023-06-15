resource "aws_ecs_cluster" "devpart_cluster" {
  name = "devpart_cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "devpart_ecs_cluster"
    MN = "devPart"
  }
}