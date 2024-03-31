resource "aws_iam_policy" "kubernetes_alb_controller" {
  count       = var.enabled ? 1 : 0
  name        = "${var.ClusterName}-alb-controller"
#   path        = "/"
  description = "Policy for load balancer controller service"
  policy = file("templates/alb_controller_iam_policy.json")
}

# Role
data "aws_iam_policy_document" "kubernetes_alb_controller_assume" {
  count = var.enabled ? 1 : 0

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

     principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${local.account_id}:oidc-provider/${replace("aws_eks_cluster.dev-eks-cluster.identity[0].oidc[0].issuer", "https://", "")}"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace("aws_eks_cluster.dev-eks-cluster.identity[0].oidc[0].issuer", "https://", "")}:sub"

      values = [
        "system:serviceaccount:${var.namespace}:${var.service_account_name}",
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace("aws_eks_cluster.dev-eks-cluster.identity[0].oidc[0].issuer", "https://", "")}:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "kubernetes_alb_controller" {
  count              = var.enabled ? 1 : 0
  name               = "${var.ClusterName}-alb-controller"
  assume_role_policy = data.aws_iam_policy_document.kubernetes_alb_controller_assume[0].json
}

resource "aws_iam_role_policy_attachment" "kubernetes_alb_controller" {
  count      = var.enabled ? 1 : 0
  role       = aws_iam_role.kubernetes_alb_controller[0].name
  policy_arn = aws_iam_policy.kubernetes_alb_controller[0].arn
}