# -*- Mode: HCL; -*-

# https://www.terraform.io/docs/configuration/terraform.html
# https://www.terraform.io/docs/providers/aws/index.html
# https://www.terraform.io/docs/configuration/variables.html

terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
    bucket = "my-tfstate-bucket"

    # Directory shoud be var.ProjectName
    key = "template/ec2-rds.tfstate"

    region  = "us-east-1"
    profile = "sample-root-profile"
  }
}

provider "aws" {
  version = "~> 1.32.0"
  profile = "sample-profile"

  region = "us-east-1"
}

variable "ProjectName" {
  type    = "string"
  default = "template"

  # only lowercase alphanumeric characters and hyphens allowed
}

variable "Env" {
  type    = "string"
  default = "devel"
}
