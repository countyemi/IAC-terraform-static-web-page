variable "bucket_name" {
   
    type = string
    #default = "count-yemi-static-bucket-24-06-24"

}

variable "index_document" {
  type        = string
  default     = "index.html"
}

variable "error_document" {
    type        = string
    default     = "error.html"
}