provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.27"
    }
  }

  required_version = ">=0.14.9"

  backend "s3" {
    bucket = "evans-terraform-bucket"
    key    = "evan/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ec2_in.id
  allocation_id = aws_eip.evans_eip.id
}

resource "aws_instance" "ec2_in" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = ["${aws_security_group.evans_sg.id}"]
  availability_zone      = var.availability_zone

  user_data = file("install_docker.sh")


  tags = {
    Name = var.instance_name
  }
}

resource "aws_volume_attachment" "volume_attach" {
  device_name = var.device_name
  volume_id   = aws_ebs_volume.evans_volume.id
  instance_id = aws_instance.ec2_in.id
}
