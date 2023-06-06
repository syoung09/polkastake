variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "public_ip" {
  type = string
}

variable "key_name" {
  type = string
}

variable "vpc_security_group_ids" {
  type = [string]
}