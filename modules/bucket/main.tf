resource "aws_s3_bucket" "web_bucket" {
    bucket = var.bucket_name
    
 
}

resource "aws_s3_bucket_public_access_block" "make_private" {
  bucket = aws_s3_bucket.web_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cloudfront_origin_access_identity" "s3_identity" {
  comment = "Origin access identity for ${var.bucket_name}"
}

resource "aws_s3_bucket_policy" "web_bucket_policy" {
  bucket = aws_s3_bucket.web_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          AWS = "${aws_cloudfront_origin_access_identity.s3_identity.iam_arn}"
        },
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.web_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.web_bucket.bucket
  key    = "index.html"
  source = "${path.module}./index.html"  
  content_type = "text/html"
  

}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.web_bucket.bucket
  key    = "error.html"
  source = "${path.module}./error.html"  
  content_type = "text/html"

}









