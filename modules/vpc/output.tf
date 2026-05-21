# ==============================================================================
# VPC IDENTIFIER OUTPUTS
# ==============================================================================
output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The core VPC ID required by the EC2 module to place instances in the correct network."
}

# ==============================================================================
# SUBNET IDENTIFIER OUTPUTS
# ==============================================================================
output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "The IDs of the private subnets. Used by the EC2 module to deploy the strict-access K8s nodes."
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "The IDs of the public subnets. Used by the EC2 module to deploy the Bastion Host for SSH access."
}