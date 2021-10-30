resource "aws_security_group" "sg" {
  name = "${var.tag}-sg"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "SSH" {
  security_group_id = aws_security_group.sg.id
  from_port =22
  to_port = 22
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = [ "103.217.0.0/16" ]
}
resource "aws_security_group_rule" "HTTP" {
  security_group_id = aws_security_group.sg.id
  from_port =80
  to_port = 80
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = [ "103.217.0.0/16" ]
}
resource "aws_security_group_rule" "HTTPS" {
  security_group_id = aws_security_group.sg.id
  from_port =443
  to_port = 443
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = [ "103.217.0.0/16" ]
}
resource "aws_security_group_rule" "RDP" {
  security_group_id = aws_security_group.sg.id
  from_port =3389
  to_port = 3389
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = [ "103.217.0.0/16" ]
}

