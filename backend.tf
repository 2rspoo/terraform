terraform {
  backend "s3" {

    bucket = "spoo-ent8-backend"
    key    = "camil/aula8/terraform.tfstate"
    region = "us-east-1"
  }
}

