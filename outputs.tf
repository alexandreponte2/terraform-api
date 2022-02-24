output "complete_unvoke_url" {
  value = "${aws_api_gateway_deployment.deployment1.invoke_url}${aws_api_gateway_stage.example.stage_name}/${aws_api_gateway_resource.toguro.path_part}"
}

output "api_url" {
  value = aws_api_gateway_deployment.deployment1.invoke_url
}

output "lambda_arn" {
  value = aws_lambda_function.test_lambda.invoke_arn
}