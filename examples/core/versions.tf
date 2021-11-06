terraform {
  required_version = ">= 0.13.7"

  required_providers {
    aws = ">= 3.19"
  }
}

provider "aws" {
  region = "eu-west-1"
}