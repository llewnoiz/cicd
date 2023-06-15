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


#APP-ADMIN

resource "aws_codebuild_project" "app_admin" {
  name           = "app_admin"
  description    = "app_admin"
  badge_enabled  = false
  build_timeout = "60"
  service_role = aws_iam_role.codebuild_mgmt_role.arn

  source {
    type            = "CODEPIPELINE"
    location        = "https://git-codecommit.ap-northeast-2.amazonaws.com/v1/repos/bespin-app-admin"
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
        group_name = "/build/app_admin"
      }
  }

    tags = {
        Name = "aws_codebuild_project app_admin"
        MN = "devPart"
    }
}

#SVC-SL

resource "aws_codebuild_project" "service_sl" {
  name           = "service_sl"
  description    = "service_sl"
  badge_enabled  = false
  build_timeout = "60"
  service_role = aws_iam_role.codebuild_mgmt_role.arn

  source {
    type            = "CODEPIPELINE"
    location        = "https://git-codecommit.ap-northeast-2.amazonaws.com/v1/repos/bespin-svc-sl"
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
        group_name = "/build/service_sl"
      }
  }

    tags = {
        Name = "aws_codebuild_project service_sl"
        MN = "devPart"
    }
}


#SVC-ADMIN

resource "aws_codebuild_project" "service_admin" {
  name           = "service_admin"
  description    = "service_admin"
  badge_enabled  = false
  build_timeout = "60"
  service_role = aws_iam_role.codebuild_mgmt_role.arn

  source {
    type            = "CODEPIPELINE"
    location        = "https://git-codecommit.ap-northeast-2.amazonaws.com/v1/repos/bespin-svc-admin"
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
        group_name = "/build/service_admin"
      }
  }

    tags = {
        Name = "aws_codebuild_project service_admin"
        MN = "devPart"
    }
}


#SVC-WORKER

resource "aws_codebuild_project" "service_worker" {
  name           = "service_worker"
  description    = "service_worker"
  badge_enabled  = false
  build_timeout = "60"
  service_role = aws_iam_role.codebuild_mgmt_role.arn

  source {
    type            = "CODEPIPELINE"
    location        = "https://git-codecommit.ap-northeast-2.amazonaws.com/v1/repos/bespin-launcher-worker"
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
        group_name = "/build/service_worker"
      }
  }

    tags = {
        Name = "aws_codebuild_project service_worker"
        MN = "devPart"
    }
}