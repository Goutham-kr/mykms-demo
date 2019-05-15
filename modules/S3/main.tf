resource "aws_s3_bucket" "mybucket" {
  count         = "${var.enabled == "true" ? 1 : 0}"
  bucket        = "${var.bucket}"
  acl           = "${var.acl}"
  region        = "${var.region}"
  force_destroy = "${var.force_destroy}"

  versioning {
    enabled = "${var.versioning_enabled}"
  }

  lifecycle_rule {
    id      = "log"
    enabled = "${var.lifecycle_rule_enabled}"

    prefix = "${var.lifecycle_prefix}"
    tags   = "${var.lifecycle_tags}"

    noncurrent_version_expiration {
      days = "${var.noncurrent_version_expiration_days}"
    }

    noncurrent_version_transition {
      days          = "${var.noncurrent_version_transition_days}"
      storage_class = "GLACIER"
    }

    transition {
      days          = "${var.standard_transition_days}"
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = "${var.glacier_transition_days}"
      storage_class = "GLACIER"
    }

    expiration {
      days = "${var.expiration_days}"
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
	    sse_algorithm     = "${var.sse_algorithm}" 
        kms_master_key_id = "${var.kms_master_key_id}"
      }
    }
  }

  tags = "${var.tags}"
}

resource "aws_s3_bucket_policy" "mybucketpolicy" {
  bucket = "${aws_s3_bucket.mybucket.id}"
  policy =<<POLICY
{
  "Version": "2012-10-17",
  "Id": "TESTMYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "${aws_s3_bucket.mybucket.arn}/*",
	  "Condition": {
         "IpAddress": {"aws:SourceIp": "0.0.0.0/0"}
      } 
    } 
  ]
}
POLICY
}