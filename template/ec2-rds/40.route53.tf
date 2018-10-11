# # Web -*- Mode: HCL; -*-

# # https://www.terraform.io/docs/providers/aws/r/route53_record.html

data "aws_route53_zone" "main" {
  name = "${var.domain}."
}

resource "aws_route53_record" "main" {
  count   = "${length(local.ec2_fqdn)}"
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  name    = "${local.ec2_fqdn[count.index]}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip_association.eip_assoc.*.public_ip}"]
}
