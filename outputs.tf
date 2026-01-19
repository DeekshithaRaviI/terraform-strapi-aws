# ========================================
# Outputs
# ========================================

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_1_id" {
  description = "Public Subnet 1 ID"
  value       = aws_subnet.public_1.id
}

output "public_subnet_2_id" {
  description = "Public Subnet 2 ID"
  value       = aws_subnet.public_2.id
}

output "private_subnet_id" {
  description = "Private Subnet ID"
  value       = aws_subnet.private.id
}

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.strapi.id
}

output "ec2_private_ip" {
  description = "EC2 Private IP Address"
  value       = aws_instance.strapi.private_ip
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS Name"
  value       = aws_lb.main.dns_name
}

output "alb_url" {
  description = "Application URL"
  value       = "http://${aws_lb.main.dns_name}"
}

output "strapi_admin_url" {
  description = "Strapi Admin Panel URL"
  value       = "http://${aws_lb.main.dns_name}/admin"
}

output "nat_gateway_ip" {
  description = "NAT Gateway Public IP"
  value       = aws_eip.nat.public_ip
}