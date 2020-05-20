output "TF_BUILD_UID" {
    description = "The Unique ID for this Terraform deployment"
    value       = var.uid
}

output "AWS_PUBLIC_SUBNET_ID" {
    description = "The AWS public subnet ID"
    value       = aws_subnet.public-subnet.id
}

output "AWS_PRIVATE_SUBNET_ID" {
    description = "The AWS private subnet ID"
    value       = aws_subnet.private-subnet.id
}

output "AWS_PUBLIC_SG_ID" {
    description = "The AWS public security group ID"
    value       = aws_security_group.public-sg.id
}

output "AWS_PRIVATE_SG_ID" {
    description = "The AWS private security group ID"
    value       = aws_security_group.private-sg.id
}
