variable "region" {
 
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  default = "count-yemi-bucket-24-06-27"
  type        = string
}

variable "domain_name" {
  default = "countyemi.site"
}

variable "cloudfront_certificate_arn" {
  default = "arn:aws:acm:us-east-1:339713184742:certificate/6d5efc23-694b-42f9-9139-7e9aaa2cf495"
}

variable "api_name" {

  default = "static-api"
  
}

variable "custom_domain" {
  default = "static.countyemi.site"
}



