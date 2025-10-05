resource "kubectl_manifest" "aws_auth" {
  depends_on = [aws_eks_cluster.cluster]

  yaml_body = <<YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: arn:aws:iam::579375260812:role/GitHubActionRole-DatabaseInfra
      username: github-actions
      groups:
        - system:masters
YAML
}