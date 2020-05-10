resource "aws_s3_bucket" "releasebucket" {
  bucket = format("%s-%s-%s-%s-release", var.prefix, var.region_name, var.stage, var.service)
  acl    = "private"
  
  versioning {
    enabled = true
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
      storage_class = "STANDARD_IA" # or "ONEZONE_IA"
    }
  }
  tags = var.tags
}
