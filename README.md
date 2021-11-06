<!-- markdownlint-disable MD041 -->
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/umotif-public/terraform-aws-lambda)](https://github.com/umotif-public/terraform-aws-lambda/releases/latest)

# Terraform AWS Lambda

Terraform module to create [AWS Lambda](https://aws.amazon.com/lambda/) service.

**NOTE**: This module is missing a ton of features - feel free to create a pull request to add in more features!

## Terraform versions

Terraform 0.13. Pin module version to `~> v1.0`. Submit pull-requests to `main` branch.

## Usage

### Lambda Function

```hcl
module "lambda-function" {
  source = "umotif-public/lambda/aws"
  version = "~> 1.0"

  function_name = local.name_prefix
  package_type  = "Image"
  image_uri     = var.image_uri
  kms_key_arn   = var.lambda_kms_key_arn

  environment_variables = var.environment

  vpc_attach                    = var.enable_vpc_attach
  vpc_config_subnet_ids         = var.subnet_ids
  vpc_config_security_group_ids = [aws_security_group.sg_lambda.id]

  enable_logs      = var.enable_logs
  log_kms_key_id   = var.log_kms_key_id
  log_group_name   = "/aws/lambda/${local.name_prefix}"

  tags = var.tags
}
```

## Examples

* [Docker Lambda with VPC](https://github.com/umotif-public/terraform-aws-lambda/tree/main/examples/core)
* [Minimal Docker Lambda](https://github.com/umotif-public/terraform-aws-lambda/tree/main/examples/minimal)

## Authors

Module managed by [Abdul Wahid](https://github.com/Ohid25) ([LinkedIn](https://www.linkedin.com/in/abdul-wahid/)).\

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.61.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.logs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.role_attach_lambdavpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_event_source_mapping.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping) | resource |
| [aws_lambda_function.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_architectures"></a> [architectures](#input\_architectures) | Instruction set architecture for your Lambda function. Valid values are ["x86\_64"] and ["arm64"]. Removing this attribute, function's architecture stay the same. | `list(string)` | <pre>[<br>  "x86_64"<br>]</pre> | no |
| <a name="input_description"></a> [description](#input\_description) | Description of what your Lambda Function does. | `string` | `""` | no |
| <a name="input_enable_lambda_triggers"></a> [enable\_lambda\_triggers](#input\_enable\_lambda\_triggers) | Enable triggers for Lambda | `bool` | `false` | no |
| <a name="input_enable_logs"></a> [enable\_logs](#input\_enable\_logs) | Enable the creation of a log file for Lambda function. | `bool` | `false` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | A map that defines environment variables for the Lambda Function. | `map(string)` | `{}` | no |
| <a name="input_event_source_mapping"></a> [event\_source\_mapping](#input\_event\_source\_mapping) | Map of event source mapping | `any` | `{}` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | Path to the function's deployment package within the local filesystem. Conflicts with image\_uri, s3\_bucket, s3\_key, and s3\_object\_version. | `string` | `null` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Unique name for your Lambda Function | `string` | n/a | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | Function entrypoint in your code. | `string` | `"index.handler"` | no |
| <a name="input_image_config_command"></a> [image\_config\_command](#input\_image\_config\_command) | Parameters that you want to pass in with entry\_point. | `list(string)` | `[]` | no |
| <a name="input_image_config_entry_point"></a> [image\_config\_entry\_point](#input\_image\_config\_entry\_point) | Entry point to your application, which is typically the location of the runtime executable. | `list(string)` | `[]` | no |
| <a name="input_image_config_working_directory"></a> [image\_config\_working\_directory](#input\_image\_config\_working\_directory) | Working directory. | `string` | `null` | no |
| <a name="input_image_uri"></a> [image\_uri](#input\_image\_uri) | ECR image URI containing the function's deployment package. Conflicts with filename, s3\_bucket, s3\_key, and s3\_object\_version. | `string` | `null` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key. If this configuration is provided when environment variables are not in use, the AWS Lambda API does not save this configuration and Terraform will show a perpetual difference of adding the key. To fix the perpetual difference, remove this configuration. | `string` | `""` | no |
| <a name="input_lambda_triggers"></a> [lambda\_triggers](#input\_lambda\_triggers) | Map of triggers for Lambda | `any` | `{}` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | Name of log group for storing Lambda logs | `string` | `""` | no |
| <a name="input_log_kms_key_id"></a> [log\_kms\_key\_id](#input\_log\_kms\_key\_id) | The id of the KMS Key to use when encrypting log data. | `string` | `null` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire. | `number` | `null` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Amount of memory in MB your Lambda Function can use at runtime. | `number` | `128` | no |
| <a name="input_package_type"></a> [package\_type](#input\_package\_type) | Lambda deployment package type. Valid values are Zip and Image. | `string` | `"Zip"` | no |
| <a name="input_publish"></a> [publish](#input\_publish) | Whether to publish creation/change as new Lambda Function Version. | `bool` | `false` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | Amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. | `number` | `-1` | no |
| <a name="input_role"></a> [role](#input\_role) | Amazon Resource Name (ARN) of the function's execution role. The role provides the function's identity and access to AWS services and resources. | `string` | `""` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Identifier of the function's runtime. | `string` | `"nodejs12.x"` | no |
| <a name="input_source_code_hash"></a> [source\_code\_hash](#input\_source\_code\_hash) | Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3\_key. The usual way to set this is filebase64sha256("file.zip") (Terraform 0.11.12 and later) , where "file.zip" is the local filename of the lambda function source archive. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags (key-value pairs) passed to resources. | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Amount of time your Lambda Function has to run in seconds. | `number` | `3` | no |
| <a name="input_vpc_attach"></a> [vpc\_attach](#input\_vpc\_attach) | Attach Lambda to VPC | `bool` | `false` | no |
| <a name="input_vpc_config_security_group_ids"></a> [vpc\_config\_security\_group\_ids](#input\_vpc\_config\_security\_group\_ids) | List of security group IDs associated with the Lambda function that should run inside the VPC. | `list(string)` | `null` | no |
| <a name="input_vpc_config_subnet_ids"></a> [vpc\_config\_subnet\_ids](#input\_vpc\_config\_subnet\_ids) | List of subnet IDs associated with the Lambda function that should run inside the VPC. | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_cloudwatch_log_group_arn"></a> [lambda\_cloudwatch\_log\_group\_arn](#output\_lambda\_cloudwatch\_log\_group\_arn) | The ARN of the Cloudwatch Log Group |
| <a name="output_lambda_cloudwatch_log_group_name"></a> [lambda\_cloudwatch\_log\_group\_name](#output\_lambda\_cloudwatch\_log\_group\_name) | The name of the Cloudwatch Log Group |
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | The ARN of the Lambda Function |
| <a name="output_lambda_function_image_uri"></a> [lambda\_function\_image\_uri](#output\_lambda\_function\_image\_uri) | ECR image URI containing the function's deployment package |
| <a name="output_lambda_function_invoke_arn"></a> [lambda\_function\_invoke\_arn](#output\_lambda\_function\_invoke\_arn) | The Invoke ARN of the Lambda Function |
| <a name="output_lambda_function_kms_key_arn"></a> [lambda\_function\_kms\_key\_arn](#output\_lambda\_function\_kms\_key\_arn) | The ARN for the KMS encryption key of Lambda Function |
| <a name="output_lambda_function_last_modified"></a> [lambda\_function\_last\_modified](#output\_lambda\_function\_last\_modified) | The date Lambda Function resource was last modified |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | The name of the Lambda Function |
| <a name="output_lambda_function_qualified_arn"></a> [lambda\_function\_qualified\_arn](#output\_lambda\_function\_qualified\_arn) | The ARN identifying your Lambda Function Version |
| <a name="output_lambda_function_signing_job_arn"></a> [lambda\_function\_signing\_job\_arn](#output\_lambda\_function\_signing\_job\_arn) | The ARN of the signing job |
| <a name="output_lambda_function_signing_profile_version_arn"></a> [lambda\_function\_signing\_profile\_version\_arn](#output\_lambda\_function\_signing\_profile\_version\_arn) | The ARN of the signing profile version |
| <a name="output_lambda_function_source_code_hash"></a> [lambda\_function\_source\_code\_hash](#output\_lambda\_function\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the zip file |
| <a name="output_lambda_function_source_code_size"></a> [lambda\_function\_source\_code\_size](#output\_lambda\_function\_source\_code\_size) | The size in bytes of the function .zip file |
| <a name="output_lambda_function_version"></a> [lambda\_function\_version](#output\_lambda\_function\_version) | Latest published version of Lambda Function |
| <a name="output_lambda_role_arn"></a> [lambda\_role\_arn](#output\_lambda\_role\_arn) | The ARN of the IAM role created for the Lambda Function |
| <a name="output_lambda_role_name"></a> [lambda\_role\_name](#output\_lambda\_role\_name) | The name of the IAM role created for the Lambda Function |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

See LICENSE for full details.

## Pre-commit hooks

### Install dependencies

* [`pre-commit`](https://pre-commit.com/#install)
* [`terraform-docs`](https://github.com/segmentio/terraform-docs) required for `terraform_docs` hooks.
* [`TFLint`](https://github.com/terraform-linters/tflint) required for `terraform_tflint` hook.

#### MacOS

```bash
brew install pre-commit terraform-docs tflint

brew tap git-chglog/git-chglog
brew install git-chglog
```
