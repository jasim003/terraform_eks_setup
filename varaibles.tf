################################################################################
# Default Variables
################################################################################

variable "region" {
    description = "AWS Region"
    type = string
    default = "ap-southeast-1"
  
}

################################################################################
# EKS Cluster Variables
################################################################################

variable "ClusterName" {
    description = "Name of the EKS Cluster"
    type = string
    default = "Dev-eks-cluster"
  
}

variable "WorkerNode" {
    description = "Name of the EKS Cluster"
    type = string
    default = "Dev-eks-workernode"
  
}

################################################################################
# ALB Controller Variables
################################################################################

variable "env_name" {
  type    = string
  default = "Dev"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled."
}

variable "service_account_name" {
  type        = string
  default     = "aws-load-balancer-controller"
  description = "ALB Controller service account name"
}

variable "namespace" {
  type        = string
  default     = "kube-system"
  description = "Kubernetes namespace to deploy ALB Controller Helm chart."
}


