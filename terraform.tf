terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.42.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.27.0"
    }
  }

    backend "s3" {
      bucket = "terraform-eks-setup"
      key    = "terraform.tfstate"
      region = "ap-southeast-1"
    }

  required_version = "~> 1.5.7"
}