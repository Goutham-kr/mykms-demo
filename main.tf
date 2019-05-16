provider "aws" {
   access_key = "${var.aws_access_key}"
   secret_key = "${var.aws_secret_key}"
   region = "${var.region}"
}

terraform {
 backend "s3" {
 encrypt = true
 bucket = "goumaster"
 region = "us-east-1"
 key = "terraform.tfstate"
 profile = "nonprod"
  }
}

module "mykms" {
  source     = "modules/kms"
  first = "${var.first}"
  second = "${var.second}"
  group = "${var.group}"
  attachment = "${var.attachment}"
  membership = "${var.membership}"
  key_name   = "${var.key_name}"
  account_id = "${var.account_id}"
  description             = "${var.description}"
  deletion_window_in_days = "${var.deletion_window_in_days}"
  is_enabled  = "${var.is_enabled}"
  enable_key_rotation = "${var.enable_key_rotation}"
}

module "EBS" {
   source    = "modules/EBS-Volumes"
   count         = "${var.count}"
   mod_ebs_is_encrypt  = "${var.mod_ebs_is_encrypt}"
   mod_ebs_tier  = "${var.mod_ebs_tier}"
   mod_ebs_app   = "${var.mod_ebs_app}"
   mod_ebs_use_snap = "${var.mod_ebs_use_snap}"
   mod_ebs_env   = "${var.mod_ebs_env}"
   mod_ebs_role  = "${var.mod_ebs_role}"
   mod_ebs_name  = "${var.mod_ebs_name}"
   mod_ebs_size  = "${var.mod_ebs_size}"
   mod_ebs_type  = "${var.mod_ebs_type}"
   mod_ebs_mp    = "${var.mod_ebs_mp}"
   mod_ebs_dev   = "${var.mod_ebs_dev}"
   mod_ebs_az = "${var.mod_ebs_az}"
}
   
module "s3" {
   source                             = "modules/S3"
   bucket                             = "${var.bucket}"
   enabled                            = "${var.enabled}"
   namespace                          = "${var.namespace}"
   stage                              = "${var.stage}"
   name                               = "${var.name}"
   region                             = "${var.region}"
   acl                                = "${var.acl}"
   kms_master_key_id                  = "${module.mykms.key_arn}"
   sse_algorithm                      = "${var.sse_algorithm}"
   force_destroy                      = "${var.force_destroy}"
   versioning_enabled                 = "${var.versioning_enabled}"
   lifecycle_rule_enabled             = "${var.lifecycle_rule_enabled}"
   lifecycle_prefix                   = "${var.lifecycle_prefix}"
   lifecycle_tags                     = "${var.lifecycle_tags}"
   noncurrent_version_expiration_days = "${var.noncurrent_version_expiration_days}"
   noncurrent_version_transition_days = "${var.noncurrent_version_transition_days}"
   standard_transition_days           = "${var.standard_transition_days}"
   glacier_transition_days            = "${var.glacier_transition_days}"
   expiration_days                    = "${var.expiration_days}"
   delimiter                          = "${var.delimiter}"
   attributes                         = "${var.attributes}"
   tags                               = "${var.tags}"
}
