data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "core_lambda" {
  source = "../../"

  function_name = "core"

  image_uri    = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/lambda/example-python:latest"
  package_type = "Image"

  enable_logs    = true
  log_group_name = "core-lambda-log"
}