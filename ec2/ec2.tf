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
resource "aws_ebs_volume" "ebs" {
  size = "8"
 // count = "${length(var.availability_zone) }"
  availability_zone = var.availability_zone.0
}