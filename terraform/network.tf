# depends on main.tf

variable "network" {
  type = object({
    address_range = string
  })
}

# chunk of cloud to work in
resource "aws_vpc" "main" {
  cidr_block = var.network.address_range
  tags       = local.tags
}

# subnet in our chunk to place the VM in
resource "aws_subnet" "mumble" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.network.address_range, 2, 0)
  tags                    = local.tags
  map_public_ip_on_launch = true
}

# gateway for internet communication
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = local.tags
}

# route adds entry to VPC main routing table linking the internet gateway
resource "aws_route" "default" {
  route_table_id         = aws_vpc.main.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# the main VPC's default security group
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  ingress {
    description = "SSH from the internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Default mumble port TCP in"
    from_port   = 64738
    to_port     = 64738
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Default mumble port TCP out"
    from_port   = 64738
    to_port     = 64738
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Default mumble port UDP in"
    from_port   = 64738
    to_port     = 64738
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Default mumble port UDP out"
    from_port   = 64738
    to_port     = 64738
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTP from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTPS from the internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
