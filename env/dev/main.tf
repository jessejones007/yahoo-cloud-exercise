module "kms" {
  source     = "../../modules/kms"
  alias_name = "dev-timestamp-key"
}

module "s3" {
  source      = "../../modules/s3"
  bucket_name = var.bucket_name
  kms_key_id  = module.kms.kms_key_id
}

module "iam" {
  source      = "../../modules/iam"
  bucket_name = var.bucket_name
  kms_arn     = module.kms.kms_key_arn
}

module "lambda_create_timestamp" {
  source               = "../../modules/lambda"
  function_name        = "create_encrypted_timestamp_dev"
  handler              = "create_encrypted_timestamp.lambda_handler"
  runtime              = "python3.8"
  role_arn             = module.iam.lambda_exec_role_arn
  source_code_zip_file = "${path.module}/../../modules/code/create_encrypted_timestamp.zip"
  environment_variables = {
    BUCKET_NAME = module.s3.bucket_id
    KMS_KEY_ID  = module.kms.kms_key_id
  }
}

module "lambda_retrieve_object" {
  source               = "../../modules/lambda"
  function_name        = var.function_name
  handler              = "retrieve_most_recent_object.lambda_handler"
  runtime              = "python3.8"
  role_arn             = module.iam.lambda_exec_role_arn
  source_code_zip_file = "${path.module}/../../modules/code/retrieve_most_recent_object.zip"
  environment_variables = {
    BUCKET_NAME = module.s3.bucket_id
    KMS_KEY_ID  = module.kms.kms_key_id
  }
}

module "lambda_scheduled_trigger" {
  source               = "../../modules/eventbridge"
  schedule_name        = "every_10_minutes"
  schedule_expression  = "rate(10 minutes)"
  lambda_function_name = module.lambda_create_timestamp.lambda_function_name
  lambda_function_arn  = module.lambda_create_timestamp.lambda_function_arn
}


module "api_gateway" {
  source             = "../../modules/api_gateway"
  api_name           = "MyDemoAPI"
  resource_path      = "myresource"
  http_method        = "GET"
 function_name = var.function_name
  lambda_function_arn = module.lambda_retrieve_object.lambda_function_arn
  lambda_invoke_arn = module.lambda_retrieve_object.lambda_invoke_arn
  stage_name         = "dev"
  region = var.region
}

