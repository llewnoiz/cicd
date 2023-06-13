# DynamoDB for terraform state lock
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "${var.aws.csp_prefix}-${var.backend.remote.lockFile}"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name: "${var.aws.csp_prefix}-dynamodb"
    Group: "${var.aws.csp_prefix}-tf-provision"
  }
}
