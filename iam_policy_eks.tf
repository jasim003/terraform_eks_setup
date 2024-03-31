data "aws_iam_policy_document" "assume_role_master" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "master" {
  name               = "${var.env_name}-eks-master"
  assume_role_policy = data.aws_iam_policy_document.assume_role_master.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.master.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.master.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.master.name
}


data "aws_iam_policy_document" "assume_role_worker" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "worker" {
  name               = "${var.env_name}-eks-worker"
  assume_role_policy = data.aws_iam_policy_document.assume_role_worker.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worker.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.worker.name
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.worker.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker.name
}

resource "aws_iam_role_policy_attachment" "x-ray" {
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
  role       = aws_iam_role.worker.name
}

resource "aws_iam_role_policy_attachment" "s3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.worker.name
}

# data "aws_iam_policy_document" "eks_autoscaler" {
#   statement {
#     effect    = "Allow"
#     actions   = [
#         "autoscaling:DescribeAutoScalingGroups",
#         "autoscaling:DescribeAutoScalingInstances",
#         "autoscaling:DescribeTags",
#         "autoscaling:SetDesiredCapacity",
#         "autoscaling:DescribeLaunchConfigurations",
#         "autoscaling:TerminateInstanceInAutoScalingGroup",
#         "ec2:DescribeLaunchTemplateVersions"
#       ]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_role" "eks_cluster_autoscaler" {
#   assume_role_policy = data.aws_iam_policy_document.eks_autoscaler.json
#   name               = "eks-cluster-autoscaler"
# }

# resource "aws_iam_role_policy_attachment" "autoscaler_attach" {
#   policy_arn = aws_iam_role.eks_cluster_autoscaler.arn
#   role       = aws_iam_role.eks_cluster_autoscaler.name
# }



# resource "aws_iam_policy" "autoscaler" {
#   name        = "${var.env_name}-autoscaler-policy"
#   policy      = data.aws_iam_policy_document.policy.json
# }



# resource "aws_iam_instance_profile" "worker" {
#   depends_on = [aws_iam_role.worker]
#   name       = "${var.env_name}-eks-worker-new-profile"
#   role       = aws_iam_role.worker.name
# }
