module "network" {
  source = "../../../modules/aws/fullnode_network"
  cidr_block = var.cidr_block
  region = var.region
  availability_zone = var.availability_zone
}

module "fullnode_instance" {
  source = "../../../modules/aws/fullnode_instance"
  region = var.region
  subnet_id = module.network.subnet_id
  private_ip = var.fullnode_private_ip
  security_group_ids = module.network.security_group_ids
  name    = var.fullnode_name
}
