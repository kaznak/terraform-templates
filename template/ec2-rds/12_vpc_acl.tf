# -*- Mode: HCL; -*-

# https://www.terraform.io/docs/providers/aws/r/network_acl.html
# https://www.terraform.io/docs/providers/aws/r/network_acl_rule.html

locals {
  acls = [
    "${aws_network_acl.public.id}",
    "${aws_network_acl.private.id}",
  ]
}

# ACL
## public
resource "aws_network_acl" "public" {
  vpc_id = "${aws_vpc.main.id}"

  subnet_ids = ["${aws_subnet.public.*.id}"]

  tags = "${merge(map("Name","${var.ProjectName}_public"),"${local.common_tags}")}"
}

## private
resource "aws_network_acl" "private" {
  vpc_id = "${aws_vpc.main.id}"

  subnet_ids = ["${aws_subnet.private.*.id}"]

  tags = "${merge(map("Name","${var.ProjectName}_private"),"${local.common_tags}")}"
}
