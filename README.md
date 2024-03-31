# AWS EKS Setup using Terraform
This setup uses a two-node cluster and has autoscaling set up to keep the minimum number of nodes required for high availability.

# Providers used in this setup
* AWS
* Kubernetes
* Helm

# AWS Modules
* VPC
* EKS
* IAM


# AWS Region
Singapore = "ap-southeast-1"

# VPC Setup
* VPC_Name = "devapp-eks-vpc"
* CIDR Range =  ["10.20.0.0/16"]
* Public Subnet = ["10.20.1.0/24", "10.20.2.0/24"]
* Private Subnet = ["10.20.101.0/24", "10.20.102.0/24"]
* Avaliability zone = ["ap-southeast-1a", "ap-southeast-1b"]
* Route_Table =  One (Connecting to the Public Subnet)
* Internet_gate = One (Connecting to the Private Subnet)
* Nat_gateway = One (Connected to Private Subnet with Public NAT Gateway)

# IAM Policy and Role
* ELK Master Policy and Role
* ELK Worker Policy and Role
* ELB Policy and Role

# Cmd to Connect to EKS Cluster via Kube config
* aws eks update-kubeconfig --region ap-southeast-1 --name Dev-eks-cluster