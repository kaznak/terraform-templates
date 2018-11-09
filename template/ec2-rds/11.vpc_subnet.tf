# -*- Mode: HCL; -*-

# https://www.terraform.io/docs/providers/aws/r/subnet.html

resource "aws_subnet" "public" {
  count = "${(var.num_ec2 < length(var.AZ)) ? var.num_ec2 : length(var.AZ) }"

  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.public_CIDR_Blocks[count.index]}"
  availability_zone = "${var.AZ[count.index]}"

  tags = "${merge(map("Name","${var.ProjectName}_public_${count.index}"),"${local.common_tags}")}"
}

resource "aws_subnet" "private" {
  count             = "${length(var.AZ)}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.private_CIDR_Blocks[count.index]}"
  availability_zone = "${var.AZ[count.index]}"

  tags = "${merge(map("Name","${var.ProjectName}_private_${count.index}"),"${local.common_tags}")}"
}
