resource "kubectl_manifest" "service" {
  depends_on = [
    kubectl_manifest.deploy,
    aws_eks_access_policy_association.infra_actions_admin_policy
  ]
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  name: minha-app-service
  namespace: nginx
spec:
  selector:
      app: minha-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: LoadBalancer
YAML
}