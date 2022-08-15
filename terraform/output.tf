# outputs that terraform spits out after completion
output "instance_ip" {
  description = "public IP assigned"
  value       = module.mumble.instance_ip
}
