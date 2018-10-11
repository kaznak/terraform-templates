# -*- Mode: HCL -*-

# https://www.terraform.io/docs/configuration/outputs.html

output "name_servers" {
  value = "${aws_route53_zone.main.name_servers}"
}

output "aws_route53_zone_main_id" {
  value = "${aws_route53_zone.main.id}"
}
