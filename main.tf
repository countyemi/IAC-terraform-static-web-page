# Define the AWS provider
provider "aws" {
  region = var.region
}

# Call the S3 module
module "bucket" {
  source = "./modules/bucket"
  bucket_name = var.bucket_name
 
}


module "cloud_front" {
  source = "./modules/cloud_front"
 
   s3_bucket_domain_name = module.bucket.s3_bucket_domain_name
   bucket_name = var.bucket_name
 
}

module "api_gateway" {
  source = "./modules/api_gateway"
  api_name = var.api_name
  cloudfront_url  = "https://${module.cloud_front.cloudfront_domain_name}"
  cloudfront_certificate_arn = var.cloudfront_certificate_arn
  domain_name = var.domain_name
}

module "route53" {
  source = "./modules/route53"
  domain_name = var.domain_name
  cloudfront_url = "https://${module.cloud_front.cloudfront_domain_name}"
  api_name = module.api_gateway.api_id
  stage_name  =  module.api_gateway.stage_name
   cloudfront_certificate_arn = var.cloudfront_certificate_arn
  bucket_name = module.bucket.bucket_name
  custom_domain = var.custom_domain
}



