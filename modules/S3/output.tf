output "bucket_domain_name" {
  value       = "${var.enabled == "true" ? join("", aws_s3_bucket.mybucket.*.bucket_domain_name) : ""}"
  description = "FQDN of bucket"
}

output "bucket_id" {
  value       = "${var.enabled == "true" ? join("", aws_s3_bucket.mybucket.*.id) : ""}"
  description = "Bucket Name (aka ID)"
}

output "bucket_arn" {
  value       = "${var.enabled == "true" ? join("", aws_s3_bucket.mybucket.*.arn) : ""}"
  description = "Bucket ARN"
}

output "prefix" {
  value       = "${var.lifecycle_prefix}"
  description = "Prefix configured for lifecycle rules"
}

output "enabled" {
  value       = "${var.enabled}"
  description = "Is module enabled"
}