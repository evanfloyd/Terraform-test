variable "ami_id" {
  default = "ami-052efd3df9dad4825"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_name" {
  default = "evans-terraform"
}

variable "security_groups" {
  default = "evans_sg"
}

variable "availability_zone" {
  default = "us-east-1c"
}

variable "size" {
  default = "8"
}

variable "name" {
  default = "evans_volume"
}

variable "device_name" {
  default = "/dev/sdh"
}

variable "key_name" {
  default = "evans-key"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_id" {
  default = "subnet-0e2d31589f895206b"
}
