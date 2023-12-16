terraform {
  required_version = ">=1.1.5"
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




