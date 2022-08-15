# outputs that terraform spits out after completion
output "instance_ip" {
  description = "public IP assigned"
  value       = aws_instance.ubuntu-server.public_ip
}
