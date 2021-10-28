terraform {
  required_providers {
    aws = {
        source ="hashicorp/aws"
        version = ">=2.64.0"
    }
  }
}

provider "aws" {
<<<<<<< HEAD
=======
  profile ="default"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
>>>>>>> 94e18901e92aa9f50fd205cbf4089d3c506f4c03
  region="${var.region}"
}
