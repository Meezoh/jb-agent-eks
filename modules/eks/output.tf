# ==============================================================================
# CLUSTER IDENTITY OUTPUTS
# ==============================================================================

output "cluster_name" {
  value       = module.eks.cluster_name
  description = "The name of the EKS cluster. Used to configure kubectl and reference the cluster in other modules."
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "The API server endpoint of the EKS cluster. kubectl communicates with the cluster through this URL."
}

output "cluster_certificate_authority" {
  value       = module.eks.cluster_certificate_authority_data
  description = "Base64 encoded certificate data for the cluster. Required for authenticating kubectl against the cluster API."
}

# ==============================================================================
# IAM & SECURITY OUTPUTS
# ==============================================================================

output "oidc_provider_arn" {
  value       = module.eks.oidc_provider_arn
  description = "The ARN of the OIDC provider. Required for attaching IAM roles to Kubernetes service accounts (IRSA)."
}

output "cluster_iam_role_arn" {
  value       = module.eks.cluster_iam_role_arn
  description = "The ARN of the IAM role used by the EKS cluster control plane."
}

# ==============================================================================
# NODE GROUP OUTPUTS
# ==============================================================================

output "node_group_iam_role_arn" {
  value       = module.eks.eks_managed_node_groups["jb-agents"].iam_role_arn
  description = "The ARN of the IAM role attached to the jb-agents node group. Used to grant nodes access to AWS services."
}