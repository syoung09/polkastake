terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"

    }
  }

  required_version = ">= 1.4.5"
}

provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_instance" "ec2" {
  ami                    = "ami-09faf71ea24d57248"
  instance_type          = "t3.medium" //c6i.4xlarge
  key_name               = "ansible"
  subnet_id              = var.subnet_id
  private_ip             = var.private_ip
  vpc_security_group_ids = var.security_group_ids
}

resource "aws_eip" "eip" {
  instance                  = aws_instance.ec2.id
  associate_with_private_ip = var.private_ip
  vpc                       = true
}

resource "aws_route53_record" "record" {
  zone_id = "Z081198922FL51CN10THU"
  name    = var.name
  type    = "A"
  ttl     = 60
  records = [aws_eip.eip.public_ip]
}