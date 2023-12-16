variable "cluster_name" {
  description = "the cluster name"
  default     = "gitops"
}

variable "kubernetes_version" {
  description = "the kubernetes versions of the clusters"
  default     = "1.27.3"
}

variable "kubernetes" {
  description = "the kubernetes clusters"
  default     = "kind"
}