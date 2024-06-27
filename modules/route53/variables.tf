variable "domain_name" {
   description = "The domain name for Route 53"
}

variable "cloudfront_url" {
  description = "The URL of the CloudFront distribution"
  type        = string
}

variable "api_name" {

  description = "API Gateway for CloudFront"
  type        = string

}

variable "cloudfront_certificate_arn" {
 description = "SSL certificate for custom domain name"
  type        = string
}

variable "bucket_name" {
 
  type        = string

}

variable "custom_domain" {

  type = string
  description = "custom domain name"
  
}

variable "stage_name" {

  type = string
 
  
}


