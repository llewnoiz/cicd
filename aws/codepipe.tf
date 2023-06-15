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



resource "aws_codepipeline" "nginx" {
    name     = "nginx-pipeline"
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
                RepositoryName   = "bespin-nginx"
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
                ProjectName = aws_codebuild_project.nginx.name
            }
        }
    }

}


resource "aws_codepipeline" "nodejs" {
    name     = "nodejs-pipeline"
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
                RepositoryName   = "bespin-nodejs"
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
                ProjectName = aws_codebuild_project.nodejs.name
            }
        }
    }
}
