terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.2.0"
    }
  }
}

provider "aws" {
  # Configuration options
  profile = "mfa"
  region = "ap-northeast-2"
}
