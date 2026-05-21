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
  description = "CIDR blocks for private subnets. This is where the secure K8s worker nodes will reside."
}

variable "public_subnets" {
  type        = list(string)
  description = "CIDR blocks for public subnets. This will exclusively host the Bastion jump box and NAT Gateways."
}