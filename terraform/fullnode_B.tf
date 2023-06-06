provider "aws" {
  profile = "default"
  region  = var.aws_region_B
}

resource "aws_vpc" "polkastake_B" {
  cidr_block           = var.vpc_cidr_B
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "polkastake_B" {
  vpc_id = aws_vpc.polkastake_B.id

  depends_on = [aws_vpc.polkastake_B]
}

resource "aws_subnet" "polkastake_B" {
  vpc_id                  = aws_vpc.polkastake_B.id
  cidr_block              = var.subnet_pub_B
  map_public_ip_on_launch = true
  availability_zone       = var.aws_az_B

  depends_on = [aws_internet_gateway.polkastake_B]
}

resource "aws_security_group" "polkastake_fullnode_B" {
  name        = "polkastake_sg_B"
  description = "polkadot fullnode_B traffic"
  vpc_id      = aws_vpc.polkastake_B.id

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
    Name = "polkastake_sg_B"
  }

  depends_on = [aws_vpc.polkastake_B]
}

resource "aws_route_table" "polkastake_B" {
  vpc_id = aws_vpc.polkastake_B.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.polkastake_B.id
  }
  depends_on = [aws_internet_gateway.polkastake_B]
}

resource "aws_main_route_table_association" "polkastake_B" {
  vpc_id         = aws_vpc.polkastake_B.id
  route_table_id = aws_route_table.polkastake_B.id
}

resource "aws_instance" "polkastake_fullnode_B" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  private_ip             = var.fullnode_ip_B
  subnet_id              = aws_subnet.polkastake_B.id
  vpc_security_group_ids = [aws_security_group.polkastake_fullnode_B.id]
  availability_zone      = var.aws_az_B
  key_name               = aws_key_pair.ansible.key_name
}

resource "aws_eip" "polkastake_fullnode_B" {
  instance                  = aws_instance.polkastake_fullnode_B.id
  associate_with_private_ip = var.fullnode_ip_B
  depends_on                = [aws_internet_gateway.polkastake_B]
  vpc                       = true
}

resource "aws_route53_record" "fullnode_B" {
  zone_id = aws_route53_zone.roflol.id
  name    = var.fullnode_name_B
  type    = "A"
  ttl     = "60"
  records = [aws_eip.polkastake_fullnode_B.public_ip]
}