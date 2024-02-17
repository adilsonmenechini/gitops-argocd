terraform {
  required_version = ">=1.1.5"
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}

data "kubectl_file_documents" "file" {
  content = file("${path.module}/../../../gitops/bootstrap/argo-bootstrap.yaml")
}

resource "kubectl_manifest" "apl" {
  count     = length(data.kubectl_file_documents.file.documents)
  yaml_body = element(data.kubectl_file_documents.file.documents, count.index)
}