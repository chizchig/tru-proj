# S3 bucket with encryption, policy and lifecyle config
resource "aws_s3_bucket" "bullion_bucket" {
  bucket = "bullion-bucket"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bullion_encryption" {
  bucket = aws_s3_bucket.bullion_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

data "aws_iam_policy_document" "bullion-access" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]

    resources = [
      "${aws_s3_bucket.bullion_bucket.arn}",
      "${aws_s3_bucket.bullion_bucket.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bullion_bucket_lifecycle" {
  bucket = aws_s3_bucket.bullion_bucket.id

  rule {
    id     = "bullion-lifecycle-rule"
    status = "Enabled"

    filter {
      prefix = ""
    }

    expiration {
      days                        = 2
      expired_object_delete_marker = true
    }
  }
}