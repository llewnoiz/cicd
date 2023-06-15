#APP-SL
resource "aws_codecommit_repository" "app_sl" {
  repository_name = "bespin-app-sl"
  description     = "frontend sl"
}
#APP-ADMIN
resource "aws_codecommit_repository" "nginx" {
  repository_name = "bespin-nginx"
  description     = "nginx"
}
#SVC-SL
resource "aws_codecommit_repository" "nodejs" {
  repository_name = "bespin-nodejs"
  description     = "nodejs"
}
