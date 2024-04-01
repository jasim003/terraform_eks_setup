# AWS EKS Setup using Terraform
This setup uses a two-node cluster in the private subnet and access the application via the LoadBalance and has autoscaling set up to keep the minimum number of nodes required for high availability

# Providers used in the code
* AWS
* Kubernetes
* Helm

# Terraform Modules used in the code
* VPC
* EKS
* IAM

# AWS Region
Singapore = **ap-southeast-1**

# VPC Setup
* VPC_Name = **devapp-eks-vpc**
* CIDR Range =  ["10.20.0.0/16"]
* Public Subnet = ["10.20.1.0/24", "10.20.2.0/24"]
* Private Subnet = ["10.20.101.0/24", "10.20.102.0/24"]
* Avaliability zone = ["ap-southeast-1a", "ap-southeast-1b"]
* Route_Table =  One (Connecting to the Public Subnet)
* Internet_gate = One (Connecting to the Private Subnet)
* Nat_gateway = One (Connected to Private Subnet with Public NAT Gateway)

# IAM Policy and Role
* EKS Master Node Policy and Role
* EKS Worker Node Policy and Role
* ELB Policy and Role

# EKS Cluster Addon
* coredns
* kube-proxy
* vpc-cni

# Cmd to Connect to EKS Cluster via Kube configfile
* aws eks update-kubeconfig --region ap-southeast-1 --name Dev-eks-cluster

# Kubectl cmd to check the kubernetes resource
## Check the Worker Nodes
* Kubectl get nodes
## Check the Resource in the default namepsace
* kubectl get all -n kube=system

# Kubectl TroubleShooting command
## Kubernetes Service account check
* kubectl describe sa aws-load-balancer-controller -n kube-system
## LoadBalancer logs
* kubectl logs -f -n kube-system -l app.kubernetes.io/instance=aws-load-balancer-controller

# Docker Container
* Created the custome Docker container with attached index file