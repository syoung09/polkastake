variable "region" {
  type = string
  default = "us-west-2"
}

variable "availability_zone" {
  type = string
  default = "us-west-2b"
}

variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "fullnode_name" {
  type = string
  default = "roflol-a.roflol.net"
}

variable "fullnode_private_ip" {
  type = string
  default = "10.0.0.99"
}
