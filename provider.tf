terraform {
  required_providers {
    aws = {
        source ="hashicorp/aws"
        version = ">=2.64.0"
    }
  }
}

provider "aws" {
  region="${var.region}"
}