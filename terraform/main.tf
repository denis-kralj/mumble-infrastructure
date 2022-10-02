# global variables and locals
variable "application" {
  type    = string
  default = "mumble"
}

variable "mumble_server_password" {
  type = string
}

locals {
  tags = {
    Name = var.application
  }
}
