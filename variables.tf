variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
  default     = {}
}

##################
# Lambda Function
##################
variable "function_name" {
  description = "Unique name for your Lambda Function"
  type        = string
}

variable "role" {
  description = "Amazon Resource Name (ARN) of the function's execution role. The role provides the function's identity and access to AWS services and resources."
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of what your Lambda Function does."
  type        = string
  default     = ""
}

variable "handler" {
  description = "Function entrypoint in your code."
  type        = string
  default     = "index.handler"
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime."
  type        = number
  default     = 128
}

variable "architectures" {
  description = "Instruction set architecture for your Lambda function. Valid values are [\"x86_64\"] and [\"arm64\"]. Removing this attribute, function's architecture stay the same."
  type        = list(string)
  default     = ["x86_64"]
}

variable "package_type" {
  description = "Lambda deployment package type. Valid values are Zip and Image."
  type        = string
  default     = "Zip"
}

variable "reserved_concurrent_executions" {
  description = "Amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."
  type        = number
  default     = -1
}

variable "runtime" {
  description = "Identifier of the function's runtime."
  type        = string
  default     = "nodejs12.x"
}

variable "timeout" {
  description = "Amount of time your Lambda Function has to run in seconds."
  type        = number
  default     = 3
}

variable "publish" {
  description = "Whether to publish creation/change as new Lambda Function Version."
  type        = bool
  default     = false
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}

variable "kms_key_arn" {
  description = "Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key. If this configuration is provided when environment variables are not in use, the AWS Lambda API does not save this configuration and Terraform will show a perpetual difference of adding the key. To fix the perpetual difference, remove this configuration."
  type        = string
  default     = ""
}

variable "image_uri" {
  description = "ECR image URI containing the function's deployment package. Conflicts with filename, s3_bucket, s3_key, and s3_object_version."
  type        = string
  default     = null
}

variable "image_config_command" {
  description = "Parameters that you want to pass in with entry_point."
  type        = list(string)
  default     = []
}

variable "image_config_entry_point" {
  description = "Entry point to your application, which is typically the location of the runtime executable."
  type        = list(string)
  default     = []

}

variable "image_config_working_directory" {
  description = "Working directory."
  type        = string
  default     = null
}

variable "filename" {
  description = "Path to the function's deployment package within the local filesystem. Conflicts with image_uri, s3_bucket, s3_key, and s3_object_version."
  type        = string
  default     = null
}

variable "source_code_hash" {
  description = "Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. The usual way to set this is filebase64sha256(\"file.zip\") (Terraform 0.11.12 and later) , where \"file.zip\" is the local filename of the lambda function source archive."
  type        = string
  default     = null
}

variable "vpc_config_security_group_ids" {
  description = "List of security group IDs associated with the Lambda function that should run inside the VPC."
  type        = list(string)
  default     = null
}

variable "vpc_config_subnet_ids" {
  description = "List of subnet IDs associated with the Lambda function that should run inside the VPC."
  type        = list(string)
  default     = null
}

##############################
# Lambda Event Source Mapping
##############################
variable "event_source_mapping" {
  description = "Map of event source mapping"
  type        = any
  default     = {}
}

#############################
# Lambda Trigger Permissions
#############################
variable "enable_lambda_triggers" {
  description = "Enable triggers for Lambda"
  type        = bool
  default     = false
}

variable "lambda_triggers" {
  description = "Map of triggers for Lambda"
  type        = any
  default     = {}
}

####################
# Lambda Cloudwatch
####################
variable "enable_logs" {
  description = "Enable the creation of a log file for Lambda function."
  type        = bool
  default     = false
}
variable "log_group_name" {
  description = "Name of log group for storing Lambda logs"
  type        = string
  default     = ""
}

variable "log_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire."
  type        = number
  default     = null
}

variable "log_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data."
  type        = string
  default     = null
}

variable "vpc_attach" {
  description = "Attach Lambda to VPC"
  type        = bool
  default     = false
}