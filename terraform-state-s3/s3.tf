resource "aws_s3_bucket" "backendbucket" {
  bucket = var.bucket_name
  acl    = "private"
  
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    prefix  = "config/"
    enabled = true

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = var.tags
}