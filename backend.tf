terraform {
  backend "s3" {

    bucket = "spoo-ent7-backend"
    key    = "camil/aula8/terraform.tfstate"
    region = "us-east-1"
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