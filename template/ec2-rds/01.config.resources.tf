# -*- Mode: HCL; -*-

# https://www.terraform.io/docs/configuration/variables.html
# https://www.terraform.io/docs/configuration/locals.html

## Network
variable "domain" {
  type    = "string"
  default = "example.com"
}

locals {
  ec2_fqdn = [
    "www.${var.domain}",
    "${var.domain}",
  ]
}

variable "Allow_Networks" {
  type = "list"

  default = [
    "192.168.0.1/32", # Example Address
  ]
}

variable "Deny_Networks" {
  type = "list"

  default = [
    "192.168.0.2/32", # Example Address
  ]
}

## Web Servers
variable "num_ec2" {
  description = "number of web servers"
  type        = "string"
  default     = "1"
}

## Database
variable "num_main_db" {
  description = "number of db instances"
  type        = "string"
  default     = "1"
}

variable "db_name" {
  description = "DB name"
  type        = "string"
  default     = "template"
}

variable "db_master_username" {
  description = "DB master_username"
  type        = "string"
  default     = "dsmOMKNzWtlXMa20uvhVqLGop24MYfX6"
}

variable "db_master_passwd" {
  description = "DB master_passowrd"
  type        = "string"
  default     = "0Ib4zpEr5Q0FF5a8hMLdOBjkqYqyCe1s"
}
