variable "schedule_name" {
  description = "The name of the schedule."
  type        = string
}

variable "schedule_expression" {
  description = "The scheduling expression. For example, 'rate(10 minutes)' or 'cron(0 20 * * ? *)'."
  type        = string
}

variable "lambda_function_name" {
  description = "The name of the Lambda function to be invoked."
  type        = string
}

variable "lambda_function_arn" {
  description = "The ARN of the Lambda function to be invoked."
  type        = string
}
