# terraform_eks_setup
AWS EKS Setup using Terraform

aws eks update-kubeconfig --region ap-southeast-1 --name Dev-eks-cluster

kubectl apply -f deploy.yaml
kubectl get all -n dev

kubectl get ingress ingress-nginx -n dev