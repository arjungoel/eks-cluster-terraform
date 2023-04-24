resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.service_role.arn

  vpc_config {
    subnet_ids              = [aws_subnet.private_subnet[1].id, aws_subnet.public_subnet[0].id]
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  version = "1.25"

  #   # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  #   # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.service-role-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.service-role-AmazonEKSVPCResourceController,
    aws_cloudwatch_log_group.cw_log_group,
  ]

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  tags = {
    cost_centre = "engineering"
  }

}

resource "aws_eks_addon" "addons" {
  for_each          = { for addon in var.addons : addon.name => addon }
  cluster_name      = aws_eks_cluster.eks_cluster.id
  addon_name        = each.value.name
  addon_version     = each.value.version
  resolve_conflicts = "OVERWRITE"
}


output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}