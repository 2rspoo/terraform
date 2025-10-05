resource "aws_s3_bucket" "spoobucket-aula" {
  bucket = var.bucket_name_backend
  region = "us-east-2"
  tags = var.tags_prod
  lifecycle {
    prevent_destroy = false
    ignore_changes  = [bucket]
}
  }