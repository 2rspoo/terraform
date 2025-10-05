data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.cluster.id
  depends_on = [
    aws_eks_cluster.cluster
  ]
}

data "aws_eks_cluster_auth" "auth" {
  name = aws_eks_cluster.cluster.id
  depends_on = [
    aws_eks_cluster.cluster
  ]
}