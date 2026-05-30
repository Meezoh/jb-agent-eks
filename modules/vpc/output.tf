# ==============================================================================
# VPC IDENTIFIER OUTPUTS
# ==============================================================================

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The core VPC ID. Passed to the EKS module to place the cluster in the correct network."
}

# ==============================================================================
# SUBNET IDENTIFIER OUTPUTS
# ==============================================================================

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "The IDs of the private subnets. EKS worker nodes and control plane ENIs live here."
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "The IDs of the public subnets. NAT Gateway lives here for outbound node traffic."
}