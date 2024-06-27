variable "cloudfront_url" {
  description = "The URL of the CloudFront distribution"
  type        = string
}

variable "api_name" {

  description = "API Gateway for Cloud-Front"
  type        = string

}

variable "cloudfront_certificate_arn" {
 description = "SSL certificate for custom domain name"
  type        = string
}

variable "domain_name" {
   description = "root domain name"
   type        = string
}

