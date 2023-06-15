#################### ECS ####################

#services-worker-policy
resource "aws_iam_policy" "service_worker_policy" {
  name = "service_worker_policy"
  description = "service_worker_policy"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect= "Allow",
            Action= [
                "elasticfilesystem:*",
                "route53domains:*",
                "ssm:GetParameter"
            ],
            Resource= "*"
        },
        {
            Effect= "Allow",
            Action= [
                "s3:PutObject",
                "s3:GetObject",
                "dynamodb:PutItem",
                "dynamodb:DeleteItem",
                "dynamodb:GetItem",
                "s3:DeleteObject"
            ],
            Resource= [
                "*"
            ]
        },
        {
            Effect= "Allow",
            Action= "s3:ListBucket",
            Resource= "arn:aws:s3:::*"
        }
    ]
  })
}

#AWSCodeDeployRoleForECS
resource "aws_iam_policy" "AWSCodeDeployRoleForECS" {
  name = "AWSCodeDeployRoleForECS"
  description = "AWSCodeDeployRoleForECS"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
    {
        Action= [
            "ecs:DescribeServices",
            "ecs:CreateTaskSet",
            "ecs:UpdateServicePrimaryTaskSet",
            "ecs:DeleteTaskSet",
            "elasticloadbalancing:DescribeTargetGroups",
            "elasticloadbalancing:DescribeListeners",
            "elasticloadbalancing:ModifyListener",
            "elasticloadbalancing:DescribeRules",
            "elasticloadbalancing:ModifyRule",
            "lambda:InvokeFunction",
            "cloudwatch:DescribeAlarms",
            "sns:Publish",
            "s3:GetObject",
            "s3:GetObjectVersion"
        ],
        Resource= "*",
        Effect= "Allow"
    },
    {
        Action= [
            "iam:PassRole"
        ],
        Effect= "Allow",
        Resource= "*",
        Condition= {
        StringLike= {
            "iam:PassedToService"= [
                "ecs-tasks.amazonaws.com"
            ]
        }
        }
    }
    ]
  })
}

#ecs-mgmt-policy
resource "aws_iam_policy" "ecs_mgmt_policy" {
  name = "ecs_mgmt_policy"
  description = "ecs_mgmt_policy"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
    {
        Effect   = "Allow"
        Action = [
            "s3:PutObject",
            "s3:GetObject",
            "codecommit:*",
            "s3:DeleteObject"
        ],
        Resource = "*"
    },
    {
        Effect= "Allow",
        Action = [
        "codecommit:ListRepositoriesForApprovalRuleTemplate",
        "codecommit:CreateApprovalRuleTemplate",
        "ses:*",
        "codecommit:UpdateApprovalRuleTemplateName",
        "kms:*",
        "codecommit:GetApprovalRuleTemplate",
        "codecommit:ListApprovalRuleTemplates",
        "codecommit:DeleteApprovalRuleTemplate",
        "codecommit:ListRepositories",
        "codecommit:UpdateApprovalRuleTemplateContent",
        "codecommit:UpdateApprovalRuleTemplateDescription"
        ],
        Resource= "*"
    },
    {
        Effect   = "Allow"
        Action = [
          "SNS:*"
        ],
        Resource = "*"
    },
    ]
  })
}

#firelens logs policy
resource "aws_iam_policy" "firelens_policy" {
  name = "firelens_policy"
  description = "firelens_policy"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
            "logs:GetLogRecord",
            "logs:DeleteSubscriptionFilter",
            "logs:DescribeLogStreams",
            "logs:StartQuery",
            "logs:DeleteLogStream",
            "logs:GetLogDelivery",
            "logs:CreateExportTask",
            "logs:DeleteResourcePolicy",
            "logs:CreateLogStream",
            "logs:DeleteMetricFilter",
            "logs:CancelExportTask",
            "logs:DeleteRetentionPolicy",
            "logs:GetLogEvents",
            "logs:DeleteLogDelivery",
            "logs:AssociateKmsKey",
            "logs:FilterLogEvents",
            "logs:PutDestination",
            "logs:DisassociateKmsKey",
            "logs:DeleteLogGroup",
            "logs:PutDestinationPolicy",
            "logs:StopQuery",
            "logs:TestMetricFilter",
            "logs:DeleteQueryDefinition",
            "logs:PutQueryDefinition",
            "logs:DeleteDestination",
            "logs:PutLogEvents",
            "logs:CreateLogGroup",
            "logs:PutMetricFilter",
            "logs:CreateLogDelivery",
            "es:*",
            "logs:PutResourcePolicy",
            "logs:GetQueryResults",
            "logs:UpdateLogDelivery",
            "logs:PutSubscriptionFilter",
            "logs:PutRetentionPolicy",
            "logs:GetLogGroupFields"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

#################### ECS ####################

# codebuild

resource "aws_iam_policy" "codebuild_policy" {
  name = "codebuild_policy"
  description = "codebuild_policy"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect= "Allow",
            Resource= [
                "*"
            ],
            Action= [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            Effect= "Allow",
            Action= [
                "codecommit:*",
                "codestar-connections:UseConnection"
            ],
            Resource= "*"
        },
        {
            Effect= "Allow",
            Action= [
                "s3:GetBucketAcl",
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetBucketLocation",
                "s3:GetObjectVersion"
            ],
            Resource= "*"
        },
        {
            Effect= "Allow",
            Action= [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages",
                "codebuild:StartBuild",
                "codebuild:BatchGetBuilds"
            ],
            Resource= [
                "*"
            ]
        },
				{
            Effect= "Allow",
            Action= [
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetAuthorizationToken",
                "ecr:UploadLayerPart",
                "ecr:ListImages",
                "ecr:PutImage",
                "ecr:BatchGetImage",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeImages",
                "ecr:DescribeRepositories",
                "ecr:InitiateLayerUpload",
                "ecr:BatchCheckLayerAvailability"
            ],
            Resource= "*"
        },
				{
            Effect= "Allow",
            Action= [
                "ecs:DescribeTaskDefinition",
                "ecs:DescribeClusters",
                "ecs:DeregisterTaskDefinition",
                "ecs:ListTaskDefinitionFamilies",
                "ecs:RegisterTaskDefinition",
                "ecs:DescribeServices",
                "ecs:ListTaskDefinitions"
            ],
            Resource= "*"
        },
        {
            Effect= "Allow",
            Action= [
                "iam:PassRole"
            ],
            Resource= "*"
        }
    ]
  })
}

# codebuild


# code pipeline


resource "aws_iam_policy" "codepipeline_mgmt_policy" {
  name = "codepipeline_mgmt_policy"
  description = "codepipeline_mgmt_policy"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect= "Allow",
            Action= [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages",
                "codebuild:StartBuild",
                "codebuild:BatchGetBuilds",
                "codedeploy:*"
            ],
            Resource= [
                "*"
            ]
        }
    ]
  })
}

