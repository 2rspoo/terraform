terraform {
  backend "s3" {

    bucket = "spoo-aula-backend"
    key    = "camil/aula8/terraform.tfstate"
    region = "us-east-2"
  }
}
