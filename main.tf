# Define the AWS provider
provider "aws" {
  region = var.region
}

# Call the S3 module
module "s3_bucket" {
  source = "./modules/s3_bucket"
  bucket_name = var.bucket_name
 
}
