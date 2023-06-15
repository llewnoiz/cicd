resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.e2_bespinglobal_com.zone_id
  name    = "e2.bespinglobal.com"
  type    = "A"

  alias {
    name                   = aws_lb.public.dns_name
    zone_id                = aws_lb.public.zone_id
    evaluate_target_health = true
  }

}

# resource "aws_route53_record" "sl" {
#   zone_id = data.aws_route53_zone.e2_bespinglobal_com.zone_id
#   name    = "sl"
#   type    = "CNAME"
#   ttl     = 60
#   records = [aws_lb.public.dns_name]
# }


resource "aws_route53_record" "admin" {
  zone_id = data.aws_route53_zone.e2_bespinglobal_com.zone_id
  name    = "admin"
  type    = "CNAME"
  ttl     = 60
  records = [aws_lb.public.dns_name]
}

resource "aws_route53_record" "static" {
    zone_id = data.aws_route53_zone.e2_bespinglobal_com.zone_id
    name    = "static"
    type    = "CNAME"
    ttl     = 60
    records = [aws_cloudfront_distribution.s3_distribution.domain_name]
}