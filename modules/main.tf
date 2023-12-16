module "commons" {
  source = "./common"

}

module "argocd" {
  depends_on = [
    module.commons
  ]

  source = "./argocd"

}

data "kubectl_file_documents" "file" {
    depends_on = [module.argocd]

    content = file("${path.module}/../gitops/bootstrap/argo-bootstrap.yaml")
}

resource "kubectl_manifest" "apl" {
    count     = length(data.kubectl_file_documents.file.documents)
    yaml_body = element(data.kubectl_file_documents.file.documents, count.index)
}
