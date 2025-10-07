resource "aws_subnet" "subnet_public" {
  count                   = 3
  vpc_id                  = aws_vpc.vpc_fiap.id
  cidr_block              = cidrsubnet(aws_vpc.vpc_fiap.cidr_block, 4, count.index)
  map_public_ip_on_launch = true
  availability_zone       = ["us-east-1a", "us-east-1b", "us-east-1c"][count.index]

  # --- CORREÇÃO APLICADA AQUI ---
  # A função merge() une o mapa de tags da sua variável com o novo mapa de tags do EKS.
  tags = merge(
    var.tags,
    {
      "kubernetes.io/cluster/eks-spoo-ent9-backend" = "shared",
      "kubernetes.io/role/elb"                      = "1"
    }
  )
}

}