resource "aws_s3_bucket" "spoobucket-aula" {
  bucket = "spoo-ent3-backend"
  region = "sa-east-2"
  tags = var.tags_prod
}