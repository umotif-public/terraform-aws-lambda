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

  name               = "${var.name_prefix}-lambda-assume-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role[0].json

  tags = var.tags
}