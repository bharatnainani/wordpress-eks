module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = var.k8s_cluster_name
  subnets      = var.subnet_ids
  write_kubeconfig = "true"
  config_output_path = "${path.root}/output/kubeconfig"
  tags = {
    "k8s.io/cluster-autoscaler/enabled" = "true"
    "k8s.io/cluster-autoscaler/${var.k8s_cluster_name}" = "owned"
  }
  vpc_id = var.vpc_id
  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      asg_desired_capacity          = 2
      cluster_security_group_id = var.security_group
      worker_security_group_id = var.security_group
    },
  ]
}
resource "null_resource" "output" {
  provisioner "local-exec" {
    command = "mkdir -p ${path.root}/output/"
  }
}
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
