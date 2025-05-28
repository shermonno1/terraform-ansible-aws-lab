// outputs.tf - Values displayed after successful Terraform apply

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.project_vpc.id
}

output "subnet_a_id" {
  description = "Public Subnet A ID"
  value       = aws_subnet.public_a.id
}

output "subnet_b_id" {
  description = "Public Subnet B ID"
  value       = aws_subnet.public_b.id
}

output "ec2_instance_a_public_ip" {
  description = "Public IP of EC2 WebServer-A"
  value       = aws_instance.web_a.public_ip
}

output "ec2_instance_b_public_ip" {
  description = "Public IP of EC2 WebServer-B"
  value       = aws_instance.web_b.public_ip
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.web_alb.dns_name
}
