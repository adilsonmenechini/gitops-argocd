terraform {
  required_version = ">=1.1.5"
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "kind-gitops"
  }
}


provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "kind-gitops"
}




