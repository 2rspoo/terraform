resource "aws_vpc" "vpc_fiap" {
  cidr_block           = var.cidr_vpc
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.tags
}

resource "aws_security_group_rule" "cluster_inbound_from_nodes" {
  description              = "Permite que os worker nodes se conectem ao control plane do EKS"
  type                     = "ingress"  # Regra de ENTRADA (Inbound)
  from_port                = 443        # Porta do API Server do Kubernetes
  to_port                  = 443
  protocol                 = "tcp"

  # A origem do tráfego é o Security Group dos seus Nós de Trabalho
  source_security_group_id = aws_security_group.sg.id

  # O destino é o Security Group do seu Cluster EKS
  security_group_id        = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
}