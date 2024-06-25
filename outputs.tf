output "s3_bucket_domain_name" {
  value = module.s3_bucket.s3_bucket_domain_name
}

output "cloudfront_url" {
  value = module.cloudfront.cloudfront_domain_name
}
