#################### ECS ####################

data "aws_iam_policy" "AWSCodeDeployRoleForECS"{ 
  arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}
data "aws_iam_policy" "AmazonECSServiceRolePolicy"{ 
  arn = "arn:aws:iam::aws:policy/aws-service-role/AmazonECSServiceRolePolicy"
}
data "aws_iam_policy" "CloudWatchLogsFullAccess"{ 
  arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}


data "aws_iam_policy" "AmazonECSTaskExecutionRolePolicy"{ 
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy" "AWSCodeCommitPowerUser"{ 
  arn = "arn:aws:iam::aws:policy/AWSCodeCommitPowerUser"
}

data "aws_iam_policy" "AWSCodeCommitFullAccess" {
    arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
}

data "aws_iam_policy" "AmazonS3FullAccess" {
    arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_iam_policy" "AWSCodePipeline_FullAccess" {
    arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}

data "aws_iam_policy" "AWSCodeDeployFullAccess" {
    arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
}

#devpart_ecsTaskExecutionRole
resource "aws_iam_role" "devpart_ecsTaskExecutionRole" {
    name="devpart_ecsTaskExecutionRole"
    assume_role_policy = jsonencode({
        Version= "2012-10-17",
        Statement= [
            {
                Effect= "Allow",
                Principal= {
                    "Service": "ecs-tasks.amazonaws.com"
                },
                Action= "sts:AssumeRole"
            }
        ]
    })

    tags = {
        Name = "devpart_ecsTaskExecutionRole"
        MN = "devPart"
    } 
}

resource "aws_iam_role_policy_attachment" "devpart_ecsTaskExecutionRole_attach_AmazonECSTaskExecutionRolePolicy" {
  role       = aws_iam_role.devpart_ecsTaskExecutionRole.name
  policy_arn = data.aws_iam_policy.AmazonECSTaskExecutionRolePolicy.arn
}

resource "aws_iam_role_policy_attachment" "devpart_ecsTaskExecutionRole_attach_CloudWatchLogsFullAccess" {
  role       = aws_iam_role.devpart_ecsTaskExecutionRole.name
  policy_arn = data.aws_iam_policy.CloudWatchLogsFullAccess.arn
}



#devpart_backend_role
#@ecs_mgmt_policy
#@AmazonECSTaskExecutionRolePolicy
#@firelens_policy
resource "aws_iam_role" "devpart_backend_role" {
    name="devpart_backend_role"
    assume_role_policy = jsonencode({
        Version= "2012-10-17",
        Statement= [
            {
                Effect= "Allow",
                Principal= {
                    "Service": "ecs-tasks.amazonaws.com"
                },
                Action= "sts:AssumeRole"
            }
        ]
    })

    tags = {
        Name = "devpart_backend_role"
        MN = "devPart"
    }
    
}
resource "aws_iam_role_policy_attachment" "devpart_backend_role_attach_ecs_mgmt_policy" {
  role       = aws_iam_role.devpart_backend_role.name
  policy_arn = aws_iam_policy.ecs_mgmt_policy.arn
}


resource "aws_iam_role_policy_attachment" "devpart_backend_role_attach_CloudWatchLogsFullAccess" {
  role       = aws_iam_role.devpart_backend_role.name
  policy_arn = data.aws_iam_policy.CloudWatchLogsFullAccess.arn
}

resource "aws_iam_role_policy_attachment" "devpart_backend_role_attach_AmazonECSTaskExecutionRolePolicy" {
  role       = aws_iam_role.devpart_backend_role.name
  policy_arn = data.aws_iam_policy.AmazonECSTaskExecutionRolePolicy.arn
}

resource "aws_iam_role_policy_attachment" "devpart_backend_role_attach_firelens_policy" {
  role       = aws_iam_role.devpart_backend_role.name
  policy_arn = aws_iam_policy.firelens_policy.arn
}

#devpart_frontend_role
#@ecs_mgmt_policy
#@firelens_policy
#@CloudWatchLogsFullAccess
#@AmazonECSTaskExecutionRolePolicy

resource "aws_iam_role" "devpart_frontend_role" {
    name="devpart_frontend_role"
    assume_role_policy = jsonencode({
        Version= "2012-10-17",
        Statement= [
            {
                Effect= "Allow",
                Principal= {
                    "Service": "ecs-tasks.amazonaws.com"
                },
                Action= "sts:AssumeRole"
            }
        ]
    })

    tags = {
        Name = "devpart_frontend_role"
        MN = "devPart"
    }
}

resource "aws_iam_role_policy_attachment" "devpart_frontend_role_attach_ecs_mgmt_policy" {
  role       = aws_iam_role.devpart_frontend_role.name
  policy_arn = aws_iam_policy.ecs_mgmt_policy.arn
}

resource "aws_iam_role_policy_attachment" "devpart_frontend_role_attach_AmazonECSTaskExecutionRolePolicy" {
  role       = aws_iam_role.devpart_frontend_role.name
  policy_arn = data.aws_iam_policy.AmazonECSTaskExecutionRolePolicy.arn
}

resource "aws_iam_role_policy_attachment" "devpart_frontend_role_attach_CloudWatchLogsFullAccess" {
  role       = aws_iam_role.devpart_frontend_role.name
  policy_arn = data.aws_iam_policy.CloudWatchLogsFullAccess.arn
}

resource "aws_iam_role_policy_attachment" "devpart_frontend_role_attach_firelens_policy" {
  role       = aws_iam_role.devpart_frontend_role.name
  policy_arn = aws_iam_policy.firelens_policy.arn
}


#codedeploy_mgmt_role
#@AWSCodeDeployRoleForECS
resource "aws_iam_role" "codedeploy_mgmt_role" {
    name="codedeploy_mgmt_role"
    assume_role_policy = jsonencode({
        Version= "2012-10-17",
        Statement= [
            {
                Effect= "Allow",
                Principal= {
                    "Service": "codedeploy.amazonaws.com"
                },
                Action= "sts:AssumeRole"
            }
        ]
    })

    tags = {
        Name = "codedeploy_mgmt_role"
        MN = "devPart"
    }
}

resource "aws_iam_role_policy_attachment" "devpart_frontend_role_attach_AWSCodeDeployRoleForECS" {
  role       = aws_iam_role.codedeploy_mgmt_role.name
  policy_arn = data.aws_iam_policy.AWSCodeDeployRoleForECS.arn
}

#service_worker_role
#@ecs_mgmt_policy
#@service_worker_policy
#@firelens_policy
#@AWSCodeCommitPowerUser
#@AmazonECSTaskExecutionRolePolicy

resource "aws_iam_role" "service_worker_role" {
    name="service_worker_role"
    assume_role_policy = jsonencode({
        Version= "2012-10-17",
        Statement= [
            {
                Effect= "Allow",
                Principal= {
                    "Service": "ecs-tasks.amazonaws.com"
                },
                Action= "sts:AssumeRole"
            }
        ]
    })

    tags = {
        Name = "service_worker_role"
        MN = "devPart"
    }
}


resource "aws_iam_role_policy_attachment" "service_worker_role_attach_ecs_mgmt_policy" {
  role       = aws_iam_role.service_worker_role.name
  policy_arn = aws_iam_policy.ecs_mgmt_policy.arn
}

resource "aws_iam_role_policy_attachment" "service_worker_role_attach_service_worker_policy" {
  role       = aws_iam_role.service_worker_role.name
  policy_arn = aws_iam_policy.service_worker_policy.arn
}

resource "aws_iam_role_policy_attachment" "service_worker_role_attach_firelens_policy" {
  role       = aws_iam_role.service_worker_role.name
  policy_arn = aws_iam_policy.firelens_policy.arn
}

resource "aws_iam_role_policy_attachment" "service_worker_role_attach_AWSCodeCommitPowerUser" {
  role       = aws_iam_role.service_worker_role.name
  policy_arn = data.aws_iam_policy.AWSCodeCommitPowerUser.arn
}

resource "aws_iam_role_policy_attachment" "service_worker_role_attach_AmazonECSTaskExecutionRolePolicy" {
  role       = aws_iam_role.service_worker_role.name
  policy_arn = data.aws_iam_policy.AmazonECSTaskExecutionRolePolicy.arn
}

resource "aws_iam_role_policy_attachment" "devpart_frontend_role_attach_codepipeline_full" {
  role       = aws_iam_role.codedeploy_mgmt_role.name
  policy_arn = data.aws_iam_policy.AWSCodeDeployFullAccess.arn
}

#################### ECS ####################


#################### CODE BUILD ####################
resource "aws_iam_role" "codebuild_mgmt_role" {
    name="codebuild_mgmt_role"
    assume_role_policy = jsonencode({
        Version= "2012-10-17",
        Statement= [
            {
                Effect= "Allow",
                Principal= {
                    "Service": "codebuild.amazonaws.com"
                },
                Action= "sts:AssumeRole"
            }
        ]
    })

    tags = {
        Name = "codebuild_mgmt_role"
        MN = "devPart"
    }
}

resource "aws_iam_role_policy_attachment" "codebuild_mgmt_role_attach_codebuild_policy" {
  role       = aws_iam_role.codebuild_mgmt_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}

#################### CODE BUILD ####################


#################### CODE PIPELINE ####################

resource "aws_iam_role" "codepipeline_mgmt_role" {
    name="codepipeline_mgmt_role"
    assume_role_policy = jsonencode({
        Version= "2012-10-17",
        Statement= [
            {
                Effect= "Allow",
                Principal= {
                    "Service": "codepipeline.amazonaws.com"
                },
                Action= "sts:AssumeRole"
            }
        ]
    })

    tags = {
        Name = "codepipeline_mgmt_role"
        MN = "devPart"
    }
}

resource "aws_iam_role_policy_attachment" "codepipeline_mgmt_role_attach_AWSCodeCommitFullAccess" {
  role       = aws_iam_role.codepipeline_mgmt_role.name
  policy_arn = data.aws_iam_policy.AWSCodeCommitFullAccess.arn
}

resource "aws_iam_role_policy_attachment" "codepipeline_mgmt_role_attach_AmazonS3FullAccess" {
  role       = aws_iam_role.codepipeline_mgmt_role.name
  policy_arn = data.aws_iam_policy.AmazonS3FullAccess.arn
}

resource "aws_iam_role_policy_attachment" "codepipeline_mgmt_role_attach_codepipeline_mgmt_policy" {
  role       = aws_iam_role.codepipeline_mgmt_role.name
  policy_arn = aws_iam_policy.codepipeline_mgmt_policy.arn
}

resource "aws_iam_role_policy_attachment" "codepipeline_mgmt_role_attach_codebuild_policy" {
  role       = aws_iam_role.codepipeline_mgmt_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}

resource "aws_iam_role_policy_attachment" "codepipeline_mgmt_role_attach_codedeploy_policy" {
  role       = aws_iam_role.codepipeline_mgmt_role.name
  policy_arn = data.aws_iam_policy.AWSCodeDeployFullAccess.arn
}


//AWSCodePipeline_FullAccess
#################### CODE PIPELINE ####################