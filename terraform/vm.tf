# depends on main.tf, network.tf

variable "ami" {
  type = object({
    name                = string
    owner               = string
    virtualization_type = string
  })
}

variable "vm_instance" {
  type = object({
    instance_type = string
    public_key    = string
  })
}

module "mumble" {
  source = "./_vm"

  ami               = var.ami
  vm_instance       = var.vm_instance
  subnet_id         = aws_subnet.mumble.id
  security_group_id = aws_default_security_group.default.id
  tags              = local.tags
}
