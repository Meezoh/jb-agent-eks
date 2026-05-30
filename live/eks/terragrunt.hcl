# ==============================================================================
# TERRAGRUNT CONFIGURATION & STATE MANAGEMENT
# ==============================================================================

# Inherit the S3 backend and provider settings from the root level to keep code DRY.
include "root" {
  path = find_in_parent_folders("root.hcl")
}

# ==============================================================================
# MODULE SOURCE
# ==============================================================================

# Point directly to our EKS module blueprint.
terraform {
  source = "../../modules/eks"
}

# ==============================================================================
# VPC DEPENDENCY
# ==============================================================================

# Pull VPC outputs so we can pass subnet IDs and VPC ID into the EKS module.
# Terragrunt will ensure VPC is always provisioned before EKS.
dependency "vpc" {
  config_path = "../vpc"

  # Allows terragrunt plan to work even if VPC hasn't been applied yet.
  # Returns empty/mock values during plan so you can validate without deploying.
  mock_outputs = {
    vpc_id          = "vpc-00000000000000000"
    private_subnets = ["subnet-00000000000000001", "subnet-00000000000000002"]
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

# ==============================================================================
# INPUTS
# ==============================================================================

inputs = {
  # Cluster identity
  cluster_name       = "jb-agent-eks"
  kubernetes_version = "1.33"
  environment        = "prod"

  # Networking — pulled directly from VPC outputs
  vpc_id             = dependency.vpc.outputs.vpc_id
  private_subnet_ids = dependency.vpc.outputs.private_subnets

  # Node group — t3.medium keeps costs low during development
  node_instance_type = "t3.medium"
  desired_node_count = 2
  min_node_count     = 1
  max_node_count     = 2
}