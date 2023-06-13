#Provider
variable "profile" {
  default = "cmp"
}

variable "region" {
  default = "ap-northeast-2"
  
}

#terraform backend , s3
variable "backend" {
  description = "terraform backend s3 information"
}
