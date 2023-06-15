resource "aws_cloudfront_origin_access_identity" "service_launcher_bucket" {
    comment =  "devpart service_launcher_bucket"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  # aliases             = ["static.bespin.in"]

  origin {
    #원본 도메인
    domain_name              = aws_s3_bucket.service_launcher_bucket.bucket_regional_domain_name
    #이름
    origin_id                = aws_s3_bucket.service_launcher_bucket.bucket

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.service_launcher_bucket.cloudfront_access_identity_path
    }

  }

  default_cache_behavior {

    #자동으로 객체 압축
    compress            = true

    #뷰어
    #뷰어 프로토콜 정책
    viewer_protocol_policy = "allow-all"

    #허용된 HTTP 방법
    allowed_methods  = ["GET", "HEAD"]


    cached_methods   = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.service_launcher_bucket.bucket

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  #설정
  #북미, 유럽, 아시아, 중동 및 아프리카에서 사용
  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "KR"]
    }
  }
  # AWS WAF 웹 ACL - 선택 사항
  web_acl_id          = aws_waf_web_acl.service_launcher_bucket.id
  # 사용자 정의 SSL 인증서 - 선택 사항
  viewer_certificate {
    cloudfront_default_certificate = true
    acm_certificate_arn = aws_acm_certificate.cert_virginia.arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  #지원되는 HTTP 버전
  http_version = "http2"

  #IPv6 끄기
  is_ipv6_enabled     = false
  

  tags = {
    Name = "devPart_aws_cloudfront_distribution"
    MN = "devPart"
  }

  depends_on = [
    aws_acm_certificate.cert_virginia,
    aws_waf_web_acl.service_launcher_bucket,
    aws_s3_bucket.service_launcher_bucket
  ]
}