# -*- Mode: HCL; -*-

# https://www.terraform.io/docs/configuration/variables.html
# https://www.terraform.io/docs/configuration/locals.html

locals {
  common_tags = {
    Project   = "${var.ProjectName}"
    Env       = "${var.Env}"
    Terraform = "true"
  }

  # set project directory if you share keys.
  ssh_dir = "~/.ssh"
}
