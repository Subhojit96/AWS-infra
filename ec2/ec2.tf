resource "aws_instance" "ec2" {
  ami = "ami-02e136e904f3da870"
  tenancy = "default"
  instance_type = "t2.micro"
  instance_initiated_shutdown_behavior = "stop"
  //key_name = "${aws_key_pair.key.key_name}"
  monitoring = false
  //count = "${length(var.public_subnet_cidr)}"
  subnet_id = aws_subnet.public.0.id
  vpc_security_group_ids = [ "${aws_security_group.sg.id}" ]
  tags = {
    "Name" = "${var.tag}-ec2instance"
  }
}

#LoginKey Details
/*resource "aws_key_pair" "key" {
  key_name = "Jenkins-pem"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDjWUdEzt8z9wyO4lpBZrdPwEEvRuBqh0Lo1+SAI1obdojIXj27y0ZAAuOmIpJzUONnP/xcTUKWbRwT0RGbz/QGwaxX/Zfj21XH0M6NWEOhu7TIgzFNApSZKbY8vEcA4gcQXSCMjbEmjrFthDDiK9CAUqp/uV95H9sJdi2FZ1WCuISvtIrPeJ7RT5JmFLPIltuSATwV9Xu29xtWEeXfnLqip9qj7snB5eWaNkuqGLjAfdXHaaInG8Q/J7vyrhD2RG44mPz8absVMOt2xNBSkiDmN9bawaShzEU7GjAyWgLGJ2SMRsma0X7M0429ADQ3THiEIL7r8C6ENV6QpCE1mgWn Jenkins"
}*/
resource "aws_key_pair" "keypair" {
  key_name = "id_rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7WLl6KHoHDueWWx2PF4xahIlEWH61NedWyxJYD7NTJacsJI/AczOyiWx3JIf90Wstnlx2rnXNhin+eIOkxsWmK8dbNzrAiPi7PjcTBRtXsJnl8/aMcEv4Fv4xuembRUeU+VAoQJZXhI+sFGP/UO5adQGJ1Zuj7WF7roFF6HHaMPMil+gHsWnY10dv7GvPhyqwf4Y0LjSukyXGeNOqXF0jNHGma/nXO/TE9QTCOMgztZkLw0BfiA9WQdzL88/B0wunnoy4r+hlgydLYd8lriJWYmMcqK1d2TJ4MU6q9WnIgMswXoaYVKxywVvRPSBfWEMlLmzBlfzvGieyMBxFgAuG+fHGkwnInnsbrEQJ3IzDuqjhVq1TMS6mGg+F5yDytoxDgwkg2M/MTOBnOCv6nDgO7XWUBiiJPHnWJzUbxy0StzkPFdkbNOHpz3U5ylYBbM2SlnlwCRb5Xwj3wN6Vu1wWsNiGwtaJ6RfVD6CIcrBdDFkPkZRY10uatk/xytLrDwE="
}
resource "aws_ebs_volume" "ebs" {
  size = "8"
 // count = "${length(var.availability_zone) }"
  availability_zone = var.availability_zone.0
}