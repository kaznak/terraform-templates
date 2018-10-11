# EIP -*- Mode: HCL -*-

# https://www.terraform.io/docs/providers/aws/r/eip.html

resource "aws_eip" "main" {
  depends_on = ["aws_internet_gateway.main"]
  count      = "${var.num_ec2}"
  vpc        = true
}
