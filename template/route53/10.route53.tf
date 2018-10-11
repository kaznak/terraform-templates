# resources -*- Mode: HCL; -*-

# https://www.terraform.io/docs/providers/aws/r/route53_zone.html
# https://www.terraform.io/docs/providers/aws/r/route53_record.html

resource "aws_route53_zone" "main" {
  name = "${var.domain}."

  lifecycle {
    prevent_destroy = true
  }

  tags = "${merge(map("Name","${var.ProjectName}"),"${local.common_tags}")}"
}

resource "aws_route53_record" "txt_record" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.domain}."
  type    = "TXT"
  ttl     = "3600"
  records = ["SetSomeText"]
}
