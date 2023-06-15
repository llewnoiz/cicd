locals {
  iam_user = "devpart-git-user"
}

resource "aws_iam_user" "iam_user" {
  name = local.iam_user
}

resource "aws_iam_service_specific_credential" "iam_user" {
  service_name = "codecommit.amazonaws.com"
  user_name    = aws_iam_user.iam_user.name
}

resource "aws_iam_access_key" "iam_user_access_key" {
  user    = aws_iam_user.iam_user.name
}

resource "aws_iam_user_policy_attachment" "iam_user_attach" {
  user       = aws_iam_user.iam_user.name
  policy_arn = data.aws_iam_policy.AWSCodeCommitPowerUser.arn
}

output "iam_user_htttps_access_key" {
  value = {
    username = aws_iam_service_specific_credential.iam_user.service_user_name
    password = nonsensitive(aws_iam_service_specific_credential.iam_user.service_password)    
  }
}

output "iam_user_access_key" {
  value = {
    access_key = aws_iam_access_key.iam_user_access_key.id
    secret_key = nonsensitive(aws_iam_access_key.iam_user_access_key.secret)
  }
}