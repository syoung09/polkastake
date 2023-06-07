variable "region" {
  type    = string
  default = "us-west-2"
}

variable "availability_zone" {
  type    = string
  default = "us-west-2c"
}

variable "cidr_block" {
  type    = string
  default = "10.1.0.0/16"
}

variable "fullnode_name" {
  type    = string
  default = "lol.roflol.net"
}

variable "fullnode_private_ip" {
  type    = string
  default = "10.1.0.99"
}
