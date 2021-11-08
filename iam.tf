####
# IAM - Lambda Assume Role
####
data "aws_iam_policy_document" "assume_role" {
  count = var.role == "" ? 1 : 0

  statement {
    sid = "AllowLambdaServiceToAssumeRole"

    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  count = var.role == "" ? 1 : 0

  name               = "${var.function_name}-lambda-assume-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role[0].json

  tags = var.tags
}

#############
# Cloudwatch
#############
resource "aws_iam_role_policy_attachment" "logs_policy" {
  count = var.enable_logs ? 1 : 0

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