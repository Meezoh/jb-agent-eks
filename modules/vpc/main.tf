# ==============================================================================
# PROVIDER CONFIGURATION
# ==============================================================================
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ==============================================================================
# VPC CORE NETWORK ARCHITECTURE
# ==============================================================================
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.environment}-k8s-vpc"
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  # ==============================================================================
  # GATEWAY & ROUTING CONFIGURATION
  # ==============================================================================
  
  # Required for private worker nodes to pull Docker images and security patches securely.
  enable_nat_gateway = true
  
  # Optimization: Using a single NAT across all AZs to reduce AWS hourly costs 
  # while still maintaining strict private routing for the K8s worker nodes.
  single_nat_gateway = true 

  # Required for internal Kubernetes DNS resolution and internal node-to-node communication.
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = var.environment
    Project     = "JB-Project-k8s"
    Terraform   = "true"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/jb-agent-eks" = "shared"
    "kubernetes.io/role/internal-elb"    = "1"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/jb-agent-eks" = "shared"
    "kubernetes.io/role/elb"             = "1"
  }
}