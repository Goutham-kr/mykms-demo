data "aws_iam_policy_document" "kms" {
  statement {
    sid = "AllowUseOfTheKey"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]

    resources = ["${aws_kms_key.key.arn}"]
  }
}

data "template_file" "kms_policy" {
  template = "${file("${path.module}/kms_policy.json.tpl")}"

  vars = {
    account_id = "${var.account_id}"
  }
}

resource "aws_iam_user" "user1" {
  name = "${var.first}"
  path = "/"
}

resource "aws_iam_user" "user2" {
  name = "${var.second}"
  path = "/"
}

resource "aws_iam_group" "group1" {
  name = "${var.group}"
}

resource "aws_iam_group_membership" "group1_membership" {
  name  = "${var.membership}"
  group = "${aws_iam_group.group1.name}"

  users = [
    "${aws_iam_user.user1.name}",
    "${aws_iam_user.user2.name}",
  ]
}

resource "aws_iam_policy" "kms" {
  name        = "kms-${var.key_name}-policy"
  path        = "/"
  description = "My Ploicy"
  policy      = "${data.aws_iam_policy_document.kms.json}"
}

resource "aws_iam_policy_attachment" "my_kms_policy_attachment" {
  name = "${var.attachment}"

  groups = ["${aws_iam_group.group1.name}"]

  policy_arn = "${aws_iam_policy.kms.arn}"
}

resource "aws_kms_key" "key" {
  description             = "${var.description}"
  deletion_window_in_days = "${var.deletion_window_in_days}"
  is_enabled  = "${var.is_enabled}"
  policy = "${data.template_file.kms_policy.rendered}"
  
  tags {
    Description   = "${var.description}"
    Environment   = "${var.environment}"
    Name          = "${var.alias_name}"
    ProductDomain = "${var.product_domain}"
    ManagedBy     = "Terraform"
  }
}  

resource "aws_kms_alias" "alias" {
  name          = "alias/${var.key_name}"
  target_key_id = "${aws_kms_key.key.key_id}"
}
