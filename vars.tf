variable "bucket_name_backend" {
  default = "spoo-ent7-backend"
}

variable "region_default" {
  default = "us-east-1"
}

variable "tags_dev" {
  type = map(any)
  default = {
    Name        = "aula2"
    Environment = "Develop"
  }
}

variable "tags_prod" {
  type = map(any)
  default = {
    Name        = "tfstate",
    Environment = "Production",
    School = "FIAP",
    Year = "2025"
  }
}

variable "instance-type" {
  default = "t3.medium"
}

variable "cidr_vpc" {
  default = "10.0.0.0/16"
}

variable "cidr_subnet" {
  default = "10.0.1.0/24"
}

variable "tags" {
  default = {
    Name = "fiap-terraform-aula"
  }
}

variable "principal_user_arn" {
  type    = string
  default = "arn:aws:iam::579375260812:user/camila"
}