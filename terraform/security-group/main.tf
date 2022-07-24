data "aws_vpc" "vpcl" {
  id = var.vpc_id
}

resource "aws_security_group" "evans_sg" {
    name = "evans-security"
    description = "Private access"
    vpc_id = data.aws_vpc.vpcl.id
}