# TODO: feels like terraform.tf and output.tf can be part of this file

# global variables and locals
variable "application" {
  type    = string
  default = "mumble"
}

locals {
  tags = {
    Name = var.application
  }
}
