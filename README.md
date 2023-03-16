**EKS Cluster Creation using Terraform**

This README is used for deploying the EKS cluster using terraform. You have to follow the steps:
1. Create the VPC, IAM roles (EKS Cluster, Worker Nodes) as a pre-requisite.
2. Create the EKS cluster and try to use kubernetes version `1.25`.
3. Create the launch template using terraform and update the `config` file with EKS cluster `API server endpoint` and `certificate authority data`.
4. Create the worker nodes and reference the launch template code inside it. The default version of the launch template is 1 and the latest version can be 2, 3, 4 etc.