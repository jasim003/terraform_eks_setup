# data "cloudinit_config" "eks_packages" {
#   gzip          = true
#   base64_encode = true
#   part {
#     content_type = "text/cloud-config"
#     content = file("${path.module}/cloud-config.yaml")
#   }
# }


# resource "aws_instance" "jump_host" {
#   ami  = "ami-097c4e1feeea169e5"
#   instance_type = "t2.micro"
#   security_groups = [aws_security_group.cluster_sgrp.id]
#   subnet_id     = element(module.vpc.public_subnets, 0)
#   associate_public_ip_address = true
#   key_name = "demo-keys"  
#   user_data = data.cloudinit_config.eks_packages.rendered
# tags = {
#     Name = "Bastin Host"
#   }
# }