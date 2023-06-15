#APP-SL

resource "aws_codepipeline" "app_sl" {
    name     = "app-sl-pipeline"
    role_arn = aws_iam_role.codepipeline_mgmt_role.arn

    artifact_store {
        location = aws_s3_bucket.app_sl_codepipeline_bucket.bucket
        type     = "S3"
    }

    stage {
        name = "Source"

        action {
            name             = "Source"
            category         = "Source"
            owner            = "AWS"
            provider         = "CodeCommit"
            version          = "1"
            output_artifacts = ["source_output"]
            configuration = {
                RepositoryName   = "bespin-app-sl"
                BranchName       = "master"
                OutputArtifactFormat = "CODEBUILD_CLONE_REF"
                
            }
        }
    }

    stage {
        name = "Build"

        action {
        name             = "Build"
        category         = "Build"
        owner            = "AWS"
        provider         = "CodeBuild"
        input_artifacts  = ["source_output"]
        output_artifacts = ["build_output"]
        version          = "1"
        configuration = {
            ProjectName = aws_codebuild_project.app_sl.name
        }
        }
    }

    stage {
        name = "Deploy"

        action {
            name            = "Deploy"
            category        = "Deploy"
            owner           = "AWS"
            provider        = "CodeDeploy"
            input_artifacts = ["build_output"]
            version         = "1"
            configuration = {
                ApplicationName = aws_codedeploy_app.app_sl.name
                DeploymentGroupName = aws_codedeploy_deployment_group.app_sl.deployment_group_name
            }
        }
    }

}

#APP-ADMIN

resource "aws_codepipeline" "app_admin" {
    name     = "app-admin-pipeline"
    role_arn = aws_iam_role.codepipeline_mgmt_role.arn

    artifact_store {
        location = aws_s3_bucket.app_admin_codepipeline_bucket.bucket
        type     = "S3"
    }

    stage {
        name = "Source"

        action {
            name             = "Source"
            category         = "Source"
            owner            = "AWS"
            provider         = "CodeCommit"
            version          = "1"
            output_artifacts = ["source_output"]
            configuration = {
                RepositoryName   = "bespin-app-admin"
                BranchName       = "master"
                OutputArtifactFormat = "CODEBUILD_CLONE_REF"
            }
        }
    }

    stage {
        name = "Build"

        action {
            name             = "Build"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            input_artifacts  = ["source_output"]
            output_artifacts = ["build_output"]
            version          = "1"
            configuration = {
                ProjectName = aws_codebuild_project.app_admin.name
            }
        }
    }

    stage {
        name = "Deploy"

        action {
            name            = "Deploy"
            category        = "Deploy"
            owner           = "AWS"
            provider        = "CodeDeploy"
            input_artifacts = ["build_output"]
            version         = "1"
            configuration = {
                ApplicationName = aws_codedeploy_app.app_admin.name
                DeploymentGroupName = aws_codedeploy_deployment_group.app_admin.deployment_group_name
            }
        }
    }
}
#SVC-SL

resource "aws_codepipeline" "service_sl" {
    name     = "service-sl-pipeline"
    role_arn = aws_iam_role.codepipeline_mgmt_role.arn
    artifact_store {
        location = aws_s3_bucket.service_sl_codepipeline_bucket.bucket
        type     = "S3"
    }

    stage {
        name = "Source"

        action {
            name             = "Source"
            category         = "Source"
            owner            = "AWS"
            provider         = "CodeCommit"
            version          = "1"
            output_artifacts = ["source_output"]
            configuration = {
                RepositoryName   = "bespin-svc-sl"
                BranchName       = "master"
                OutputArtifactFormat = "CODEBUILD_CLONE_REF"
            }
        }
    }

    stage {
        name = "Build"

        action {
            name             = "Build"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            input_artifacts  = ["source_output"]
            output_artifacts = ["build_output"]
            version          = "1"
            configuration = {
                ProjectName = aws_codebuild_project.service_sl.name
            }
        }
    }

    stage {
        name = "Deploy"

        action {
            name            = "Deploy"
            category        = "Deploy"
            owner           = "AWS"
            provider        = "CodeDeploy"
            input_artifacts = ["build_output"]
            version         = "1"
            configuration = {
                ApplicationName = aws_codedeploy_app.service_sl.name
                DeploymentGroupName = aws_codedeploy_deployment_group.service_sl.deployment_group_name
            }
        }
    }
}
#SVC-ADMIN

resource "aws_codepipeline" "service_admin" {
    name     = "service-admin-pipeline"
    role_arn = aws_iam_role.codepipeline_mgmt_role.arn

    artifact_store {
        location = aws_s3_bucket.service_admin_codepipeline_bucket.bucket
        type     = "S3"
    }

    stage {
        name = "Source"

        action {
            name             = "Source"
            category         = "Source"
            owner            = "AWS"
            provider         = "CodeCommit"
            version          = "1"
            output_artifacts = ["source_output"]
            configuration = {
                RepositoryName   = "bespin-svc-admin"
                BranchName       = "master"
                OutputArtifactFormat = "CODEBUILD_CLONE_REF"
            }
        }
    }

    stage {
        name = "Build"

        action {
            name             = "Build"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            input_artifacts  = ["source_output"]
            output_artifacts = ["build_output"]
            version          = "1"
            configuration = {
                ProjectName = aws_codebuild_project.service_admin.name
            }
        }
    }

    stage {
        name = "Deploy"

        action {
            name            = "Deploy"
            category        = "Deploy"
            owner           = "AWS"
            provider        = "CodeDeploy"
            input_artifacts = ["build_output"]
            version         = "1"
            configuration = {
                ApplicationName = aws_codedeploy_app.service_admin.name
                DeploymentGroupName = aws_codedeploy_deployment_group.service_admin.deployment_group_name
            }
        }
    }
}

#SVC-WORKER
resource "aws_codepipeline" "service_worker" {
    name     = "service-worker-pipeline"
    role_arn = aws_iam_role.codepipeline_mgmt_role.arn

    artifact_store {
        location = aws_s3_bucket.service_worker_codepipeline_bucket.bucket
        type     = "S3"
    }

    stage {
        name = "Source"

        action {
            name             = "Source"
            category         = "Source"
            owner            = "AWS"
            provider         = "CodeCommit"
            version          = "1"
            output_artifacts = ["source_output"]
            configuration = {
                RepositoryName   = "bespin-launcher-worker"
                BranchName       = "master"
                OutputArtifactFormat = "CODEBUILD_CLONE_REF"
            }
        }
    }

    stage {
        name = "Build"

        action {
            name             = "Build"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            input_artifacts  = ["source_output"]
            output_artifacts = ["build_output"]
            version          = "1"
            configuration = {
                ProjectName = aws_codebuild_project.service_worker.name
            }
        }
    }

    stage {
        name = "Deploy"

        action {
            name            = "Deploy"
            category        = "Deploy"
            owner           = "AWS"
            provider        = "CodeDeploy"
            input_artifacts = ["build_output"]
            version         = "1"
            configuration = {
                ApplicationName = aws_codedeploy_app.service_worker.name
                DeploymentGroupName = aws_codedeploy_deployment_group.service_worker.deployment_group_name
            }
        }
    }
}