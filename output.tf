output "cluster_name" {
    description = "AWS EKS Cluster Name"
    value = module.eks.cluster_name
}

output "cluster_endpoint" {
    description = "Endpoint for AWS EKS"
    value = module.eks.cluster_endpoint
}

output "region" {
    description = "AWS EKS Cluster Region"
    value = var.region
}

output "cluster_status" {
    description = "EKS Cluster Status"
    value = module.eks.cluster_status
}

# output "Bastin_instance" {
#     description = "Jump Host instance"
#     value = aws_instance.jump_host.id
# }

output "identity-oidc-issuer" {
  value = module.eks.cluster_oidc_issuer_url
}

output "oidc_provider" {
  description = "The OpenID Connect identity provider (issuer URL without leading `https://`)"
  value       = module.eks.oidc_provider
}

output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider"
  value       = module.eks.oidc_provider_arn
}

output "account_id" {
  value = local.account_id
}
