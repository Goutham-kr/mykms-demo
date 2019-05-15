variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {}
variable "account_id" {}
variable "key_name" {}
variable "first" {}
variable "second" {}
variable "group" {}
variable "attachment" {}
variable "encryption" {}
variable "namespace" {}
variable "stage" {}
variable "name" {}
variable "delimiter" {
  default     = "-"
}

variable "attributes" {
  default     = []
}

variable "tags" {
  type        = "map"
  default     = {}
}

variable "acl" {}
variable "force_destroy" {}
variable "versioning_enabled" {}
variable "lifecycle_rule_enabled" {}
variable "lifecycle_prefix" {}
variable "lifecycle_tags" {
  description = "Tags filter. Used to manage object lifecycle events"
  type        = "map"
  default     = {}
}
variable "noncurrent_version_expiration_days" {}
variable "noncurrent_version_transition_days" {}
variable "standard_transition_days" {}
variable "glacier_transition_days" {}
variable "expiration_days" {}
variable "mod_ebs_name" {}
variable "mod_ebs_size" {}
variable "mod_ebs_type" {}
variable "mod_ebs_mp" {}
variable "mod_ebs_dev" {}
variable "enabled" {}
variable "bucket" {}
variable "count" {}
variable "mod_ebs_is_encrypt" {}
variable "mod_ebs_use_snap" {
   default = ""
}
variable "mod_ebs_az" {}
variable "mod_ebs_env" {}
variable "mod_ebs_app" {}
variable "mod_ebs_tier" {}
variable "mod_ebs_role" {}
variable "membership" {}
variable "alias_name" {}
variable "deletion_window_in_days" {}
variable "is_enabled" {}
variable "description" {}
variable "environment" {}
variable "enable_key_rotation" {}
variable "product_domain" {}
variable "sse_algorithm" {}