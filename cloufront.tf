# CloudFront Cache Distribution
resource "aws_cloudfront_distribution" "cf" {
  enabled     = true
  comment     = "cache distribution"
  price_class = "PriceClass_All"
  web_acl_id                     = "arn:aws:wafv2:us-east-1:170775015612:global/webacl/WAFforCloudFront/5d734ec2-42ba-4d70-bc08-43911d8a2d52"

  origin {
    # domain_name = "00374.engineed-exam.com"
    domain_name = "alb-956211841.ap-northeast-1.elb.amazonaws.com"
    origin_id   = aws_alb.alb.name

    custom_origin_config {
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      http_port              = 80
      https_port             = 443
    }
  }

  origin {
    domain_name = aws_s3_bucket.s3_static_bucket.bucket_regional_domain_name
    origin_id = aws_s3_bucket.s3_static_bucket.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cf_s3_origin_access_identity.cloudfront_access_identity_path
    }
  }


  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]


    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }
    target_origin_id       = aws_alb.alb.name
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  ordered_cache_behavior {
    path_pattern = "/public/*"
    allowed_methods = [ "GET", "HEAD"]
    cached_methods = [ "GET", "HEAD"]
    target_origin_id = aws_s3_bucket.s3_static_bucket.id

    forwarded_values {
      query_string = false
      headers = []
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 0
    default_ttl = 86400
    max_ttl = 31536000
    compress = true
  }

  

  # aliases = []

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.virginia_cert.arn
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method       = "sni-only"
  }

}


resource "aws_route53_record" "route53_cloudfront" {
  zone_id = "Z00995921EHOMVDSTO90J"
  name    = "alb-956211841.ap-northeast-1.elb.amazonaws.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_cloudfront_origin_access_identity" "cf_s3_origin_access_identity" {
  comment = "S3 static bucket access identity"
}
