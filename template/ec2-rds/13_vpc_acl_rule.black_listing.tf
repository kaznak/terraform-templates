# -*- Mode: HCL; -*-

# https://www.terraform.io/docs/providers/aws/r/network_acl.html
# https://www.terraform.io/docs/providers/aws/r/network_acl_rule.html

# ACL Rules
## www
resource "aws_network_acl_rule" "i_d_http" {
  count = "${length(var.Deny_Networks)}"

  network_acl_id = "${aws_network_acl.public.id}"

  rule_number = "${310 + count.index}"
  egress      = false
  protocol    = "tcp"
  rule_action = "deny"
  cidr_block  = "${var.Deny_Networks[count.index]}"
  from_port   = 80
  to_port     = 80
}

resource "aws_network_acl_rule" "i_g_http" {
  network_acl_id = "${aws_network_acl.public.id}"

  rule_number = "399"
  egress      = false
  protocol    = "tcp"
  rule_action = "allow"
  cidr_block  = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
}

resource "aws_network_acl_rule" "i_d_https" {
  count = "${length(var.Deny_Networks)}"

  network_acl_id = "${aws_network_acl.public.id}"

  rule_number = "${410 + count.index}"
  egress      = false
  protocol    = "tcp"
  rule_action = "deny"
  cidr_block  = "${var.Deny_Networks[count.index]}"
  from_port   = 443
  to_port     = 443
}

resource "aws_network_acl_rule" "i_g_https" {
  network_acl_id = "${aws_network_acl.public.id}"

  rule_number = "499"
  egress      = false
  protocol    = "tcp"
  rule_action = "allow"
  cidr_block  = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
}
