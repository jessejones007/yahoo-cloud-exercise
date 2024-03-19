output "api_gateway_invoke_url" {
  value = "${aws_api_gateway_deployment.api_deployment.invoke_url}/${var.stage_name}/${var.resource_path}"
}

output "api_gateway_endpoint_url" {
  description = "The endpoint URL of the API Gateway"
  value       = "https://${aws_api_gateway_rest_api.api.id}.execute-api.${var.region}.amazonaws.com/${var.stage_name}/retrieve_most_recent_object_dev"
}
