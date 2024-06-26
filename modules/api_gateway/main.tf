resource "aws_api_gateway_rest_api" "bucket_api" {
  name        = "latest"
  description = "API Gateway for CloudFront"
  
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# resource "aws_api_gateway_resource" "bucket_api_resource" {
#   rest_api_id = aws_api_gateway_rest_api.bucket_api.id
#   parent_id   = aws_api_gateway_rest_api.bucket_api.root_resource_id
#   path_part   = "path"
# }

resource "aws_api_gateway_method" "bucket_api_method" {
  rest_api_id   = aws_api_gateway_rest_api.bucket_api.id
  resource_id   = aws_api_gateway_rest_api.bucket_api.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "bucket_api_integration" {
  rest_api_id             = aws_api_gateway_rest_api.bucket_api.id
  resource_id             = aws_api_gateway_method.bucket_api_method.resource_id
  http_method             = aws_api_gateway_method.bucket_api_method.http_method
    type                    = "HTTP_PROXY"
  integration_http_method = "GET"
  uri                     = var.cloudfront_url
}

resource "aws_api_gateway_deployment" "bucket_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.bucket_api.id
  stage_name  = "prod"

  depends_on = [
    aws_api_gateway_integration.bucket_api_integration,
  ]
}


