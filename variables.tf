variable "aws_region" {
  type        = string
  description = "AWS Region to be utilized"
}

variable "aws_access_key" {
  type        = string
  description = "AWS Access key for IAM user"
}

variable "aws_secret_access_key" {
  type        = string
  description = "AWS Secret access key for IAM user"
}

variable "cidr_block" {
  type        = string
  description = "VPC CIDR Block"
}

variable "default_tags" {
  type        = map(string)
  description = "Tagging used for AWS resource"
}

variable "public_subnet_count" {
  type        = number
  description = "Total number of public subnets to create"
}

variable "private_subnet_count" {
  type        = number
  description = "Total number of private subnets to create"
  default     = 2
}

variable "eks_service_role" {
  type        = string
  description = "EKS Service Role Name"
}

variable "eks_workernode_role" {
  type        = string
  description = "EKS Worker Node Role Name"
}

variable "cluster_name" {
  type        = string
  description = "EKS Cluster name"
}

variable "cloudwatch_log_group_name" {
  type        = string
  description = "EKS Cluster Log group name"
}

variable "cloudwatch_log_stream_name" {
  type        = string
  description = "EKS Cluster Log stream name"
}

variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))
}

variable "launch_template_name" {
  type        = string
  description = "AWS EC2 Launch Template Name"
}