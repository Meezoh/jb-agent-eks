# ==============================================================================
# PROVIDER CONFIGURATION
# ==============================================================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# ==============================================================================
# EKS CLUSTER
# ==============================================================================

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  # Allow kubectl access from your local machine
  endpoint_public_access = true

  # Automatically grants the IAM identity that creates the cluster
  # admin permissions — means you can run kubectl immediately after apply
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnet_ids
  control_plane_subnet_ids = var.private_subnet_ids

  eks_managed_node_groups = {
    jb-agents = {
      # AL2023 is the current AWS default for managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = [var.node_instance_type]

      min_size     = var.min_node_count
      max_size     = var.max_node_count
      desired_size = var.desired_node_count
    }
  }

  tags = {
    Environment = var.environment
    Project     = "JB-Project-k8s"
    Terraform   = "true"
  }
}