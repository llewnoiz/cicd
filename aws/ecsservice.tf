#APP-SL
resource "aws_ecs_service" "app_sl" {
  # 시작 유형
  launch_type     = "FARGATE"
  # 운영 체제 패밀리

  # 작업 정의 - 패밀리 / 개정 
  task_definition = aws_ecs_task_definition.app_sl.arn
  
  # 플랫폼 버전
  platform_version = "1.4.0"
  # 클러스터
  cluster         = aws_ecs_cluster.devpart_cluster.id
  # 서비스 이름
  name            = "devpart-app-sl"
  #서비스 유형
  scheduling_strategy = "REPLICA"
  # 작업 개수
  desired_count   = 1
  
  #최소 정상 상태 백분율 (롤링 업데이트 시 사용)
  # deployment_minimum_healthy_percent = 100
  #최대 백분율 (롤링 업데이트 시 사용)
  # deployment_maximum_percent = 200
  #배포 회로 차단기
  # deployment_circuit_breaker  {
  #   enable = false
  #   rollback = true
  # }

  # 배포 유형
  deployment_controller {
    type = "CODE_DEPLOY"
  }
  # 배포 구성
  force_new_deployment = true
  #placement_constraints?
  # CodeDeploy를 위한 서비스 역할*
  #?

  #관리형 태그 활성화
  enable_ecs_managed_tags = true
  #ECS 작업 상태 전파 활성화
  # 서비스(SERVICE) or 작업정의(TASK_DEFINITION)
  #propagate_tags 사용하지 않음

  #네트워크 구성
  network_configuration  {
    #클러스터 VPC*
    #서브넷*
    subnets          = ["${aws_subnet.back_2a.id}","${aws_subnet.back_2c.id}"]
    #보안 그룹*
    security_groups  = ["${aws_security_group.app_sl.id}"]
    #자동 할당 퍼블릭 IP
    assign_public_ip = true
  }

  #상태 검사 유예 기간
  health_check_grace_period_seconds = 0 

  # 로드 밸런싱
  load_balancer  {
    #로드 밸런서 유형*
    # elb_name= aws_lb.public.name
    #서비스의 IAM 역할 선택
    target_group_arn = aws_lb_target_group.app_sl_01.arn
    #로드 밸런싱할 컨테이너
    container_name   = "devpart-app-sl"
    container_port   =  8084
  }



  #App Mesh # 사용안함
  #서비스 검색 통합 활성화 # 사용안함
  #네임스페이스* # 사용안함
  #네임스페이스 이름* # 사용안함
  #서비스 검색 서비스 구성 # 사용안함
  #서비스 검색 이름* # 사용안함
  #서비스 검색을 위한 DNS 레코드 # 사용안함
  #DNS 레코드 유형* # 사용안함
  #TTL* # 사용안함
  lifecycle {
    ignore_changes = [
      load_balancer,
      desired_count,
      task_definition
    ]
  }

  tags = {
    Name = "aws_ecs_service app_sl"
    MN = "devPart"
  }
}
#APP-ADMIN

resource "aws_ecs_service" "app_admin" {
  # 시작 유형
  launch_type     = "FARGATE"
  # 운영 체제 패밀리

  # 작업 정의 - 패밀리 / 개정 
  task_definition = aws_ecs_task_definition.app_admin.arn
  
  # 플랫폼 버전
  platform_version = "1.4.0"
  # 클러스터
  cluster         = aws_ecs_cluster.devpart_cluster.id
  # 서비스 이름
  name            = "devpart-app-admin"
  #서비스 유형
  scheduling_strategy = "REPLICA"
  # 작업 개수
  desired_count   = 1
  
  #최소 정상 상태 백분율 (롤링 업데이트 시 사용)
  # deployment_minimum_healthy_percent = 100
  #최대 백분율 (롤링 업데이트 시 사용)
  # deployment_maximum_percent = 200
  #배포 회로 차단기
  # deployment_circuit_breaker  {
  #   enable = false
  #   rollback = true
  # }

  # 배포 유형
  deployment_controller {
    type = "CODE_DEPLOY"
  }
  # 배포 구성
  force_new_deployment = true
  #placement_constraints?
  # CodeDeploy를 위한 서비스 역할*
  #?

  #관리형 태그 활성화
  enable_ecs_managed_tags = true
  #ECS 작업 상태 전파 활성화
  # 서비스(SERVICE) or 작업정의(TASK_DEFINITION)
  #propagate_tags 사용하지 않음

  #네트워크 구성
  network_configuration  {
    #클러스터 VPC*
    #서브넷*
    subnets          = ["${aws_subnet.back_2a.id}","${aws_subnet.back_2c.id}"]
    #보안 그룹*
    security_groups  = ["${aws_security_group.app_admin.id}"]
    #자동 할당 퍼블릭 IP
    assign_public_ip = true
  }

  #상태 검사 유예 기간
  health_check_grace_period_seconds = 0 

  # 로드 밸런싱
  load_balancer  {
    #로드 밸런서 유형*
    # elb_name= aws_lb.public.name
    #서비스의 IAM 역할 선택
    target_group_arn = aws_lb_target_group.app_admin_01.arn
    #로드 밸런싱할 컨테이너
    container_name   = "devpart-app-admin"
    container_port   =  8085
  }



  #App Mesh # 사용안함
  #서비스 검색 통합 활성화 # 사용안함
  #네임스페이스* # 사용안함
  #네임스페이스 이름* # 사용안함
  #서비스 검색 서비스 구성 # 사용안함
  #서비스 검색 이름* # 사용안함
  #서비스 검색을 위한 DNS 레코드 # 사용안함
  #DNS 레코드 유형* # 사용안함
  #TTL* # 사용안함


  lifecycle {
    ignore_changes = [
      load_balancer,
      desired_count,
      task_definition
    ]
  }

  tags = {
    Name = "aws_ecs_service app_admin"
    MN = "devPart"
  }
}

#SVC-SL
resource "aws_ecs_service" "service_sl" {
  # 시작 유형
  launch_type     = "FARGATE"
  # 운영 체제 패밀리

  # 작업 정의 - 패밀리 / 개정 
  task_definition = aws_ecs_task_definition.service_sl.arn
  
  # 플랫폼 버전
  platform_version = "1.4.0"
  # 클러스터
  cluster         = aws_ecs_cluster.devpart_cluster.id
  # 서비스 이름
  name            = "devpart-service-sl"
  #서비스 유형
  scheduling_strategy = "REPLICA"
  # 작업 개수
  desired_count   = 1
  
  #최소 정상 상태 백분율 (롤링 업데이트 시 사용)
  # deployment_minimum_healthy_percent = 100
  #최대 백분율 (롤링 업데이트 시 사용)
  # deployment_maximum_percent = 200
  #배포 회로 차단기
  # deployment_circuit_breaker  {
  #   enable = false
  #   rollback = true
  # }

  # 배포 유형
  deployment_controller {
    type = "CODE_DEPLOY"
  }
  # 배포 구성
  force_new_deployment = true
  #placement_constraints?
  # CodeDeploy를 위한 서비스 역할*
  #?

  #관리형 태그 활성화
  enable_ecs_managed_tags = true
  #ECS 작업 상태 전파 활성화
  # 서비스(SERVICE) or 작업정의(TASK_DEFINITION)
  #propagate_tags 사용하지 않음

  #네트워크 구성
  network_configuration  {
    #클러스터 VPC*
    #서브넷*
    subnets          = ["${aws_subnet.back_2a.id}","${aws_subnet.back_2c.id}"]
    #보안 그룹*
    security_groups  = ["${aws_security_group.service_sl.id}"]
    #자동 할당 퍼블릭 IP
    assign_public_ip = false
  }

  #상태 검사 유예 기간
  health_check_grace_period_seconds = 0 

  # 로드 밸런싱
  load_balancer  {
    #로드 밸런서 유형*
    # elb_name= aws_lb.private.name
    #서비스의 IAM 역할 선택
    target_group_arn = aws_lb_target_group.service_sl_01.arn
    #로드 밸런싱할 컨테이너
    container_name   = "devpart-service-sl"
    container_port   =  8109
  }



  #App Mesh # 사용안함
  #서비스 검색 통합 활성화 # 사용안함
  #네임스페이스* # 사용안함
  #네임스페이스 이름* # 사용안함
  #서비스 검색 서비스 구성 # 사용안함
  #서비스 검색 이름* # 사용안함
  #서비스 검색을 위한 DNS 레코드 # 사용안함
  #DNS 레코드 유형* # 사용안함
  #TTL* # 사용안함


  lifecycle {
    ignore_changes = [
      load_balancer,
      desired_count,
      task_definition
    ]
  }
  tags = {
    Name = "aws_ecs_service service_sl"
    MN = "devPart"
  }
}



#SVC-ADMIN
resource "aws_ecs_service" "service_admin" {
  # 시작 유형
  launch_type     = "FARGATE"
  # 운영 체제 패밀리

  # 작업 정의 - 패밀리 / 개정 
  task_definition = aws_ecs_task_definition.service_admin.arn
  
  # 플랫폼 버전
  platform_version = "1.4.0"
  # 클러스터
  cluster         = aws_ecs_cluster.devpart_cluster.id
  # 서비스 이름
  name            = "devpart-service-admin"
  #서비스 유형
  scheduling_strategy = "REPLICA"
  # 작업 개수
  desired_count   = 1
  
  #최소 정상 상태 백분율 (롤링 업데이트 시 사용)
  # deployment_minimum_healthy_percent = 100
  #최대 백분율 (롤링 업데이트 시 사용)
  # deployment_maximum_percent = 200
  #배포 회로 차단기
  # deployment_circuit_breaker  {
  #   enable = false
  #   rollback = true
  # }

  # 배포 유형
  deployment_controller {
    type = "CODE_DEPLOY"
  }
  # 배포 구성
  force_new_deployment = true
  #placement_constraints?
  # CodeDeploy를 위한 서비스 역할*
  #?

  #관리형 태그 활성화
  enable_ecs_managed_tags = true
  #ECS 작업 상태 전파 활성화
  # 서비스(SERVICE) or 작업정의(TASK_DEFINITION)
  #propagate_tags 사용하지 않음

  #네트워크 구성
  network_configuration  {
    #클러스터 VPC*
    #서브넷*
    subnets          = ["${aws_subnet.back_2a.id}","${aws_subnet.back_2c.id}"]
    #보안 그룹*
    security_groups  = ["${aws_security_group.service_admin.id}"]
    #자동 할당 퍼블릭 IP
    assign_public_ip = false
  }

  #상태 검사 유예 기간
  health_check_grace_period_seconds = 0 

  # 로드 밸런싱
  load_balancer  {
    #로드 밸런서 유형*
    # elb_name= aws_lb.private.name
    #서비스의 IAM 역할 선택
    target_group_arn = aws_lb_target_group.service_admin_01.arn
    #로드 밸런싱할 컨테이너
    container_name   = "devpart-service-admin"
    container_port   =  8111
  }



  #App Mesh # 사용안함
  #서비스 검색 통합 활성화 # 사용안함
  #네임스페이스* # 사용안함
  #네임스페이스 이름* # 사용안함
  #서비스 검색 서비스 구성 # 사용안함
  #서비스 검색 이름* # 사용안함
  #서비스 검색을 위한 DNS 레코드 # 사용안함
  #DNS 레코드 유형* # 사용안함
  #TTL* # 사용안함


  lifecycle {
    ignore_changes = [
      load_balancer,
      desired_count,
      task_definition
    ]
  }
  tags = {
    Name = "aws_ecs_service service_admin"
    MN = "devPart"
  }
}

#SVC-WORKER

resource "aws_ecs_service" "service_worker" {
  # 시작 유형
  launch_type     = "FARGATE"
  # 운영 체제 패밀리

  # 작업 정의 - 패밀리 / 개정 
  task_definition = aws_ecs_task_definition.service_worker.arn
  
  # 플랫폼 버전
  platform_version = "1.4.0"
  # 클러스터
  cluster         = aws_ecs_cluster.devpart_cluster.id
  # 서비스 이름
  name            = "devpart-service-worker"
  #서비스 유형
  scheduling_strategy = "REPLICA"
  # 작업 개수
  desired_count   = 1
  
  #최소 정상 상태 백분율 (롤링 업데이트 시 사용)
  # deployment_minimum_healthy_percent = 100
  #최대 백분율 (롤링 업데이트 시 사용)
  # deployment_maximum_percent = 200
  #배포 회로 차단기
  # deployment_circuit_breaker  {
  #   enable = false
  #   rollback = true
  # }

  # 배포 유형
  deployment_controller {
    type = "CODE_DEPLOY"
  }
  # 배포 구성
  force_new_deployment = true
  #placement_constraints?
  # CodeDeploy를 위한 서비스 역할*
  #?

  #관리형 태그 활성화
  enable_ecs_managed_tags = true
  #ECS 작업 상태 전파 활성화
  # 서비스(SERVICE) or 작업정의(TASK_DEFINITION)
  #propagate_tags 사용하지 않음

  #네트워크 구성
  network_configuration  {
    #클러스터 VPC*
    #서브넷*
    subnets          = ["${aws_subnet.back_2a.id}","${aws_subnet.back_2c.id}"]
    #보안 그룹*
    security_groups  = ["${aws_security_group.service_worker.id}"]
    #자동 할당 퍼블릭 IP
    assign_public_ip = false
  }

  #상태 검사 유예 기간
  health_check_grace_period_seconds = 0 

  # 로드 밸런싱
  load_balancer  {
    #로드 밸런서 유형*
    # elb_name= aws_lb.private.name
    #서비스의 IAM 역할 선택
    target_group_arn = aws_lb_target_group.service_worker_01.arn
    #로드 밸런싱할 컨테이너
    container_name   = "devpart-service-worker"
    container_port   =  8110
  }



  #App Mesh # 사용안함
  #서비스 검색 통합 활성화 # 사용안함
  #네임스페이스* # 사용안함
  #네임스페이스 이름* # 사용안함
  #서비스 검색 서비스 구성 # 사용안함
  #서비스 검색 이름* # 사용안함
  #서비스 검색을 위한 DNS 레코드 # 사용안함
  #DNS 레코드 유형* # 사용안함
  #TTL* # 사용안함

  lifecycle {
    ignore_changes = [
      load_balancer,
      desired_count,
      task_definition
    ]
  }
  tags = {
    Name = "aws_ecs_service service_worker"
    MN = "devPart"
  }
}

