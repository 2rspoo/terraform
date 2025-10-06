resource "kubectl_manifest" "deploy" {
  depends_on = [
    kubectl_manifest.namespace,
    aws_eks_access_policy_association.infra_actions_admin_policy
  ]
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: minha-app-deploy
  namespace: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
       app: minha-app  # <-- MUDANÇA 1: Etiqueta corrigida
  template:
    metadata:
      labels:
         app: minha-app # <-- MUDANÇA 1: Etiqueta corrigida
    spec:
      containers:
        - name: minha-app
          image: IMAGEM_PLACEHOLDER
          ports:
            - containerPort: 8080 # <-- MUDANÇA 2: Porta corrigida para Spring Boot
YAML
}