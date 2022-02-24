################ API GATEWAY ################

resource "aws_api_gateway_rest_api" "alexandre" {
  name = "alexandre"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "toguro" {
  rest_api_id = aws_api_gateway_rest_api.alexandre.id
  parent_id   = aws_api_gateway_rest_api.alexandre.root_resource_id
  path_part   = "toguro"
}

// POST
resource "aws_api_gateway_method" "post" {
  rest_api_id      = aws_api_gateway_rest_api.alexandre.id
  resource_id      = aws_api_gateway_resource.toguro.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.alexandre.id
  resource_id             = aws_api_gateway_resource.toguro.id
  http_method             = aws_api_gateway_method.post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.test_lambda.invoke_arn
}

// GET
resource "aws_api_gateway_method" "get" {
  rest_api_id      = aws_api_gateway_rest_api.alexandre.id
  resource_id      = aws_api_gateway_resource.toguro.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "integration-get" {
  rest_api_id             = aws_api_gateway_rest_api.alexandre.id
  resource_id             = aws_api_gateway_resource.toguro.id
  http_method             = aws_api_gateway_method.get.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.test_lambda.invoke_arn
}

################ Deployment of API gateway ################

resource "aws_api_gateway_deployment" "deployment1" {
  rest_api_id = aws_api_gateway_rest_api.alexandre.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.alexandre.body))
  }

  depends_on = [aws_api_gateway_integration.integration]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.deployment1.id
  rest_api_id   = aws_api_gateway_rest_api.alexandre.id
  stage_name    = var.aws_profile
}