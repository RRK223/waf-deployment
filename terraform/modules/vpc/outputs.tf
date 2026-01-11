output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

# output "private_subnet_ids" {
#   value = aws_subnet.private[*].id
# }

# output "nat_eip" {
#   description = "The public Elastic IP used by the NAT Gateway"
#   value       = aws_eip.nat.public_ip
# }