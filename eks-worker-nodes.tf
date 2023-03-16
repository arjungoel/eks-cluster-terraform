resource "aws_eks_node_group" "aws_eks_workernodes" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.default_tags.project_name}-worker-node"
  node_role_arn   = aws_iam_role.eks_worker_node_role.arn
  subnet_ids      = [aws_subnet.private_subnet[0].id, aws_subnet.public_subnet[0].id]
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }
  capacity_type = "SPOT"
  launch_template {
    id      = aws_launch_template.eks_launch_template.id
    version = aws_launch_template.eks_launch_template.latest_version
  }
  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.worker-node-role-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.worker-node-role-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.worker-node-role-AmazonEC2ContainerRegistryReadOnly,
    data.aws_launch_template.cluster
  ]
}