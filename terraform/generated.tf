resource "local_file" "ansible_inventory" {
    content  = <<EOT
all:
  hosts:
    mumble-server:
      ansible_host: ${module.mumble.instance_ip}
      ansible_connection: ssh
      ansible_user: ubuntu
      ansible_host_key_checking: False
      ansible_ssh_retries: 10
      mumble_server_password: ${var.mumble_server_password}
EOT
    filename = "../ansible/inventory.yaml"
}