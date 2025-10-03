terraform {
  backend "s3" {

    bucket = "spoo-ent3-backend"
    key    = "camil/aula8/terraform.tfstate"
    region = "us-east-2"
  }
}

#terraform {
#  cloud {
#    organization = "spoo-aula9-terraform"
#    workspaces {
#      name = "terraform-soat"
#    }
#  }
#}