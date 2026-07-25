output "environment" {
  description = "The current deployment environment."
  value       = local.env
}

output "vpc_id" {
  description = "The ID of the VPC used by the EKS cluster."
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs used for worker nodes and private resources."
  value       = module.vpc.private_subnets
}

output "public_subnet_ids" {
  description = "Public subnet IDs used for load balancers and internet-facing resources."
  value       = module.vpc.public_subnets
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "The endpoint URL for the EKS API server."
  value       = module.eks.cluster_endpoint
}

# output "eks_cluster_arn" {
#   description = "The ARN of the EKS cluster."
#   value       = module.eks.cluster_arn
# }

# output "eks_cluster_certificate_authority_data" {
#   description = "The certificate authority data used to authenticate to the cluster."
#   value       = module.eks.cluster_certificate_authority_data
#   sensitive   = true
# }

# output "eks_oidc_issuer_url" {
#   description = "The OIDC issuer URL for IAM role trust relationships."
#   value       = module.eks.cluster_oidc_issuer_url
# }