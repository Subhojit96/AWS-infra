resource "aws_security_group" "sg" {
  name = "${var.tag}-sg"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "SSH" {
  security_group_id = aws_security_group.sg.id
  from_port = 0
  to_port = 22
  type = "ingress"
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}
