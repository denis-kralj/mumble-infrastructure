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

variable "subnet_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "tags" {
  type = map(string)
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami.name]
  }

  filter {
    name   = "virtualization-type"
    values = [var.ami.virtualization_type]
  }

  owners = [var.ami.owner]
}

resource "aws_key_pair" "admin" {
  key_name   = "admin-key"
  public_key = var.vm_instance.public_key
  tags       = var.tags
}

# associates the security group with the subnet
# is assigned to the VM
resource "aws_network_interface" "main" {
  subnet_id       = var.subnet_id
  security_groups = [var.security_group_id]

  tags = var.tags
}

resource "aws_instance" "ubuntu-server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.vm_instance.instance_type
  key_name      = aws_key_pair.admin.key_name

  network_interface {
    network_interface_id = aws_network_interface.main.id
    device_index         = 0
  }

  tags = var.tags
}

