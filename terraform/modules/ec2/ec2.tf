resource "aws_instance" "ec2-instance" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    private_ip = var.private_ip
    vpc_security_group_ids = var.vpc_security_group_ids
    key_name = var.key_name
}