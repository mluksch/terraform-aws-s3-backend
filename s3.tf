resource "aws_s3_bucket" "backend" {
  bucket = local.namespace
  force_destroy = true
  tags = {
    namespace: local.namespace
  }
}

resource "aws_s3_bucket_versioning" "backend" {
  bucket = aws_s3_bucket.backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_kms_key" "backend" {
  enable_key_rotation = true
  tags = {
    namespace: local.namespace
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backend" {
  bucket = aws_s3_bucket.backend.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
      kms_master_key_id = aws_kms_key.backend.id
    }
  }
}

resource "aws_s3_bucket_policy" "backend" {
  bucket = ""
  policy = ""
}