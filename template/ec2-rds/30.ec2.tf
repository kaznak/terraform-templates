# # Web -*- Mode: HCL; -*-

# https://www.terraform.io/docs/configuration/variables.html
# https://www.terraform.io/docs/providers/aws/r/instance.html

variable "ami_info" {
  type = "map"

  default = {
    id           = "ami-0b425589c7bb7663d"
    region       = "us-east-1"
    description  = "bionic 18.04-LTS amd64 hvm:ebs-ssd 20180814 hvm"
    os           = "ubuntu"
    default_user = "ubuntu"
    url          = "https://cloud-images.ubuntu.com/locator/ec2/"
  }
}

# Instance
resource "aws_instance" "main" {
  count = "${var.num_ec2}"

  instance_type = "t2.micro"
  ami           = "${var.ami_info["id"]}"

  vpc_security_group_ids = [
    "${aws_security_group.i_l_all.id}",
    "${aws_security_group.i_a_ssh.id}",
    "${aws_security_group.i_g_www.id}",
    "${aws_security_group.e_g_all.id}",
  ]

  subnet_id = "${aws_subnet.public.*.id[count.index % 3]}"

  # To remote-exec provisioner work, "associate_public_ip_address" is required.
  associate_public_ip_address = true

  key_name = "${aws_key_pair.main.key_name}"

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("${local.ssh_dir}/id_rsa")}"
    }

    inline = [
      "sudo hostnamectl set-hostname ${var.ProjectName}-${count.index}-$(date +%Y%m%d%H%M%S%Z)",
    ]
  }

  provisioner "local-exec" {
    when = "destroy"

    command = <<COMMAND
if [ -s ${local.ssh_dir}/known_hosts ] ; then
	terraform output ec2-addrs	|
	sed -e 's/,//'	|
	while read addr ; do
		ssh-keygen -R $addr
	done
	terraform output ec2-hostnames	|
	sed -e 's/,//'	|
	while read name ; do
		ssh-keygen -R $name
	done
fi
COMMAND
  }

  tags = "${merge(map("Name","${var.ProjectName}"),"${local.common_tags}")}"
}

# # https://www.terraform.io/docs/providers/aws/r/key_pair.html
resource "aws_key_pair" "main" {
  key_name   = "${var.ProjectName}"
  public_key = "${file("${local.ssh_dir}/id_rsa.pub")}"
}

# EIP
# # https://www.terraform.io/docs/providers/aws/r/eip_association.html
resource "aws_eip_association" "eip_assoc" {
  count         = "${var.num_ec2}"
  instance_id   = "${aws_instance.main.*.id[count.index]}"
  allocation_id = "${aws_eip.main.*.id[count.index]}"
}
