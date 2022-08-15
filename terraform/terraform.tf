# configures terraform for aws use on specific region with specific profile
terraform {
  required_version = "~> 1.1"
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

provider "aws" {
  profile = "default"
  region  = var.region
}
