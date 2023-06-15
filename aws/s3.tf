#CLOUD FRONT
resource "aws_s3_bucket" "service_launcher_bucket" {
  bucket = "devpart-service-launcher"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "service_launcher_bucket" {
  bucket = aws_s3_bucket.service_launcher_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "service_launcher_versioning" {
  bucket = aws_s3_bucket.service_launcher_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "service_launcher_bucket" {
  bucket = aws_s3_bucket.service_launcher_bucket.id
  policy = data.aws_iam_policy_document.service_launcher_bucket.json
}

resource "aws_s3_bucket_public_access_block" "service_launcher_bucket" {
  bucket = aws_s3_bucket.service_launcher_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = false
}

# OAI 관련 정책 및 설정 필요
######################################### #CODE BUILD ######################################### 
#APP-SL
resource "aws_s3_bucket" "app_sl" {
  bucket = "devpart-app-sl"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "app_sl" {
  bucket = aws_s3_bucket.app_sl.id
  acl    = "private"
}

#APP-ADMIN

resource "aws_s3_bucket" "app_admin" {
  bucket = "devpart-app-admin"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "app_admin" {
  bucket = aws_s3_bucket.app_admin.id
  acl    = "private"
}

#SVC-SL
resource "aws_s3_bucket" "service_sl" {
  bucket = "devpart-service-sl"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "service_sl" {
  bucket = aws_s3_bucket.service_sl.id
  acl    = "private"
}
#SVC-ADMIN
resource "aws_s3_bucket" "service_admin" {
  bucket = "devpart-service-admin"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "service_admin" {
  bucket = aws_s3_bucket.service_admin.id
  acl    = "private"
}

#SVC-WORKER
resource "aws_s3_bucket" "service_worker" {
  bucket = "devpart-service-worker"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "service_worker" {
  bucket = aws_s3_bucket.service_worker.id
  acl    = "private"
}


######################################### #CODE BUILD ######################################### 

######################################### #CODEPIPELINE ######################################### 

#APP-SL
resource "aws_s3_bucket" "app_sl_codepipeline_bucket" {
  bucket = "app-sl-codepipeline-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "app_sl_codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.app_sl_codepipeline_bucket.id
  acl    = "private"
}

#APP-ADMIN

resource "aws_s3_bucket" "app_admin_codepipeline_bucket" {
  bucket = "app-admin-codepipeline-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "app_admin_codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.app_admin_codepipeline_bucket.id
  acl    = "private"
}

#SVC-SL
resource "aws_s3_bucket" "service_sl_codepipeline_bucket" {
  bucket = "service-sl-codepipeline-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "service_sl_codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.service_sl_codepipeline_bucket.id
  acl    = "private"
}

#SVC-ADMIN
resource "aws_s3_bucket" "service_admin_codepipeline_bucket" {
  bucket = "service-admin-codepipeline-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "service_admin_codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.service_admin_codepipeline_bucket.id
  acl    = "private"
}

#SVC-WORKER

resource "aws_s3_bucket" "service_worker_codepipeline_bucket" {
  bucket = "service-worker-codepipeline-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "service_worker_codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.service_worker_codepipeline_bucket.id
  acl    = "private"
}
######################################### #CODEPIPELINE ######################################### 