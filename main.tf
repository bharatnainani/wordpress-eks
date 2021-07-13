provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

terraform {
  required_version = ">= 0.12.23"
}

provider "helm" {
  version = "~> 1.0"
}

provider "kubernetes" {
  version = "~> 1.7"
  load_config_file       = "false"
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

