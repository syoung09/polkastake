output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_id" {
  value = aws_subnet.subnet.id
}

output "security_group_ids" {
  value = [aws_security_group.polkastake_fullnode.id]
}