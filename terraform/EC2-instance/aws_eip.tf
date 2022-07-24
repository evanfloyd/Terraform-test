resource "aws_eip" "evans_eip" {
  instance = aws_instance.ec2_in.id
  vpc      = true
}
