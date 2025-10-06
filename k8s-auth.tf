resource "kubectl_manifest" "aws_auth" {
  # Usa a função templatefile para ler nosso template e preencher as variáveis
  yaml_body = templatefile("${path.module}/aws-auth.yaml.tpl", {
    # Variável 1: Pega dinamicamente o ARN da role dos seus nós de trabalho
    node_role_arn = aws_eks_node_group.node.node_role_arn,

    # Variável 2: O ARN da role que você quer que seja admin (ex: a role do cluster)
    # ATENÇÃO: Substitua 'aws_iam_role.cluster.arn' pela referência correta à sua role de admin, se for diferente.
    admin_role_arn = aws_iam_role.cluster.arn
  })

  # Garante que a criação do node group termine antes de aplicar este manifesto

  depends_on = [
    aws_eks_node_group.node,
    aws_eks_access_policy_association.infra_actions_admin_policy
  ]
}