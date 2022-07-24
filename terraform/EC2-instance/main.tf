provider "aws" {
  region = "us-east-1"
}

data "aws_security_group" "sglookup" {
  id = var.security_group_id
  
  filter {
    name = ""
    vpc_id = ""   
  }
}

data "aws_eip" "by_tags" {
  tags = {
    Name = "exampleNameTagValue"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ec2_in.id
  allocation_id = aws_eip.evans_eip.id
}

resource "aws_instance" "ec2_in" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = ["${aws_security_group.evans_sg.id}"]
  availability_zone = var.availability_zone

  user_data = "${file("install_docker.sh")}"


  tags = {
    Name = var.instance_name
  }
}

resource "aws_eip" "evans_eip" {
  vpc      = true
}


resource "aws_security_group" "evans_sg" {

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_ebs_volume" "evans_volume" {
  availability_zone = var.availability_zone
  size              = var.size

  tags = {
    Name = var.name
  }
}

resource "aws_volume_attachment" "volume_attach" {
  device_name = var.device_name
  volume_id   = aws_ebs_volume.evans_volume.id
  instance_id = aws_instance.ec2_in.id
}
