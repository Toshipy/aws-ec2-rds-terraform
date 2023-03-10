# ACM for Tokyo Region
# resource "aws_acm_certificate" "tokyo_cert" {
#   domain_name       = "00374.engineed-exam.com"
#   validation_method = "DNS"

#   tags = {
#     Name = "ACM"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }


# }

# ACM for Virginia Region
resource "aws_acm_certificate" "virginia_cert" {
  provider = aws.virginia

  domain_name       = "00374.engineed-exam.com"
  validation_method = "DNS"

  tags = {
    Name = "ACM"
  }

  lifecycle {
    create_before_destroy = true
  }


}

# resource "aws_route53_record" "route53_acm_dns_resolve" {
#   for_each = {
#     for dvo in aws_acm_certificate.tokyo_cert.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       type   = dvo.resource_record_type
#       record = dvo.resource_record_value
#     }
#   }

#   allow_overwrite = true
#   zone_id         = "Z00995921EHOMVDSTO90J"
#   name            = each.value.name
#   type            = each.value.type
#   ttl             = 600
#   records         = [each.value.record]

# }

# resource "aws_acm_certificate_validation" "cert_valid" {
#   certificate_arn         = aws_acm_certificate.tokyo_cert.arn
#   validation_record_fqdns = [for record in aws_route53_record.route53_acm_dns_resolve : record.fqdn]
# }


