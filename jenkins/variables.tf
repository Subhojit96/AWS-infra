# Details of Access key
variable "access_key" {
  type = string
  description = "Enter access_key"
}
variable "secret_key" {
  type = string
  description = "Enter secret key"
}

#region
variable "region" {
  type = string
  default = "us-east-1"
  description  = "AWS_region for provisioning resources"
}

#VPC:A details
variable "vpc_A_details" {
  type = string
  default = "10.0.0.0/16"
}
#VPC:B details
variable "vpc_B_details" {
  type = string
  default = "192.168.0.0/16"
}
variable "tag" {
  type = string
  default = "Staging"
}
