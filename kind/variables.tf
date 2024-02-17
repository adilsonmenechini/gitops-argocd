variable "cluster_counts" {
  description = "Número de clusters"
  type        = number
  default     = 3  
}


variable "cluster_name" {
  description = "clusters names"
  default     = "k8s"
}

variable "worker_counts" {
  description = "worker counts"
  type        = number
  default     = 2  
}



variable "kubernetes_version" {
  description = "the kubernetes versions of the clusters"
  default     = "1.27.3"
}

variable "kubernetes" {
  description = "the kubernetes clusters"
  default     = "kind"
}