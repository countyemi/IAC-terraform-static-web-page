resource "aws_cloudfront_origin_access_identity" "s3_identity" {
  comment = "Allow CloudFront to access S3 bucket"
}

resource "aws_cloudfront_distribution" "website_distribution" {
  origin {
    domain_name = module.s3_bucket.s3_bucket_domain_name
    origin_id   = "S3-${module.s3_bucket.s3_bucket_domain_name}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  default_root_object = var.index_document

  default_cache_behavior {
    target_origin_id       = "S3-${module.s3_bucket.s3_bucket_domain_name}"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
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

  price_class = "PriceClass_100"

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = var.tags
}
