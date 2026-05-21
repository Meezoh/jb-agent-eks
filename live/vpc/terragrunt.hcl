# ==============================================================================
# TERRAGRUNT CONFIGURATION & STATE MANAGEMENT
# ==============================================================================

# Inherit the S3 backend and provider settings from the root level to keep code DRY.
include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Point directly to our standardized VPC blueprint.
terraform {
  source = "../../../modules/vpc"
}

# ==============================================================================
# PRODUCTION ENVIRONMENT INPUTS
# ==============================================================================
inputs = {
  environment     = "prod"
  vpc_cidr        = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  
  # Strict segregation: The 5 K8s nodes will launch entirely within these private ranges.
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"] 
  
  # Internet-facing: Only the NAT Gateway and the Bastion Host will launch here.
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"] 
}