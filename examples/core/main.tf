data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_security_group" "default" {
  name = "default"

  filter {
    name   = "tag:Name"
    values = ["default"]
  }
}

module "core_lambda" {
  source = "../../"

  function_name = "core"

  image_uri    = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/lambda/example-python:latest"
  package_type = "Image"

  vpc_attach                    = true
  vpc_config_subnet_ids         = data.aws_subnet_ids.all.ids
  vpc_config_security_group_ids = [data.aws_security_group.default.id]

  environment_variables = {
    PROJECT = "test"
    REGION  = data.aws_region.current.name
  }

  enable_logs    = true
  log_group_name = "core-lambda-log"
}

