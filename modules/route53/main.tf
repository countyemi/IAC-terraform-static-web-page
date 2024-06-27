module "api_gateway" {
  source = "../api_gateway"
  api_name = var.api_name
  cloudfront_url  = "https://${module.cloud_front.cloudfront_domain_name}"
  cloudfront_certificate_arn = var.cloudfront_certificate_arn
  domain_name = var.domain_name
}
module "bucket" {
  source = "../bucket"
  bucket_name = var.bucket_name
 
}

module "cloud_front" {
  source = "../cloud_front"
 
   s3_bucket_domain_name = module.bucket.s3_bucket_domain_name
   bucket_name =  var.bucket_name
 
}

resource "aws_route53_zone" "main" {
  name = var.domain_name
}






resource "aws_api_gateway_domain_name" "api_domain" {
  domain_name              = var.custom_domain
  regional_certificate_arn     = var.cloudfront_certificate_arn
  security_policy          = "TLS_1_2"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_route53_record" "static_domain" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.custom_domain
  type    = "A"
  #ttl     = "300"

  alias {
    name                   = module.api_gateway.invoke_url
    zone_id                = aws_route53_zone.main.zone_id

    evaluate_target_health = false
  }
}

# API Gateway base path mapping
resource "aws_api_gateway_base_path_mapping" "base_path_mapping" {

  domain_name = aws_api_gateway_domain_name.api_domain.domain_name
  api_id =      module.api_gateway.api_id
  stage_name  =  module.api_gateway.stage_name
}

