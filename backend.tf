terraform {
  cloud {
    organization = "spoo-terraform"
    workspaces {
      name = "terraform"
    }
  }
}