resource "kubectl_manifest" "namespace" {
  depends_on = [aws_eks_cluster.cluster,
    kubectl_manifest.aws_auth]
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: nginx
YAML
}