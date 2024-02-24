terraform {
  required_version = ">=1.1.5"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }  
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = var.kube_name
  }
}


provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = var.kube_name
}