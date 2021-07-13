resource "helm_release" "efs-provisioner" {
  name       = "efs-provisioner"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "efs-provisioner"

  set {
    name  = "efsProvisioner.efsFileSystemId"
    value = aws_efs_file_system.efs.id
  }

  set {
    name  = "efsProvisioner.awsRegion"
    value = "us-east-1"
  }
  set {
    name  = "efsProvisioner.path"
    value = "/"
  }
  depends_on = [module.eks]
}

resource "helm_release" "wordpress_site" {
  name       = "wordpress"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "wordpress"
  timeout    = 600
  set {
    name  = "persistence.storageClass"
    value = "aws-efs"
  }

  set {
    name  = "mariadb.master.persistence.storageClass"
    value = "aws-efs"
  }
  depends_on = [module.eks]
}

resource "helm_release" "hpa_perator" {
  name       = "hpa-operator"
  repository = "https://kubernetes-charts.banzaicloud.com"
  chart      = "hpa-operator"

  set {
    name  = "pspEnabled"
    value = "true"
  }

  set {
    name  = "kube-metrics-adapter.pspEnabled"
    value = "true"
  }
  depends_on = [module.eks]
}

resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"

  set {
    name  = "autoDiscovery.enabled"
    value = "true"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.k8s_cluster_name
  }

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "awsRegion"
    value = var.region
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "spotinst.image.repository"
    value = "us.gcr.io/k8s-artifacts-prod/autoscaling/cluster-autoscale"
  }

  set {
    name  = "spotinst.image.tag"
    value = "v1.16.5"
  }
  depends_on = [module.eks]
}
