# -*- Mode: HCL; -*-

# https://www.terraform.io/docs/configuration/variables.html
# https://www.terraform.io/docs/configuration/locals.html

## Network
variable "AZ" {
  type = "list"

  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
    "us-east-1e",
    "us-east-1f",
  ]
}

variable "VPC_CIDR_Block" {
  type    = "string"
  default = "10.0.0.0/16"
}

variable "public_CIDR_Blocks" {
  type = "list"

  # Subnet for each AZ
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24",
  ]
}

variable "private_CIDR_Blocks" {
  type = "list"

  # Subnet for each AZ
  default = [
    "10.0.9.0/24",
    "10.0.10.0/24",
    "10.0.11.0/24",
    "10.0.12.0/24",
    "10.0.13.0/24",
    "10.0.14.0/24",
  ]
}
