resource "aws_s3_bucket" "spoobucket-aula" {
  bucket = "spoo-aula-backend"
  region = "sa-east-1"
  tags = var.tags_prod
}