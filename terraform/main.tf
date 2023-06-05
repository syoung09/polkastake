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
  region  = var.aws_region
}

resource "aws_key_pair" "ansible" {
  key_name   = "ansible"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDESakRPgjmOS3y8CBYx/57NK7GndM/Zz4scDfcgJ7rOL01+u7XnhOuW7MvoUoEbUpH6CimAESf4HObXEx0jiebG5NSV355tUzoSelGz1x+NiIPSUqNNOUCTBv+5osRWklEyH6ucgvov59eJVIrXesDFrKpzAIWKfz7jFIYKNEMrdGFzNAK7aiU1xCz2hAtRFk0+jJ4XamrSbOX0lBOAPzBQg2O9hCia7l6kbFgcw5gIIrP231sevxlCutUJFNFj9eZpO/8c4HyTAsXP4XiS5CdsDCwp/7yzGgWTFg39jVo2rWc2QywhOcufffH3xbVqHiW0MYPPQMQoTjRK3Gdvhed"
}

resource "aws_route53_zone" "roflol" {
  name = "roflol.net"
}
