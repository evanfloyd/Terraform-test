data "aws_instance" "ec2lookup" {
    instance_tags = "name:${var.instance_name}"
}

resource "aws_eip" "evans_eip" {
  instance = data.aws_instance.ec2lookup.id
  vpc      = true
}
