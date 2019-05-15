variable "key_name" {}
variable "account_id" {}
variable "first" {}
variable "second" {}
variable "group" {}
variable "attachment" {}
variable "membership" {}
variable "alias_name" {
   default = "itsme123"
}
variable "deletion_window_in_days" {}
variable "is_enabled" {}
variable "description" {
   default = "mytest123"
}
variable "environment" {
   default = "testdev"
}
variable "enable_key_rotation" {}
variable "product_domain" {
   default = "dev"
}
