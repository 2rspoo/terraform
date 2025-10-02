resource "aws_s3_bucket" "spoobucket-aula" {
  bucket = "spoo-ent3-backend"
  region = "us-east-2"
  tags = var.tags_prod
}