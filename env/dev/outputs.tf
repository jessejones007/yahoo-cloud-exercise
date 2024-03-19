output "kms_key_id" {
  value = module.kms.kms_key_id
}

output "s3_bucket_name" {
  value = module.s3.bucket_id
}

output "create_timestamp_lambda_function_name" {
  value = module.lambda_create_timestamp.lambda_function_name
}
output "create_timestamp_lambda_function_arn" {
  value = module.lambda_create_timestamp.lambda_function_arn
}

output "retrieve_object_lambda_function_name" {
  value = module.lambda_retrieve_object.lambda_function_name
}

output "API_Invoke_URL" {
  value = module.api_gateway.api_gateway_invoke_url
}

output "lambda_api_endpoint" {
  value = module.api_gateway.api_gateway_endpoint_url
}

