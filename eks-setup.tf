module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"
 
  # eks cluster name and version
  cluster_name    = local.cluster_name
  cluster_version = 1.29
 
  # vpc id where the eks cluster security group needs to be created
  vpc_id = module.vpc.vpc_id
  
  # subnets where the eks node groups needs to be created
  subnet_ids = module.vpc.private_subnets

  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
        description                = "To node 1025-65535"
        protocol                   = "tcp"
        from_port                  = 1025
        to_port                    = 65535
        type                       = "egress"
        source_node_security_group = true
    }
    }
  # Extend node-to-node security group rules
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  # to enable public and private access for eks cluster endpoint
  cluster_endpoint_private_access = false
  cluster_endpoint_public_access  = true
  authentication_mode = "API_AND_CONFIG_MAP"

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true
 
  # create an OpenID Connect Provider for EKS to enable IRSA
  enable_irsa = true
 
  # install eks managed addons
  cluster_addons = {
    # extensible DNS server that can serve as the Kubernetes cluster DNS
    coredns = {
      resolve_conflicts = "OVERWRITE"
      most_recent = true
    }
 
    # maintains network rules on each Amazon EC2 node. It enables network communication to your Pods
    kube-proxy = {
      resolve_conflicts = "OVERWRITE"
      most_recent = true
    }
 
    # a Kubernetes container network interface (CNI) plugin that provides native VPC networking for your cluster
    vpc-cni = {
      most_recent = true
    }
  }
 
  # eks managed node group named worker
  eks_managed_node_groups = {
    dev-eks-workernode = {
    disk_size = 20
    ami_type = "AL2_x86_64"
    instance_types = ["t3.medium"]
    min_size     = 1
    max_size     = 2
    desired_size = 2
    capacity_type  = "ON_DEMAND"
    cluster_additional_security_group_id = "resource.security_group.security_groups"
  }
}

}
