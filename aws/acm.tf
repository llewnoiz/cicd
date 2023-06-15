# resource "aws_route53_zone" "e2_bespinglobal_com" {
#   name = "e2.bespinglobal.com"
# }

# bespin.in
# *.bespin.in
resource "aws_acm_certificate" "cert" {
  domain_name       = "e2.bespinglobal.com"
  subject_alternative_names = ["*.e2.bespinglobal.com"]
  validation_method = "DNS"

  key_algorithm = "RSA_2048"
  tags = {
    Name = "devPart_cert"
    MN = "devPart"
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "e2_bespinglobal_com" {
  name         = "e2.bespinglobal.com"
  private_zone = false
}

resource "aws_route53_record" "e2_bespinglobal_com" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.e2_bespinglobal_com.zone_id
}

resource "aws_acm_certificate_validation" "e2_bespinglobal_com" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.e2_bespinglobal_com : record.fqdn]
}

resource "aws_acm_certificate" "cert_virginia" {

  provider = aws.virginia

  domain_name       = "e2.bespinglobal.com"
  subject_alternative_names = ["*.e2.bespinglobal.com"]
  validation_method = "DNS"

  key_algorithm = "RSA_2048"
  tags = {
    Name = "devPart_virginia_cert"
    MN = "devPart"
  }

  lifecycle {
    create_before_destroy = true
  }
}