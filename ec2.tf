resource "aws_instance" "ec2-1" {
  ami = "ami-02e136e904f3da870"
  tenancy = "default"
  instance_type = "t2.micro"
  instance_initiated_shutdown_behavior = "stop"
  key_name = "${aws_key_pair.key.key_name}"
  monitoring = false
  //count = "${length(var.public_subnet_cidr)}"
  subnet_id = aws_subnet.public.0.id
  tags = {
    "Name" = "${var.tag}-ec2instance"
  }
}

#LoginKey Details
resource "aws_key_pair" "key" {
  key_name = "Jenkins-pem"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCz3kMIVzeyksIQ/7ZYk6rKdmXmdbl33af+i4F5XuFpzdfhUe2/npzeiv5TDGp0tutty3KhoIUKekj5ZZRxauIoohFRHLKj6D97eRtncWVl6qpHUSIhz8L8Yo9z/z4xxNBi9WYR7J/a7s+egnGCa14TvUr4ZqdkhOw2uT13qR+QpfSCM/JKwXO+3NaPvRQ201GPv44qqeSBhl/ixGSisTui0CBwHChk5w/9mz+W9p8G0B2FltnvFx0cpKDGtKSNOpImTOq9Fg8pmE1hTqgyHb9DQOkaoinVUMgdGmqWTSQeP2lTMmMM4acedqwAiv9JjvOYizd6imWPiFxolRvPcg5FEnSz7kMEup2scSUJ5YsYwtFLO3ViKnFhUHldSb+IqtwAqrHlY6bLAE08qOqfvKXwzAERly9Nic/cAIe/Krdmre1l7KT0cZD48o2/XhqRh4mNDZxfJTTh5Nds1Yji0Zt3k1bySt09YJk//2GjplvOQmw/NkbKza4tMM7PzgGZ8wU= ec2-user"
}
resource "aws_ebs_volume" "ebs" {
  size = "8"
 // count = "${length(var.availability_zone) }"
  availability_zone = var.availability_zone.0
}