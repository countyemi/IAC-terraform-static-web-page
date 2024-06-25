output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.website_distribution.domain_name
}
