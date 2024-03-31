provider "aws" {
    region = var.region
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = var.ClusterName
}

locals {
  worker_name = var.WorkerNode
}

data "aws_caller_identity" "current" {}

locals {
    account_id = data.aws_caller_identity.current.account_id
}

data "aws_eks_cluster" "cluster" {
  name = var.ClusterName
  depends_on = [module.eks.cluster_name]
}
data "aws_eks_cluster_auth" "cluster" {
  name = var.ClusterName
  depends_on = [module.eks.cluster_name]
}

# data "aws_iam_openid_connect_provider" "oidc_provider" {
#   url = data.aws_eks_cluster.cluster.identity.0.oidc.0.issuer
# }

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}