aws_region            = "us-east-1"
default_tags = {
  primary_owner   = "Arjun Goel"
  secondary_owner = "Harsh Goel"
  project_name    = "EKS-POC-PROJECT"
}
cidr_block           = "192.168.0.0/16"
public_subnet_count  = 2
private_subnet_count = 2

cluster_name = "eks-cluster-poc"
addons = [
  {
    name    = "vpc-cni"
    version = "v1.12.5-eksbuild.2"
  },
  {
    name    = "coredns"
    version = "v1.9.3-eksbuild.2"
  },
  {
    name    = "kube-proxy"
    version = "v1.25.6-eksbuild.2"
  }
]

cloudwatch_log_group_name  = "eks_cluster_cw_log_group"
cloudwatch_log_stream_name = "eks_cluster_cw_log_stream"
eks_service_role           = "eks_iam_service_role"
eks_workernode_role        = "eks_iam_worker_node_role"
launch_template_name       = "eks_worker_node_lt"