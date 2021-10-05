##################
# Function
##################
resource "aws_lambda_function" "main" {
  function_name                  = "${var.name_prefix}-function"
  description                    = var.description
  role                           = var.role == "" ? aws_iam_role.lambda[0].arn : var.role
  runtime                        = var.package_type != "Zip" ? null : var.runtime
  handler                        = var.package_type != "Zip" ? null : var.handler
  timeout                        = var.timeout
  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions
  image_uri                      = var.image_uri
  package_type                   = var.package_type
  architectures                  = var.architectures
  publish                        = var.publish
  kms_key_arn                    = var.kms_key_arn

  filename         = var.image_uri != "" ? null : var.filename
  source_code_hash = var.image_uri != "" ? null : var.source_code_hash

  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.environment_variables
    }
  }

  dynamic "image_config" {
    for_each = length(var.image_config_entry_point) > 0 || length(var.image_config_command) > 0 || var.image_config_working_directory != null ? [true] : []
    content {
      command           = var.image_config_command
      entry_point       = var.image_config_entry_point
      working_directory = var.image_config_working_directory
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config_subnet_ids != null && var.vpc_config_security_group_ids != null ? [true] : []
    content {
      security_group_ids = var.vpc_config_security_group_ids
      subnet_ids         = var.vpc_config_subnet_ids
    }
  }

  tags = var.tags

  depends_on = [aws_cloudwatch_log_group.main]
}

resource "aws_lambda_event_source_mapping" "main" {
  for_each = var.enable_lambda_triggers ? var.event_source_mapping : tomap({})

  function_name = aws_lambda_function.main.arn

  event_source_arn = each.value.event_source_arn

  batch_size                         = lookup(each.value, "batch_size", null)
  bisect_batch_on_function_error     = lookup(each.value, "bisect_batch_on_function_error", null)
  enabled                            = lookup(each.value, "enabled", null)
  maximum_batching_window_in_seconds = lookup(each.value, "maximum_batching_window_in_seconds", null)
  maximum_record_age_in_seconds      = lookup(each.value, "maximum_record_age_in_seconds", null)
  maximum_retry_attempts             = lookup(each.value, "maximum_retry_attempts", null)
  parallelization_factor             = lookup(each.value, "parallelization_factor", null)
  queues                             = lookup(each.value, "queues", null)
  starting_position                  = lookup(each.value, "starting_position", null)
  starting_position_timestamp        = lookup(each.value, "starting_position_timestamp", null)
  topics                             = lookup(each.value, "topics", null)
  tumbling_window_in_seconds         = lookup(each.value, "tumbling_window_in_seconds", null)

  dynamic "destination_config" {
    for_each = lookup(each.value, "destination_arn_on_failure", null) != null ? [true] : []
    content {
      on_failure {
        destination_arn = each.value["destination_arn_on_failure"]
      }
    }
  }

  dynamic "source_access_configuration" {
    for_each = lookup(each.value, "source_access_configuration", [])
    content {
      type = source_access_configuration.value["type"]
      uri  = source_access_configuration.value["uri"]
    }
  }
}

resource "aws_lambda_permission" "main" {
  for_each = var.enable_lambda_triggers ? var.lambda_triggers : {}

  function_name = aws_lambda_function.main.function_name
  qualifier     = aws_lambda_function.main.version

  statement_id       = lookup(each.value, "statement_id", each.key)
  action             = lookup(each.value, "action", "lambda:InvokeFunction")
  principal          = lookup(each.value, "principal", format("%s.amazonaws.com", lookup(each.value, "service", "")))
  source_arn         = lookup(each.value, "source_arn", null)
  source_account     = lookup(each.value, "source_account", null)
  event_source_token = lookup(each.value, "event_source_token", null)
}

#############
# Cloudwatch
#############
resource "aws_cloudwatch_log_group" "main" {
  count = var.enable_logs ? 1 : 0

  name = var.log_group_name

  retention_in_days = var.log_retention_in_days
  kms_key_id        = var.log_kms_key_id

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "logs_policy" {
  role       = aws_iam_role.lambda[0].name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

######################
# VPC Logs Attachment
######################
resource "aws_iam_role_policy_attachment" "role_attach_lambdavpc" {
  count = var.vpc_attach ? 1 : 0

  role       = aws_iam_role.lambda[0].name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}