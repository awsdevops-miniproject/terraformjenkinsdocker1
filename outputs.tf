output "public_ip" {
  value = aws_eip.devops_eip.public_ip
}

output "public_dns" {
  value = aws_eip.devops_eip.public_dns
}
