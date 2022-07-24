resource "aws_security_group" "evans_sg" {
  name        = "evans-security"
  description = "Private access"
}

resource "aws_security_group_rule" "sg_rule_in" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["var.my_ip/32"]
  security_group_id = aws_security_group.evans_sg.id
}

resource "aws_security_group_rule" "sg_rule_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.evans_sg.id
}