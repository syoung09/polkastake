variable "aws_region_A" {
  type    = string
  default = "us-west-2"
}

variable "aws_region_B" {
  type    = string
  default = "us-west-2"
}

variable "aws_az_A" {
  type    = string
  default = "us-west-2b"
}

variable "aws_az_B" {
  type    = string
  default = "us-west-2c"
}

variable "vpc_cidr_A" {
  type    = string
  default = "10.0.0.0/22"  
}

variable "vpc_cidr_B" {
  type    = string
  default = "10.1.0.0/22"  
}

variable "subnet_pub_A" {
  type    = string
  default = "10.0.0.0/22"  
}

variable "subnet_pub_B" {
  type    = string
  default = "10.1.0.0/22"  
}

variable "fullnode_ip_A" {
  type    = string
  default = "10.0.0.99"
}

variable "fullnode_ip_B" {
  type    = string
  default = "10.1.0.99"
}

variable "instance_type" {
  type    = string
  default = "t3.medium" //c6i.4xlarge
}

variable "instance_ami" {
  type    = string
  default = "ami-09faf71ea24d57248"
}
