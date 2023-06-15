#APP-SL
resource "aws_ecs_task_definition" "app_sl" {
  family = "devpart-app-sl"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.devpart_frontend_role.arn
  execution_role_arn = aws_iam_role.devpart_ecsTaskExecutionRole.arn
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([
    {
      name      = "devpart-app-sl"
      image     = "${aws_ecr_repository.app_sl.repository_url}"
      essential = true
      portMappings = [
        {
          containerPort = 8084          
        }
      ],
      logConfiguration =  {
          "logDriver": "awslogs",
          "options": {
              "awslogs-create-group": "true",
              "awslogs-group": "devpart-app-sl",
              "awslogs-region": "ap-northeast-2",
              "awslogs-stream-prefix": "ecs"
          }
      }
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

