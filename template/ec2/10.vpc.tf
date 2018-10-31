# -*- Mode: HCL; -*-

# https://www.terraform.io/docs/providers/aws/r/vpc.html
# https://www.terraform.io/docs/providers/aws/r/internet_gateway.html
# https://www.terraform.io/docs/providers/aws/r/route_table.html
# https://www.terraform.io/docs/providers/aws/r/main_route_table_assoc.html

resource "aws_vpc" "main" {
  cidr_block = "${var.VPC_CIDR_Block}"

  tags = "${merge(map("Name","${var.ProjectName}"),"${local.common_tags}")}"
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags = "${merge(map("Name","${var.ProjectName}"),"${local.common_tags}")}"
}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags = "${merge(map("Name","${var.ProjectName}"),"${local.common_tags}")}"
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = "${aws_vpc.main.id}"
  route_table_id = "${aws_route_table.main.id}"
}
