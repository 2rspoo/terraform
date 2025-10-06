# Arquivo: aws-auth.yaml.tpl

apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    # Bloco para permitir que os nós de trabalho (worker nodes) se juntem ao cluster.
    # Esta é a parte que eu sugeri anteriormente.
    - rolearn: ${node_role_arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes

    # Bloco para dar permissão de admin (system:masters) a uma role específica.
    # Esta é a parte que você já tinha para o github-actions.
    - rolearn: ${admin_role_arn}
      username: github-actions
      groups:
        - system:masters

    - rolearn: arn:aws:iam::579375260812:role/GitHubAction-AppDeploy-Role
      username: github-actions-deployer
      groups:
        - system:masters # Dê permissão de admin para deploy.