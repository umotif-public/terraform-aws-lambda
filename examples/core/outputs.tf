#################
# Lambda Function
#################
output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value       = module.core_lambda.lambda_function_name
}

output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = module.core_lambda.lambda_function_arn
}

output "lambda_function_invoke_arn" {
  description = "The Invoke ARN of the Lambda Function"
  value       = module.core_lambda.lambda_function_invoke_arn
}

output "lambda_function_last_modified" {
  description = "The date Lambda Function resource was last modified"
  value       = module.core_lambda.lambda_function_last_modified
}

output "lambda_function_qualified_arn" {
  description = "The ARN identifying your Lambda Function Version"
  value       = module.core_lambda.lambda_function_qualified_arn
}

output "lambda_function_signing_job_arn" {
  description = "The ARN of the signing job"
  value       = module.core_lambda.lambda_function_signing_job_arn
}

output "lambda_function_signing_profile_version_arn" {
  description = "The ARN of the signing profile version"
  value       = module.core_lambda.lambda_function_signing_profile_version_arn

}

output "lambda_function_source_code_size" {
  description = "The size in bytes of the function .zip file"
  value       = module.core_lambda.lambda_function_source_code_size
}

output "lambda_function_version" {
  description = "Latest published version of Lambda Function"
  value       = module.core_lambda.lambda_function_version
}

output "lambda_function_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file"
  value       = module.core_lambda.lambda_function_source_code_hash
}

output "lambda_function_image_uri" {
  description = "ECR image URI containing the function's deployment package"
  value       = module.core_lambda.lambda_function_image_uri
}
###########
# IAM Role
###########
output "lambda_role_arn" {
  description = "The ARN of the IAM role created for the Lambda Function"
  value       = module.core_lambda.lambda_role_arn
}

output "lambda_role_name" {
  description = "The name of the IAM role created for the Lambda Function"
  value       = module.core_lambda.lambda_role_name
}

######################
# CloudWatch Log Group
######################
output "lambda_cloudwatch_log_group_arn" {
  description = "The ARN of the Cloudwatch Log Group"
  value       = module.core_lambda.lambda_cloudwatch_log_group_arn
}

output "lambda_cloudwatch_log_group_name" {
  description = "The name of the Cloudwatch Log Group"
  value       = module.core_lambda.lambda_cloudwatch_log_group_name
}