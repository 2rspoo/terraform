resource "aws_s3_bucket" "spoobucket-backend" {
  bucket = var.bucket_name_backend
  tags   = var.tags
}