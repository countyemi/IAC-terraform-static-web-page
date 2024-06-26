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
  # s3_bucket_domain_name = module.s3_bucket.s3_bucket_domain_name
  # oai_cloudfront_iam_arn = module.s3_bucket.oai_cloudfront_iam_arn
  # aliases = var.aliases
  # tags = var.tags
   s3_bucket_domain_name = module.bucket.s3_bucket_domain_name
   bucket_name = var.bucket_name
 
}

module "api_gateway" {
  source = "./modules/api_gateway"
  cloudfront_url  = "https://${module.cloud_front.cloudfront_domain_name}"
}

# module "route53" {
#   source = "./modules/route53"
#   domain_name = var.domain_name
#   cloudfront_distribution_id = module.cloudfront.cloudfront_distribution_id
# }

# module "iam" {
#   source = "./modules/iam"
# }

