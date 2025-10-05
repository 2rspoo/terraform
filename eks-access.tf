# Arquivo: eks-access.tf

# 1. Cria a entrada de acesso para a Role do GitHub Actions
resource "aws_eks_access_entry" "github_actions_access" {
  cluster_name  = aws_eks_cluster.cluster.name
  principal_arn = "arn:aws:iam::579375260812:role/GitHubActionRole-DatabaseInfra" # <-- Aspas adicionadas
  type          = "STANDARD"
}

# 2. Associa a política de "Administrador do Cluster" a essa entrada de acesso
resource "aws_eks_access_policy_association" "github_actions_admin_policy" {
  cluster_name  = aws_eks_cluster.cluster.name
  principal_arn = "arn:aws:iam::579375260812:role/GitHubActionRole-DatabaseInfra" # <-- Aspas adicionadas
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  # Garante que a entrada de acesso seja criada primeiro
  depends_on = [
    aws_eks_access_entry.github_actions_access
  ]
}