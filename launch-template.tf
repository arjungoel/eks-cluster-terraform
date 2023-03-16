resource "aws_launch_template" "eks_launch_template" {
  name          = var.launch_template_name
  instance_type = "t3.large"
  image_id      = data.aws_ssm_parameter.cluster.value
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
      volume_type = "gp2"
    }
  }
  block_device_mappings {
    device_name = "/dev/xvdb"
    ebs {
      volume_size = 40
      volume_type = "gp2"
    }
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "eks-worker-node"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      Name = "eks-worker-node"
    }
  }
  user_data = base64encode(templatefile("userdata.tpl", { CLUSTER_NAME = aws_eks_cluster.eks_cluster.name, B64_CLUSTER_CA = aws_eks_cluster.eks_cluster.certificate_authority[0].data, API_SERVER_URL = aws_eks_cluster.eks_cluster.endpoint }))
  #   depends_on = [
  #     aws_eks_cluster.eks_cluster
  #   ]
}