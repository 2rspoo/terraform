resource "kubectl_manifest" "deploy" {
  depends_on = [
    kubectl_manifest.namespace,
    aws_eks_access_policy_association.infra_actions_admin_policy
  ]
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deploy
  namespace: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
       app: nginx
  template:
    metadata:
      labels:
         app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.25
          ports:
            - containerPort: 80
YAML
}