output "s3_bucket_domain_name" {
  value = module.bucket.s3_bucket_domain_name
}

# output "cloudfront_url" {
#   value = module.cloud_front.cloudfront_domain_name
# }

# output "cloudfront_url" {
#   value = module.cloud_front.cloudfront_domain_name
# }


output "invoke_url" {
  value = module.api_gateway.invoke_url
}