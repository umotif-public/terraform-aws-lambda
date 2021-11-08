data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "minimal_lambda" {
  source = "../../"

  function_name = "minimal"

  image_uri    = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/lambda/example-python:latest"
  package_type = "Image"
}