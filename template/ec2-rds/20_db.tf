# -*- Mode: HCL; -*-

# https://www.terraform.io/docs/providers/aws/r/db_subnet_group.html
# https://www.terraform.io/docs/providers/aws/r/db_instance.html

resource "aws_db_subnet_group" "main" {
  name       = "${var.ProjectName}"
  subnet_ids = ["${aws_subnet.private.*.id}"]
  tags       = "${merge(map("Name","${var.ProjectName}"),"${local.common_tags}")}"
}

resource "aws_db_instance" "main" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "${var.db_name}"
  username             = "${var.db_master_username}"
  password             = "${var.db_master_passwd}"
  db_subnet_group_name = "${aws_db_subnet_group.main.name}"

  # parameter_group_name = "default.mysql5.7"

  skip_final_snapshot = true
  tags                = "${merge(map("Name","${var.ProjectName}"),"${local.common_tags}")}"
}
