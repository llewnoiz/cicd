output "terraform" {
  value = {
    "backend": {
      "region": "${aws_s3_bucket.tfstate.region}",
      "bucket": "${aws_s3_bucket.tfstate.bucket}",
      "lock": "${aws_dynamodb_table.terraform_state_lock.name}"
    }
  }
}