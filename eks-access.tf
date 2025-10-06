# Arquivo: eks-access.tf

# ----------------------------------------------------------------
# PERMISSÃO PARA A ROLE DE INFRAESTRUTURA (a que você já tem)
# Permite que o Terraform da infraestrutura gerencie o cluster.
# ----------------------------------------------------------------
resource "aws_eks_access_entry" "infra_actions_access" {
  cluster_name  = aws_eks_cluster.cluster.name
  principal_arn = "arn:aws:iam::579375260812:role/GitHubActionRole-DatabaseInfra"
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "infra_actions_admin_policy" {
  cluster_name  = aws_eks_cluster.cluster.name
  principal_arn = "arn:aws:iam::579375260812:role/GitHubActionRole-DatabaseInfra"
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [ aws_eks_access_entry.infra_actions_access ]
}


# ----------------------------------------------------------------
# PERMISSÃO PARA A ROLE DA APLICAÇÃO (a que está faltando)
# Permite que o pipeline de CI/CD da aplicação faça deploy.
# ----------------------------------------------------------------
resource "aws_eks_access_entry" "app_deploy_actions_access" {
  cluster_name  = aws_eks_cluster.cluster.name
  # COLOQUE AQUI O ARN DA ROLE DO SEU REPOSITÓRIO DE APLICAÇÃO
  principal_arn = "arn:aws:iam::579375260812:role/GitHubAction-AppDeploy-Role"
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "app_deploy_actions_admin_policy" {
  cluster_name  = aws_eks_cluster.cluster.name
  # COLOQUE AQUI O ARN DA ROLE DO SEU REPOSITÓRIO DE APLICAÇÃO
  principal_arn = "arn:aws:iam::579375260812:role/GitHubAction-AppDeploy-Role"
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [ aws_eks_access_entry.app_deploy_actions_access ]
}