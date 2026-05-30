# ==============================================================================
# CLUSTER IDENTITY VARIABLES
# ==============================================================================

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster. Used for resource naming and tagging."
}

variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version to run on the cluster."
  default     = "1.33"
}

variable "environment" {
  type        = string
  description = "The deployment environment (e.g., dev, prod) used for resource tagging and naming."
}

# ==============================================================================
# NETWORKING VARIABLES
# ==============================================================================

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the EKS cluster will be deployed."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs. Worker nodes and control plane ENIs live here."
}

# ==============================================================================
# NODE GROUP VARIABLES
# ==============================================================================

variable "node_instance_type" {
  type        = string
  description = "EC2 instance type for the EKS worker nodes."
  default     = "t3.medium"
}

variable "desired_node_count" {
  type        = number
  description = "Desired number of worker nodes in the node group."
  default     = 2
}

variable "min_node_count" {
  type        = number
  description = "Minimum number of worker nodes. Cluster will never scale below this."
  default     = 1
}

variable "max_node_count" {
  type        = number
  description = "Maximum number of worker nodes. Cluster will never scale above this."
  default     = 2
}