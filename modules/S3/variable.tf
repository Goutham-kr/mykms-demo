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

variable "lifecycle_tags" {
  description = "Tags filter. Used to manage object lifecycle events"
  type        = "map"
  default     = {}
}

variable "acl" {}
variable "force_destroy" {}
variable "versioning_enabled" {}
variable "lifecycle_rule_enabled" {}
variable "lifecycle_prefix" {}
variable "noncurrent_version_expiration_days" {}
variable "noncurrent_version_transition_days" {}
variable "standard_transition_days" {}
variable "glacier_transition_days" {}
variable "expiration_days" {}
variable "kms_master_key_id" {}
variable "sse_algorithm" {}
variable "bucket" {}
variable "enabled" {}
variable "region" {}