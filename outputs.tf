#################
# Lambda Function
#################
output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value       = aws_lambda_function.main.function_name
}

output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = aws_lambda_function.main.arn
}

output "lambda_function_invoke_arn" {
  description = "The Invoke ARN of the Lambda Function"
  value       = aws_lambda_function.main.invoke_arn
}

output "lambda_function_last_modified" {
  description = "The date Lambda Function resource was last modified"
  value       = element(concat(aws_lambda_function.main.*.last_modified, [""]), 0)
}

output "lambda_function_qualified_arn" {
  description = "The ARN identifying your Lambda Function Version"
  value       = element(concat(aws_lambda_function.main.*.qualified_arn, [""]), 0)
}

output "lambda_function_signing_job_arn" {
  description = "The ARN of the signing job"
  value       = element(concat(aws_lambda_function.main.*.signing_job_arn, [""]), 0)
}

output "lambda_function_signing_profile_version_arn" {
  description = "The ARN of the signing profile version"
  value = element(concat(aws_lambda_function.main.*.signing_profile_version_arn
  , [""]), 0)
}

output "lambda_function_source_code_size" {
  description = "The size in bytes of the function .zip file"
  value       = element(concat(aws_lambda_function.main.*.source_code_size, [""]), 0)
}

output "lambda_function_version" {
  description = "Latest published version of Lambda Function"
  value       = element(concat(aws_lambda_function.main.*.version, [""]), 0)
}

output "lambda_function_kms_key_arn" {
  description = "The ARN for the KMS encryption key of Lambda Function"
  value       = element(concat(aws_lambda_function.main.*.kms_key_arn, [""]), 0)
}

output "lambda_function_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file"
  value       = element(concat(aws_lambda_function.main.*.source_code_hash, [""]), 0)
}

output "lambda_function_image_uri" {
  description = "ECR image URI containing the function's deployment package"
  value       = element(concat(aws_lambda_function.main.*.image_uri, [""]), 0)
}
###########
# IAM Role
###########
output "lambda_role_arn" {
  description = "The ARN of the IAM role created for the Lambda Function"
  value       = element(concat(aws_iam_role.lambda.*.arn, [""]), 0)
}

output "lambda_role_name" {
  description = "The name of the IAM role created for the Lambda Function"
  value       = element(concat(aws_iam_role.lambda.*.name, [""]), 0)
}

######################
# CloudWatch Log Group
######################
output "lambda_cloudwatch_log_group_arn" {
  description = "The ARN of the Cloudwatch Log Group"
  value       = var.enable_logs ? aws_cloudwatch_log_group.main[0].arn : null
}

output "lambda_cloudwatch_log_group_name" {
  description = "The name of the Cloudwatch Log Group"
  value       = var.enable_logs ? aws_cloudwatch_log_group.main[0].name : null
}