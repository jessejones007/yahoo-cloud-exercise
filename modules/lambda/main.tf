resource "aws_lambda_function" "lambda" {
  function_name = var.function_name
  handler       = var.handler
  role          = var.role_arn
  runtime       = var.runtime
  timeout = 450
  source_code_hash = filebase64sha256(var.source_code_zip_file)
  filename         = var.source_code_zip_file

  environment {
    variables = var.environment_variables
  }
}
