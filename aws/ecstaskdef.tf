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
#APP-ADMIN
resource "aws_ecs_task_definition" "app_admin" {
  family = "devpart-app-admin"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.devpart_frontend_role.arn
  execution_role_arn = aws_iam_role.devpart_ecsTaskExecutionRole.arn
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([
    {
      name      = "devpart-app-admin"
      image     = "${aws_ecr_repository.app_admin.repository_url}"
      essential = true
      portMappings = [
        {
          containerPort = 8085          
        }
      ],
      logConfiguration =  {
          "logDriver": "awslogs",
          "options": {
              "awslogs-create-group": "true",
              "awslogs-group": "devpart-app-admin",
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
#SVC-SL
resource "aws_ecs_task_definition" "service_sl" {
  family = "devpart-service-sl"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.devpart_backend_role.arn
  execution_role_arn = aws_iam_role.devpart_ecsTaskExecutionRole.arn
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([
    {
      name      = "devpart-service-sl"
      image     = "${aws_ecr_repository.service_sl.repository_url}"
      essential = true
      portMappings = [
        {
          containerPort = 8109          
        }
      ],
      logConfiguration =  {
          "logDriver": "awslogs",
          "options": {
              "awslogs-create-group": "true",
              "awslogs-group": "devpart-service-sl",
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

#SVC-ADMIN
resource "aws_ecs_task_definition" "service_admin" {
  family = "devpart-service-admin"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.devpart_backend_role.arn
  execution_role_arn = aws_iam_role.devpart_ecsTaskExecutionRole.arn
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([
    {
      name      = "devpart-service-admin"
      image     = "${aws_ecr_repository.service_admin.repository_url}"
      essential = true
      portMappings = [
        {
          containerPort = 8111          
        }
      ],
      logConfiguration =  {
          "logDriver": "awslogs",
          "options": {
              "awslogs-create-group": "true",
              "awslogs-group": "devpart-service-admin",
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

#SVC-WORKER
resource "aws_ecs_task_definition" "service_worker" {
  family = "devpart-service-worker"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.service_worker_role.arn
  execution_role_arn = aws_iam_role.devpart_ecsTaskExecutionRole.arn
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([
    {
      name      = "devpart-service-worker"
      image     = "${aws_ecr_repository.service_worker.repository_url}"
      essential = true
      portMappings = [
        {
          containerPort = 8110          
        }
      ],
      logConfiguration =  {
          "logDriver": "awslogs",
          "options": {
              "awslogs-create-group": "true",
              "awslogs-group": "devpart-service-worker",
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



resource "aws_ecs_task_definition" "devpart_bastion" {
  family = "devpart-bastion"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.devpart_backend_role.arn
  execution_role_arn = aws_iam_role.devpart_ecsTaskExecutionRole.arn
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name      = "devpart-bastion"
      image     = "${aws_ecr_repository.devpart_bastion.repository_url}"
      essential = true
      portMappings = [
        {
          containerPort = 20002          
        }
      ],
      environment= [
        {"name": "SSH_PASSWORD", "value": "Bespin1!"},
        {"name": "SSH_PORT", "value": "20002"}
      ],
      logConfiguration =  {
          "logDriver": "awslogs",
          "options": {
              "awslogs-create-group": "true",
              "awslogs-group": "devpart-bastion",
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
