# -*- Mode: HCL; -*-

# https://www.terraform.io/docs/configuration/variables.html
# https://www.terraform.io/docs/configuration/locals.html

variable "domain" {
  type    = "string"
  default = "example.com"
}
