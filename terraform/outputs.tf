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
