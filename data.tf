# Data Resource
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ssm_parameter" "cluster" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.eks_cluster.version}/amazon-linux-2/recommended/image_id"
}

data "aws_launch_template" "cluster" {
  name = aws_launch_template.eks_launch_template.name

  depends_on = [aws_launch_template.eks_launch_template]
}