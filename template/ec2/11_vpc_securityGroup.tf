# -*- Mode: HCL; -*-

# # https://www.terraform.io/docs/providers/aws/r/security_group.html

resource "aws_security_group" "i_l_all" {
  name        = "${var.ProjectName}_i_l_all"
  vpc_id      = "${aws_vpc.main.id}"
  description = "Ingress Localnetwork All"

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["${var.VPC_CIDR_Block}"]
  }

  tags = "${merge(map("Name","${var.ProjectName}_i_l_all"),"${local.common_tags}")}"
}

resource "aws_security_group" "e_g_all" {
  name        = "${var.ProjectName}_e_g_all"
  vpc_id      = "${aws_vpc.main.id}"
  description = "Egress Globalnetwork All"

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(map("Name","${var.ProjectName}_e_g_all"),"${local.common_tags}")}"
}

resource "aws_security_group" "i_a_www" {
  name        = "${var.ProjectName}_i_a_www"
  vpc_id      = "${aws_vpc.main.id}"
  description = "Ingress Allownetwork WWW"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = "${var.Allow_Networks}"
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = "${var.Allow_Networks}"
  }

  tags = "${merge(map("Name","${var.ProjectName}_i_a_www"),"${local.common_tags}")}"
}

resource "aws_security_group" "i_g_www" {
  name        = "${var.ProjectName}_i_g_www"
  vpc_id      = "${aws_vpc.main.id}"
  description = "Ingress Globalnetwork WWW"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(map("Name","${var.ProjectName}_i_g_www"),"${local.common_tags}")}"
}

resource "aws_security_group" "i_a_ssh" {
  name        = "${var.ProjectName}_i_a_ssh"
  vpc_id      = "${aws_vpc.main.id}"
  description = "Ingress Allownetwork ssh"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = "${var.Allow_Networks}"
  }

  tags = "${merge(map("Name","${var.ProjectName}_i_a_ssh"),"${local.common_tags}")}"
}
