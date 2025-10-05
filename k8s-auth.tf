resource "kubectl_manifest" "aws_auth" {
  depends_on = [aws_eks_cluster.cluster]
  yaml_body = <<YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapUsers: |
    - userarn: arn:aws:iam::579375260812:user/camila
      username: camila
      groups:
        - system:masters
YAML
}