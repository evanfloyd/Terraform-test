resource "aws_ebs_volume" "evans_volume" {
  availability_zone = var.availability_zone
  size              = var.size

  tags = {
    Name = var.name
  }
}
