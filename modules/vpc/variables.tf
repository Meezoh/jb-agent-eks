# ==============================================================================
# ENVIRONMENT & CIDR VARIABLES
# ==============================================================================

variable "environment" {
  type        = string
  description = "The deployment environment (e.g., dev, prod) used for resource tagging and naming."
}

variable "vpc_cidr" {
  type        = string
  description = "The primary IPv4 CIDR block for the overarching VPC network."
}

variable "azs" {
  type        = list(string)
  description = "The list of AWS Availability Zones to ensure high availability across the cluster."
}

# ==============================================================================
# SUBNET ALLOCATION VARIABLES
# ==============================================================================

variable "private_subnets" {
  type        = list(string)
  description = "CIDR blocks for private subnets. EKS worker nodes live here, isolated from the internet."
}

variable "public_subnets" {
  type        = list(string)
  description = "CIDR blocks for public subnets. NAT Gateway lives here for outbound node internet access."
}