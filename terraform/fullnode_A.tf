provider "aws" {
  profile = "default"
  region  = var.aws_region_A
}

resource "aws_vpc" "polkastake_A" {
  cidr_block           = var.vpc_cidr_A
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "polkastake_A" {
  vpc_id = aws_vpc.polkastake_A.id

  depends_on = [aws_vpc.polkastake_A]
}

resource "aws_subnet" "polkastake_A" {
  vpc_id                  = aws_vpc.polkastake_A.id
  cidr_block              = var.subnet_pub_A
  map_public_ip_on_launch = true
  availability_zone       = var.aws_az_A

  depends_on = [aws_internet_gateway.polkastake_A]
}

resource "aws_security_group" "polkastake_fullnode_A" {
  name        = "polkastake_sg_A"
  description = "polkadot fullnode_A traffic"
  vpc_id      = aws_vpc.polkastake_A.id

  ingress {
    description = "ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "fullnode_libp2p"
    from_port   = 30333
    to_port     = 30333
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "polkastake_sg_A"
  }

  depends_on = [aws_vpc.polkastake_A]
}

resource "aws_route_table" "polkastake_A" {
  vpc_id = aws_vpc.polkastake_A.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.polkastake_A.id
  }
  depends_on = [aws_internet_gateway.polkastake_A]
}

resource "aws_main_route_table_association" "polkastake_A" {
  vpc_id         = aws_vpc.polkastake_A.id
  route_table_id = aws_route_table.polkastake_A.id
}

resource "aws_instance" "polkastake_fullnode_A" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  private_ip             = var.fullnode_ip_A
  subnet_id              = aws_subnet.polkastake_A.id
  vpc_security_group_ids = [aws_security_group.polkastake_fullnode_A.id]
  availability_zone      = var.aws_az_A
  key_name               = aws_key_pair.ansible.key_name
}

resource "aws_eip" "polkastake_fullnode_A" {
  instance                  = aws_instance.polkastake_fullnode_A.id
  associate_with_private_ip = var.fullnode_ip_A
  depends_on                = [aws_internet_gateway.polkastake_A]
  vpc                       = true
}

resource "aws_route53_record" "fullnode_a" {
  zone_id = aws_route53_zone.roflol.id
  name    = "fullnode-a.roflol.net"
  type    = "A"
  ttl     = "60"
  records = [aws_eip.polkastake_fullnode_A.public_ip]
}