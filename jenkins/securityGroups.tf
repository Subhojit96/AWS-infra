resource "aws_security_group" "sg-vpcA" {
  vpc_id = aws_vpc.vpcA.id
  tags = {
    "Name" = "${var.tag}-sg-VPC_A"
  }
}

resource "aws_security_group_rule" "SSH-A" {
  security_group_id = aws_security_group.sg-vpcA.id
  from_port =22
  to_port = 22
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = [ "103.217.0.0/16" ]
}
resource "aws_security_group_rule" "HTTP-A" {
  security_group_id = aws_security_group.sg-vpcA.id
  from_port =80
  to_port = 80
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = [ "103.217.0.0/16" ]
}
resource "aws_security_group_rule" "HTTPS-A" {
  security_group_id = aws_security_group.sg-vpcA.id
  from_port =443
  to_port = 443
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = [ "103.217.0.0/16" ]
}
resource "aws_security_group_rule" "RDP-A" {
  security_group_id = aws_security_group.sg-vpcA.id
  from_port =3389
  to_port = 3389
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = [ "103.217.0.0/16" ]
}
resource "aws_security_group_rule" "localHost-A" {
  security_group_id = aws_security_group.sg-vpcA.id
  from_port =8080
  to_port = 8080
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = [ "103.217.0.0/16" ]
}

resource "aws_security_group" "sg-vpcB" {
  tags = {
    "Name" = "${var.tag}-sg-VPC_B"
  }
  vpc_id = aws_vpc.vpcB.id
}

resource "aws_security_group_rule" "SSH-B" {
  security_group_id = aws_security_group.sg-vpcB.id
  from_port =22
  to_port = 22
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = [ "103.217.0.0/16" ]
}
resource "aws_security_group_rule" "HTTP-B" {
  security_group_id = aws_security_group.sg-vpcB.id
  from_port =80
  to_port = 80
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = [ "103.217.0.0/16" ]
}
resource "aws_security_group_rule" "HTTPS-B" {
  security_group_id = aws_security_group.sg-vpcB.id
  from_port =443
  to_port = 443
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = [ "103.217.0.0/16" ]
}
resource "aws_security_group_rule" "RDP-B" {
  security_group_id = aws_security_group.sg-vpcB.id
  from_port =3389
  to_port = 3389
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = [ "103.217.0.0/16" ]
}
resource "aws_security_group_rule" "localHost-B" {
  security_group_id = aws_security_group.sg-vpcB.id
  from_port =8080
  to_port = 8080
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = [ "103.217.0.0/16" ]
}
