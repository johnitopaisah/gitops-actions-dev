# Cluster Infor
output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}
output "cluster_endpoint" {
  description = "Endpoint for the EKS API server"
  value       = module.eks.cluster_endpoint
}
output "cluster_platform_version" {
  description = "Platform version for the cluster"
  value       = module.eks.cluster_platform_version  
}
output "cluster_status" {
  description = "Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED`"
  value       = module.eks.cluster_status
}
output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.eks.cluster_arn
}
output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.eks.cluster_certificate_authority_data
}
output "cluster_identity_oidc_issuer" {
  description = "The OIDC Identity issuer for the cluster"
  value       = module.eks.cluster_identity_oidc_issuer
}
output "cluster_identity_oidc_issuer_arn" {
  description = "The OIDC Identity issuer ARN for the cluster that can be used to associate IAM roles with a service account"
  value       = module.eks.cluster_identity_oidc_issuer_arn
}

# Kubectl Configuration
output "configure_kubectl" {
  description = "Configure kubectl: making sure to login with the correct AWS profile and run the following command"
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.aws_region}"
}
output "ecr_repo_url" {
  description = "ECR Repo URL"
  value       = module.ecr.repository_url
}
output "ecr_repo_name" {
  description = "ECR Repo ARN"
  value       = module.ecr.repository_name
}
