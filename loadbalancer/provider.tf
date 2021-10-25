terraform {
  required_providers {
    aws = {
        source ="hashicorp/aws"
        verversion = ">=2.64.0"
    }
  }
}

provider "aws" {
  profile ="default"
  /*access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  */
  region="${var.region}"
}