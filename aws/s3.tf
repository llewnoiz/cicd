######################################### #CODE BUILD ######################################### 
#APP-SL
resource "aws_s3_bucket" "app_sl" {
  bucket = "devpart-bs-app-build"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "app_sl" {
  depends_on = [aws_s3_bucket_ownership_controls.app_sl]

  bucket = aws_s3_bucket.app_sl.id
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "app_sl" {
  bucket = aws_s3_bucket.app_sl.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

######################################### #CODE BUILD ######################################### 

######################################### #CODEPIPELINE ######################################### 

#APP-SL
resource "aws_s3_bucket" "app_sl_codepipeline_bucket" {
  bucket = "devpart-bs-codepipeline-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "app_sl_codepipeline_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.app_sl_codepipeline_bucket_acl]
  bucket = aws_s3_bucket.app_sl_codepipeline_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "app_sl_codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.app_sl_codepipeline_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
######################################### #CODEPIPELINE ######################################### 