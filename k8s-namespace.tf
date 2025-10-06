resource "kubectl_manifest" "namespace" {
  # O depends_on agora deve apontar para a política de acesso,
  # não para o aws_auth que foi removido.
  depends_on = [
    aws_eks_access_policy_association.infra_actions_admin_policy
  ]
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: nginx
YAML
}