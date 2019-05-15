output "key_arn" {
  value       = "${aws_kms_key.key.arn}"
  description = "Key ARN"
}

output "key_id" {
  value       = "${aws_kms_key.key.key_id}"
  description = "Key ID"
}

output "alias_arn" {
  value       = "${aws_kms_alias.alias.arn}"
  description = "Alias ARN"
}

output "alias_name" {
  value       = "${aws_kms_alias.alias.name}"
  description = "Alias name"
}