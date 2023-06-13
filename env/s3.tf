# S3 bucket for backend
resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.aws.csp_prefix}-${var.backend.remote.bucket}"
  force_destroy = true

  tags = {
    Name: "${var.aws.csp_prefix}-s3-tf-env"
    Group: "${var.aws.csp_prefix}-tf-provision"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}


