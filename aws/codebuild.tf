#APP-SL

resource "aws_codebuild_project" "app_sl" {
  name           = "app_sl"
  description    = "app_sl"
  badge_enabled  = false
  build_timeout = "60"
  service_role = aws_iam_role.codebuild_mgmt_role.arn

  source {
    type            = "CODEPIPELINE"
    location        = "https://git-codecommit.ap-northeast-2.amazonaws.com/v1/repos/bespin-app-sl"
    git_clone_depth = 1

    buildspec = "deploy/build-spec.yml"
    git_submodules_config {
      fetch_submodules = true
    }
  }
  source_version = "master"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode = true
  }

  logs_config {
      cloudwatch_logs {
        group_name = "/build/app_sl"
      }
  }

    tags = {
        Name = "aws_codebuild_project app_sl"
        MN = "devPart"
    }
}



resource "aws_codebuild_project" "nginx" {
  name           = "nginx"
  description    = "nginx"
  badge_enabled  = false
  build_timeout = "60"
  service_role = aws_iam_role.codebuild_mgmt_role.arn

  source {
    type            = "CODEPIPELINE"
    location        = "https://git-codecommit.ap-northeast-2.amazonaws.com/v1/repos/bespin-nginx"
    git_clone_depth = 1

    buildspec = "deploy/build-spec.yml"
    git_submodules_config {
      fetch_submodules = true
    }
  }
  source_version = "master"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode = true
  }

  logs_config {
      cloudwatch_logs {
        group_name = "/build/nginx"
      }
  }

    tags = {
        Name = "aws_codebuild_project nginx"
        MN = "devPart"
    }
}

#SVC-SL

resource "aws_codebuild_project" "nodejs" {
  name           = "nodejs"
  description    = "nodejs"
  badge_enabled  = false
  build_timeout = "60"
  service_role = aws_iam_role.codebuild_mgmt_role.arn

  source {
    type            = "CODEPIPELINE"
    location        = "https://git-codecommit.ap-northeast-2.amazonaws.com/v1/repos/bespin-nodejs"
    git_clone_depth = 1

    buildspec = "deploy/build-spec.yml"
    git_submodules_config {
      fetch_submodules = true
    }
  }
  source_version = "master"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode = true
  }

  logs_config {
      cloudwatch_logs {
        group_name = "/build/nodejs"
      }
  }

    tags = {
        Name = "aws_codebuild_project nodejs"
        MN = "devPart"
    }
}

