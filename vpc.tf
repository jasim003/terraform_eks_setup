module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"

  name = "devapp-eks-vpc"
  cidr = "10.20.0.0/16"

  azs = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = ["10.20.1.0/24", "10.20.2.0/24"]
  public_subnets  = ["10.20.101.0/24", "10.20.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  # enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}
locals {
    ports_in = [
      22,
      443
    ]
    ports_out = [
      0
    ]
  }

resource "aws_security_group" "cluster_sgrp" {
    name = "allow_tls"
    description = "Cluster communicaton with worker nodes"
    vpc_id = module.vpc.vpc_id

    dynamic "ingress" {
      for_each = toset(local.ports_in)
      content {
        description = "TLS for VPC"
        from_port = ingress.value
        to_port = ingress.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
    dynamic "egress" {
      for_each = toset(local.ports_out)
      content {
        description = "TLS for VPC"
        from_port = egress.value
        to_port = egress.value
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }


    }

    tags = {
      "Name"   = "Dev SGP"
    }
}
