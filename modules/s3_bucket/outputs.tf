output "bucket_name" {
    value = aws_s3_bucket.web_bucket.bucket
  
}

output "bucket_arn" {
  value = aws_s3_bucket.web_bucket.arn
}

output "s3_bucket_domain_name" {
  value = aws_s3_bucket.web_bucket.bucket_regional_domain_name
}

output "s3_bucket_id" {
  value = aws_s3_bucket.web_bucket.id
}