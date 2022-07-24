resource "aws_vpc" "evans-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "evans-vpc"
    Project = "Evans Terraform"
  }
}