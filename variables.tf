variable "region" {
  description = "AWS region"
  type        = string
}

variable "subnet_ids" {
  description = "list of subnet ids"
  type        = list
}

variable "k8s_cluster_name"{
  description = "Name of the Cluster"
  type        = string
}

variable "security_group" {
  description = "SG id"
  type        = list
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}
