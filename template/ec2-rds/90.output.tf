# -*- Mode: HCL -*-

output "ec2-user" {
  value = "${var.ami_info["default_user"]}"
}

output "ec2-addrs" {
  value = ["${aws_eip.main.*.public_ip}"]
}

output "ec2-hostnames" {
  value = ["${local.ec2_fqdn}"]
}

output "ec2-access" {
  # human readable information
  value = {
    username = "${var.ami_info["default_user"]}"
    address  = "${aws_eip_association.eip_assoc.*.public_ip}"
  }
}

output "db-access" {
  value = {
    endpoint = "${aws_db_instance.main.endpoint}"
    db_name  = "${aws_db_instance.main.name}"
    username = "${aws_db_instance.main.username}"
    password = "${aws_db_instance.main.password}"
  }
}
