# -*- Mode: HCL; -*-

# https://www.terraform.io/docs/providers/aws/r/network_acl.html
# https://www.terraform.io/docs/providers/aws/r/network_acl_rule.html

# ACL Rules
## local
resource "aws_network_acl_rule" "i_l_all" {
  count = "1"

  # description = "Ingress Localnetwork All"


  # below code does not work
  # count = "${length(${local.acls})}"

  network_acl_id = "${local.acls[count.index]}"
  rule_number    = 100
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "${var.VPC_CIDR_Block}"
  from_port      = 0
  to_port        = 0
}

## global
resource "aws_network_acl_rule" "e_g_all" {
  count = "1"

  # description = "Egress Globalnetwork All"


  # below does not work
  # count = "${length(${local.acls})}"

  network_acl_id = "${local.acls[count.index]}"
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

## ssh
resource "aws_network_acl_rule" "i_a_ssh" {
  count = "${length(var.Allow_Networks)}"

  # description = "Egress Allownetwork SSH"

  network_acl_id = "${aws_network_acl.public.id}"
  rule_number = "${210 + count.index}"
  egress      = false
  protocol    = "tcp"
  rule_action = "allow"
  cidr_block  = "${var.Allow_Networks[count.index]}"
  from_port   = 22
  to_port     = 22
}

## ephemeral
resource "aws_network_acl_rule" "i_g_tcpephemeral" {
  network_acl_id = "${aws_network_acl.public.id}"

  # description = "Ingress Globalnetwork TCPephemeralports"

  rule_number = 910
  egress      = false
  protocol    = "tcp"
  rule_action = "allow"
  cidr_block  = "0.0.0.0/0"
  from_port   = 1024
  # from_port  = 49152
  to_port = 65535
}

resource "aws_network_acl_rule" "i_g_udpephemeral" {
  network_acl_id = "${aws_network_acl.public.id}"

  # description = "Ingress Globalnetwork UDPephemeralports"

  rule_number = 920
  egress      = false
  protocol    = "udp"
  rule_action = "allow"
  cidr_block  = "0.0.0.0/0"
  from_port   = 1024
  # from_port  = 49152
  to_port = 65535
}
