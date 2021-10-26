
/*variable "access_key" {
  description = "Enter access key"
  type = string
}

variable "secret_key" {
  type= string
  description = "Enter secret_key"
}
*/
variable "region" {
  type = string
  description = "Enter aws region"
}

variable "cidr_vpc" {
  description = "Enter CIDR range"
  default = "192.168.0.0/16"
  type = string
}

variable "public_subnet_cidr" {
  type = list
  default = ["192.168.4.0/24","192.168.3.0/24"]
}

variable "private_subnet_cidr" {
  type = list
  default = ["192.168.5.0/24", "192.168.6.0/24"]
}
variable "availability_zone" {
  type = list
  default = ["us-east-1a", "us-east-1b"]
}

variable "tag" {
  type = string
  default = "Dev-cvayutopia"
}
