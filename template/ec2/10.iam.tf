# -*- Mode: HCL; -*-

# https://www.terraform.io/docs/providers/aws/d/iam_policy.html
# https://www.terraform.io/docs/providers/aws/d/iam_policy_document.html
# https://www.terraform.io/docs/providers/aws/r/iam_role.html
# https://www.terraform.io/docs/providers/aws/r/iam_role_policy_attachment.html
# https://www.terraform.io/docs/providers/aws/r/iam_instance_profile.html

resource "aws_iam_instance_profile" "CloudWatchAgentServerPolicy" {
  name = "CloudWatchAgentServerPolicy"
  role = "${aws_iam_role.CloudWatchAgentServerPolicy.name}"
}

resource "aws_iam_role" "CloudWatchAgentServerPolicy" {
  name        = "CloudWatchAgentServerPolicy"
  path        = "/"
  description = "CloudWatchAgentServerPolicy"
  assume_role_policy = "${data.aws_iam_policy_document.CloudWatchAgentServerPolicy.json}"
}

data "aws_iam_policy_document" "CloudWatchAgentServerPolicy" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "CloudWatchAgentServerPolicy" {
  role       = "${aws_iam_role.CloudWatchAgentServerPolicy.name}"
  policy_arn = "${data.aws_iam_policy.CloudWatchAgentServerPolicy.arn}"
}

data "aws_iam_policy" "CloudWatchAgentServerPolicy" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
